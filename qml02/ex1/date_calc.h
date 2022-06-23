#pragma once

#include <QObject>

class QString;

class DateCalc : public QObject
{
    Q_OBJECT

public:
    DateCalc() = default;
    Q_INVOKABLE
    int diff(QString const& beginStr, QString const& endStr);

signals:
    void differenceResult(int years, int months, int days);
};
