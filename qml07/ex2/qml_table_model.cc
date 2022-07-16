#include "qml_table_model.h"

#include <QAbstractTableModel>
#include <QVariant>
#include <QVector>
#include <QModelIndex>
#include <QByteArray>
#include <QHash>

QMLTableModel::QMLTableModel(QObject* parent) : QAbstractTableModel(parent)
{
}

int QMLTableModel::rowCount(QModelIndex const& index) const
{
    Q_UNUSED(index)
    return m_data.size();
}

int QMLTableModel::columnCount(QModelIndex const& index) const
{
    return index.row() < 0 ? kColumnCount : m_data[index.row()].size();
}

QVariant QMLTableModel::data(QModelIndex const& index, int role) const
{
    int const row = index.row();
    int const column = index.column();
    long const rows = rowCount(index);
    long const columns = columnCount(index);
    if (row >= 0 && row < rows && column >= 0 && column < columns)
    {
        if (role == Qt::DisplayRole || role == Qt::ToolTipRole) return m_data[row][column];
    }
    return QVariant();
}

QHash<int, QByteArray> QMLTableModel::roleNames() const
{
    return { { Qt::DisplayRole, "display" }, { Qt::ToolTipRole, "toolTip" } };
}

void QMLTableModel::appendRowElement(QVariantList const& element)
{
    QAbstractTableModel::beginInsertRows(QModelIndex(), m_data.size(), m_data.size() + 1);
    m_data.push_back(element);
    QAbstractTableModel::endInsertRows();
}
