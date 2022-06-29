#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "charts_backend.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    ChartsBackend chartsBackend;

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("chartsBackend", &chartsBackend);
    engine.load(url);

    return app.exec();
}
