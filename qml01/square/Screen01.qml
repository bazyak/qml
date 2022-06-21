import QtQuick 2.15
import QtQuick.Controls 2.15
import Square

Rectangle
{
    width: Constants.width
    height: Constants.height
    color: 'lavenderblush'
    property string title: ''

    Rectangle
    {
        id: frame
        width: 300
        height: 50
        anchors.centerIn: parent
        color: 'white'
        radius: 5

        Label
        {
            text: qsTr('Press burger button to get an action')
            anchors.centerIn: parent
            font.bold: true
            color: '#21be2b'
        }
    }
}
