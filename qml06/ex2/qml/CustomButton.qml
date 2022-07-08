import QtQuick 2.15
import QtQuick.Controls 2.15

Button
{
    id: control
    width: 100
    height: 40

    property color mainColor: 'darkturquoise'
    property color hoveredColor: 'darkgray'

    contentItem: Text
    {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.hovered ? control.hoveredColor : control.mainColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle
    {
        implicitWidth: control.width
        implicitHeight: control.height
        opacity: enabled ? 1 : 0.3
        border.color: control.hovered ? control.hoveredColor : control.mainColor
        border.width: 1
        radius: 2
    }
}
