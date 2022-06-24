import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: loggedForm
    color: 'white'
    anchors.centerIn: parent
    radius: 5
    width: 300
    height: 250
    property string textColor: '#535353'

    signal searchStarted

    Column
    {
        anchors.fill: parent
        padding: 32
        spacing: 32

        Label
        {
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            color: textColor
            text: 'Поисковая машина'
        }

        Button
        {
            id: searchButton
            width: parent.width - parent.padding * 2
            height: 40
            background: Rectangle
            {
                color: parent.down ? '#bbbbbb' : (parent.hovered ? '#d6d6d6' : '#f6f6f6')
            }
            text: qsTr('Начать поиск')
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: searchStarted()
        }
    }
}
