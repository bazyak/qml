import QtQuick 2.15
import QtQuick.Controls 2.15

GroupBox
{
    id: control

    background: Rectangle
    {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
        color: 'transparent'
        border.color: 'hotpink'
        radius: 2
    }

    label: Label
    {
        anchors.bottom: control.top
        x: control.leftPadding
        width: control.availableWidth
        text: control.title
        color: 'hotpink'
        elide: Text.ElideRight
    }
}
