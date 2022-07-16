import QtQuick 2.15
import QtQuick.Controls 2.15

Popup
{
    property color backgroundColor: '#1C2833'
    property color borderColor: '#1C2833'
    property int borderRadius: 5

    parent: Overlay.overlay
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 400
    height: 100
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle
    {
        anchors.fill: parent
        border.color: borderColor
        color: backgroundColor
        radius: borderRadius
    }
}
