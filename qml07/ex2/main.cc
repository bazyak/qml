#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStringList>

#include "qml_table_model.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/qml");
    const QUrl url(u"qrc:/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QMLTableModel model;

    model.appendRowElement({ 1, "Ivan", "Ivanov", QStringList { "Sergey Stepanov", "Egor Potapov" } });
    model.appendRowElement({ 2, "Egor", "Svistov", QStringList { "Alexander Zotov", "Friend with a really long name that need to be truncated", "Elena Ivanova" } });
    model.appendRowElement({ 3, "Stepan", "Tok", QStringList { "Ivan Ivanov", "Alexander Zotov", "Elena Ivanova" } });
    engine.rootContext()->setContextProperty("mdl", &model);

    engine.load(url);

    return app.exec();
}
