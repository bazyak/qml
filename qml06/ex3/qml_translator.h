#pragma once

#include <QObject>
#include <QTranslator>

class QString;

class QmlTranslator : public QObject
{
    Q_OBJECT

public:
    explicit QmlTranslator(QObject* parent = nullptr);

signals:
    void languageChanged();

public:
    Q_INVOKABLE
    void setTranslation(QString const& translation);

private:
    QTranslator translator { };
};
