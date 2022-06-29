#pragma once

#include <QObject>
#include <QColor>
#include <QString>
#include <QVector>
#include <QtQml/qqml.h>

#include "auto_property.h"

namespace ChartType
{
Q_NAMESPACE

enum Type
{
    SinX = 0,
    X,
    XWithCoeff,
    Quad,
    Log2
};
Q_ENUM_NS(Type)

}

class ChartsBackend : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ChartsBackend)
    QML_EXTENDED_NAMESPACE(ChartType)

    AUTO_PROPERTY(QColor, color)
    AUTO_PROPERTY(QString, title)
    AUTO_PROPERTY(ChartType::Type, type)
    READONLY_PROPERTY(QVector<qreal>, vectorX)
    READONLY_PROPERTY(QVector<QString>, allTitles)
    READONLY_PROPERTY_WITH_SIGNAL(QVector<qreal>, vectorY)

public:
    explicit ChartsBackend(QObject* parent = nullptr);

private:
    void updateChart(ChartType::Type newType);

    QVector<QColor> m_allColors { };
};
