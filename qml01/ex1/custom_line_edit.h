#pragma once

#include <QObject>
#include <QLineEdit>
#include <QColor>

// solution 2 - line edit with custom property and applying new color via palette
class CustomLineEdit : public QLineEdit
{
    Q_OBJECT
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)

public:
    CustomLineEdit(QWidget* parent = nullptr);
    void setTextColor(QColor const& color);
    QColor textColor() const;

signals:
    void textColorChanged(QColor const& color);

private:
    QColor color { };
};
