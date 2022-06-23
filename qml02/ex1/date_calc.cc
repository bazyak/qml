#include "date_calc.h"

#include <QString>
#include <QDate>
#include <QDebug>

int DateCalc::diff(QString const& beginStr, QString const& endStr)
{
    auto begin = QDate::fromString(beginStr, "d.M.yyyy");
    auto end = QDate::fromString(endStr, "d.M.yyyy");

    int years = 0, months = 0, days = 0;
    auto countDown = [&]() { --years; months += 12; };

    if (begin.daysTo(end) > 0)
    {
        years = end.year() - begin.year();
        months = end.month() - begin.month();
        if (months < 0)
        {
            countDown();
        }
        days = end.day() - begin.day();
        if (days < 0)
        {
            if (--months < 0)
            {
                countDown();
            }
            days += begin.daysInMonth();
        }
    }
    emit differenceResult(years, months, days);
    return years;
}
