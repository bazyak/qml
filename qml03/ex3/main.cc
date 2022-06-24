#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtGlobal>
#include <QByteArray>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ex3/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
