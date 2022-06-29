#include "lsm_service.h"

#include <QObject>

#include <algorithm>

LsmService::LsmService(QObject* parent) : QObject(parent)
{
}

void LsmService::calcLsm()
{
    m_lineVectorX.clear();
    m_lineVectorY.clear();
    auto const len = m_scatterVectorX.length();
    if (m_scatterVectorY.length() != len || len < 2)
    {
        emit lineVectorYChanged(m_lineVectorY);
        return;
    }

    double sumX = 0;
    double sumY = 0;
    double sumXY = 0;
    double sumXX = 0;

    for (auto i = 0; i < len; ++i)
    {
        sumX += m_scatterVectorX[i];
        sumY += m_scatterVectorY[i];
        sumXY += m_scatterVectorX[i] * m_scatterVectorY[i];
        sumXX += m_scatterVectorX[i] * m_scatterVectorX[i];
    }
    double det = 0;
    double a = 0;
    double b = 0;

    det = sumXX * len - sumX * sumX;
    a = (sumXY * len - sumY * sumX) / det;
    b = (sumXX * sumY - sumXY * sumX) / det;

    auto const minX = *std::min_element(std::begin(m_scatterVectorX), std::end(m_scatterVectorX));
    auto const maxX = *std::max_element(std::begin(m_scatterVectorX), std::end(m_scatterVectorX));
    auto const stepX = (maxX - minX + 10) / len;
    auto x = minX - 5;
    for (auto i = 0; i <= len; ++i, x += stepX)
    {
        m_lineVectorX.push_back(x);
        m_lineVectorY.push_back(a * x + b);
    }

    emit lineVectorYChanged(m_lineVectorY);
}
