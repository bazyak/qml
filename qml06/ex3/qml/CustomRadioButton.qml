import QtQuick 2.15
import QtQuick.Controls 2.15

RadioButton
{
    property color mainColor: 'darkturquoise'
    property color colorHovered: 'lightgray'

    id: control
    checked: true

    indicator: Rectangle
    {
        implicitWidth: 26
        implicitHeight: 26
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        border.color: control.hovered ? mainColor : colorHovered

        Rectangle
        {
            width: 14
            height: 14
            x: 6
            y: 6
            radius: 7
            color: control.hovered ? mainColor : colorHovered
            visible: control.checked
        }
    }

    contentItem: Text
    {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.hovered ? mainColor : colorHovered
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
