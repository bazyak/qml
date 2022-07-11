#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "qml_translator.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlTranslator qmlTranslator;

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/qml");
    engine.rootContext()->setContextProperty("qmlTranslator", &qmlTranslator);

    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
