#pragma once

#include <QObject>
#include <QtQml/qqml.h>

#include "auto_property.h"

class LsmService : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(LsmService)

    AUTO_PROPERTY(QVector<qreal>, scatterVectorX)
    AUTO_PROPERTY(QVector<qreal>, scatterVectorY)
    READONLY_PROPERTY(QVector<qreal>, lineVectorX)
    READONLY_PROPERTY_WITH_SIGNAL(QVector<qreal>, lineVectorY)

public:
    explicit LsmService(QObject* parent = nullptr);

    Q_INVOKABLE
    void calcLsm();

private:
};
