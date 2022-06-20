#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/imports");
    const QUrl url(u"qrc:/square/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

//    QQuickView view;
//    view.engine()->addImportPath("qrc:/qml/imports");
//    view.setSource(QUrl("qrc:/qml/ProgressBar.ui.qml"));
//    if (!view.errors().isEmpty())
//        return -1;
//    view.show();

    return app.exec();
}
