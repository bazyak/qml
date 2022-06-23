import QtQuick 2.15
import QtQuick.Controls 2.15

RangeSlider
{
    id: control
    width: 200
    first.value: 0.25
    second.value: 0.75

    background: Rectangle
    {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.width
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: '#bdbebf'

        Rectangle
        {
            x: control.first.visualPosition * parent.width
            width: control.second.visualPosition * parent.width - x
            height: parent.height
            color: '#21be2b'
            radius: 2
        }
    }

    first.handle: Rectangle
    {
        x: control.leftPadding + control.first.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 13
        color: control.first.hovered ? '#f0f0f0' : '#f6f6f6'
        border.color: '#bdbebf'
        Text
        {
            font.pointSize: 11
            anchors.centerIn: parent
            text: Math.round(first.value * 100)
            color: 'black'
        }
    }

    second.handle: Rectangle
    {
        x: control.leftPadding + control.second.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 13
        color: control.second.hovered ? '#f0f0f0' : '#f6f6f6'
        border.color: '#bdbebf'
        Text
        {
            font.pointSize: 11
            anchors.centerIn: parent
            text: Math.round(second.value * 100) === Math.round(control.to * 100)
                  ? Math.round(control.to * 100) + '+'
                  : Math.round(second.value * 100)
            color: 'black'
        }
    }
}
