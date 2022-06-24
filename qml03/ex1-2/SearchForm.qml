import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: searchForm
    color: 'white'
    anchors.centerIn: parent
    radius: 5
    width: 300
    height: 250

    signal searchFinished
    signal searchCanceled

    Column
    {
        anchors.fill: parent
        padding: 32
        spacing: 32

        CustomBusyIndicator
        {
            anchors.horizontalCenter: parent.horizontalCenter
            busyColor: 'darkturquoise'
        }

        Timer
        {
            running: searchForm.visible
            interval: 5000
            onTriggered: searchFinished()
        }

        Button
        {
            id: cancelButton
            width: parent.width - parent.padding * 2
            height: 40
            background: Rectangle
            {
                color: parent.down ? '#bbbbbb' : (parent.hovered ? '#d6d6d6' : '#f6f6f6')
            }
            text: qsTr('Отменить поиск')
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: searchCanceled()
        }
    }
}
