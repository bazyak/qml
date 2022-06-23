import QtQuick 2.15
import QtQuick.Controls 2.15

Button
{
    id: control
    width: 100
    height: 40

    contentItem: Text
    {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.hovered ? '#17a81a' : '#21be2b'
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle
    {
        implicitWidth: control.width
        implicitHeight: control.height
        opacity: enabled ? 1 : 0.3
        border.color: control.hovered ? '#17a81a' : '#21be2b'
        border.width: 1
        radius: 2
    }
}
