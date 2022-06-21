#include "custom_line_edit.h"

#include <QColor>
#include <QPalette>
#include <QLineEdit>

CustomLineEdit::CustomLineEdit(QWidget* parent) : QLineEdit(parent)
{
}

void CustomLineEdit::setTextColor(QColor const& color)
{
    this->color = color;
    auto palette = this->palette();
    palette.setColor(QPalette::Text, color);
    this->setPalette(palette);

    emit textColorChanged(color);
}

QColor CustomLineEdit::textColor() const
{
    return color;
}
