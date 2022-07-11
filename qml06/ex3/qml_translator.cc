#include "qml_translator.h"

#include <QApplication>
#include <QString>
#include <QTranslator>
#include <QObject>

QmlTranslator::QmlTranslator(QObject* parent) : QObject(parent)
{
}

void QmlTranslator::setTranslation(QString const& translation)
{
    if (translator.load(":/tr/lang_" + translation + ".qm"))
    {
        qApp->installTranslator(&translator);
    }
    emit languageChanged();
}
