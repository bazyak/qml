import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Window {
    width: 480
    height: 640
    visible: true
    color: 'lavenderblush'
    title: qsTr('Lesson 02 - Exercise 1 - Registration form')

    function printAllDataToConsole()
    {

    }

    Rectangle
    {
        id: frame
        width: parent.width * 0.9
        height: parent.height * 0.9
        anchors.centerIn: parent
        color: 'white'
        radius: 5

        Column
        {
            anchors.fill: parent
            padding: 32
            spacing: 20

            Row
            {
                width: parent.width - parent.padding * 2
                height: 40

                Label
                {
                    text: qsTr('Имя: ')
                    horizontalAlignment: Text.AlignRight
                    rightPadding: 20
                    font.bold: true
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 3
                    color: '#21be2b'
                }

                CustomTextField
                {
                    id: name
                    anchors.right: parent.right
                    width: parent.width * 2 / 3
                    placeholderText: qsTr('Как вас зовут?')
                    focus: true

                    validator: RegularExpressionValidator { regularExpression: /(\w+)/ }
                    Keys.onReturnPressed: sex.focus = true
                }
            }

            Row
            {
                width: parent.width - parent.padding * 2
                height: 40

                Label
                {
                    text: qsTr('Пол: ')
                    horizontalAlignment: Text.AlignRight
                    rightPadding: 20
                    font.bold: true
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width / 3
                    color: '#21be2b'
                }

                ComboBox
                {
                    id: sex
                    anchors.right: parent.right
                    width: parent.width * 2 / 3
                    placeholderText: qsTr('Кто вы?')
                    focus: true

                    validator: RegularExpressionValidator { regularExpression: /(\w+)/ }
                    Keys.onReturnPressed: age.focus = true
                }
            }
        }
    }
}
