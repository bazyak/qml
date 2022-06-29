#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "lsm_service.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    LsmService lsmService;

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("lsmService", &lsmService);
    engine.load(url);

    return app.exec();
}
