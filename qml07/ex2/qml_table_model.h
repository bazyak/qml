#pragma once
#include <qqml.h>
#include <QObject>
#include <QAbstractTableModel>
#include <QVector>
#include <QVariantList>

class QModelIndex;

class QMLTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit QMLTableModel(QObject* parent = nullptr);

    int rowCount(QModelIndex const& index) const override;
    int columnCount(QModelIndex const& index) const override;
    QVariant data(QModelIndex const& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    void appendRowElement(QVariantList const& element);

private:
    static int const kColumnCount = 4;

    QVector<QVariantList> m_data;
};
