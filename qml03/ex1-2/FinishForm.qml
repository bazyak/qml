import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: finishForm
    color: 'white'
    anchors.centerIn: parent
    radius: 5
    width: 300
    height: 250
    property string textColor: '#535353'

    Column
    {
        anchors.fill: parent
        padding: 32
        spacing: 32

        Label
        {
            anchors.centerIn: parent
            font.bold: true
            color: textColor
            text: 'Поиск завершён'
        }
    }
}
