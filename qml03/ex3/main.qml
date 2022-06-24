import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window
{
    width: 520
    height: 600
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    title: qsTr('Lesson 03 - Exercise 3')

    Item
    {
        anchors.fill: parent
        SortListModel
        {
            id: books
            sortColumnName: 'genre'
            order: 'desc'

            Component.onCompleted:
            {
                const request = new XMLHttpRequest();
                request.open("GET", 'qrc:/data/books.json', false);
                request.send(null)
                const data = JSON.parse(request.responseText);

                const list = data['books'];
                for (var i in list)
                {
                    append({
                        icon: list[i]['icon'],
                        title: list[i]['title'],
                        genre: list[i]['genre'],
                        author: list[i]['author']})
                }
                quickSort()
            }
        }

        ListView
        {
            id: list
            anchors.fill: parent
            model: books
            spacing: 2
            ScrollBar.vertical: ScrollBar
            {
                id: lane
                visible: false

                Timer
                {
                    id: timer
                    interval: 1000
                    onTriggered: lane.visible = false
                }

                onActiveChanged:
                {
                    if (active)
                    {
                        timer.stop()
                        visible = true
                    }
                    else timer.restart()
                }
            }

            header: Rectangle
            {
                width: parent.width
                height: 40
                color: 'darkturquoise'

                Text
                {
                    anchors.centerIn: parent
                    font.pointSize: 16
                    text: 'Библиотека скучного человека'
                    color: 'white'
                }
            }

            footer: Rectangle
            {
                width: parent.width
                height: 40
                color: 'darkturquoise'

                Text
                {
                    anchors.centerIn: parent
                    text: 'Powered by Ruslan Bazyak'
                    color: 'white'
                }
            }

            section.delegate: Rectangle
            {
                width: parent.width
                height: 25
                color: 'paleturquoise'

                Text
                {
                    anchors.centerIn: parent
                    text: section
                    color: 'royalblue'
                    font.weight: Font.Bold
                }
            }
            section.property: 'genre'

            delegate: Rectangle
            {
                width: list.width
                height: 120
                color: 'whitesmoke'

                Row
                {
                    anchors.fill: parent
                    spacing: 20

                    Image
                    {
                        source: icon
                        fillMode: Image.PreserveAspectFit
                        width: parent.width / 4
                        height: parent.height
                    }

                    Column
                    {
                        Label
                        {
                            height: 40
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 20
                            font.bold: true
                            text: title
                        }

                        Label
                        {
                            height: 40
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 16
                            text: author
                        }

                        Label
                        {
                            height: 40
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 10
                            text: genre
                        }
                    }
                }
            }

            focus: true

            add: Transition
            {
                NumberAnimation
                {
                    property: 'y'
                    duration: 1500
                    easing.type: Easing.OutExpo
                }
            }
        }
    }
}
