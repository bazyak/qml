#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "date_calc.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ex1/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<DateCalc>("com.bazyak.DateCalc", 1, 0, "DateCalc");

    engine.load(url);

    return app.exec();
}
