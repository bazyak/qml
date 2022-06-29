#include "charts_backend.h"

#include <QObject>
#include <QColor>
#include <QString>
#include <QVector>

#include <cmath>

ChartsBackend::ChartsBackend(QObject* parent) : QObject(parent)
{
    m_allTitles = { "у = sin(x)", "у = x", "у = |x - 2.5|", "у = x^2", "у = log2(x)" };
    m_allColors = { "darkorange", "darkviolet", "lightcoral", "magenta", "limegreen" };

    for (auto i = 0; i < 51; ++i)
    {
        m_vectorX.push_back(i / 10.);
    }
    connect(this, &ChartsBackend::typeChanged, this, [this](auto type) { updateChart(type); });
}

void ChartsBackend::updateChart(ChartType::Type newType)
{
    title(m_allTitles[newType]);
    color(m_allColors[newType]);

    m_vectorY.clear();
    for (auto const& x : vectorX())
    {
        qreal y;
        switch (type())
        {
        case ChartType::SinX:
            y = qSin(x);
            break;
        case ChartType::X:
            y = x;
            break;
        case ChartType::XWithCoeff:
            y = qAbs(x - 2.5);
            break;
        case ChartType::Quad:
            y = x*x;
            break;
        case ChartType::Log2:
            y = qLn(x) / qLn(2);
            break;
        default:
            break;
        }
        m_vectorY.push_back(y);
    }
    emit vectorYChanged(m_vectorY);
}
