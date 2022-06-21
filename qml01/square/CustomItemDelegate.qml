import QtQuick 2.15
import QtQuick.Controls 2.15

ItemDelegate
{
    property string compName: 'compName'
    id: compName

    contentItem: Text
    {
        rightPadding: compName.spacing
        text: compName.text
        font: compName.font
        color: compName.enabled ? (compName.hovered ? '#17a81a' : '#21be2b') : 'whitesmoke'
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle
    {
        implicitWidth: 100
        implicitHeight: 40
        opacity: compName.enabled ? 1 : 0.3
        color: compName.down ? '#dddedf' : '#eeeeee'

        Rectangle
        {
            width: compName.width
            height: 1
            color: compName.down ? '#17a81a' : '#21be2b'
            anchors.bottom: parent.bottom
        }
    }
}
