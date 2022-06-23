import QtQuick 2.15
import QtQuick.Controls 2.15

Popup
{
    property string errorText: ''

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
        border.color: '#1C2833'
        color: '#1C2833'
        radius: 7
    }

    Text
    {
        text: errorText
        color: 'white'
        width: 300
        anchors.centerIn: parent
        horizontalAlignment: Qt.AlignCenter
        elide: Text.ElideRight
        wrapMode: Text.Wrap
    }
}
