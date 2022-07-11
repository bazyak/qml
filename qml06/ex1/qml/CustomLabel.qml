import QtQuick 2.15
import QtQuick.Controls 2.15

Label
{
    property color mainTextColor: '#21be2b'

    horizontalAlignment: Text.AlignRight
    rightPadding: 20
    font.bold: true
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width / 4
    color: mainTextColor
}
