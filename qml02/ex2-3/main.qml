import QtQuick 2.15
import QtQuick.Window 2.15

Window
{
    readonly property int kSize: 480

    width: kSize
    height: kSize
    maximumHeight: Screen.desktopAvailableHeight * 0.8
    maximumWidth: Screen.desktopAvailableHeight * 0.8
    minimumHeight: kSize * 0.5
    minimumWidth: kSize * 0.5
    visible: true
    title: qsTr('Lesson 02 - Exercises 2 & 3')

    Rectangle
    {
        id: rect
        height: parent.height * 0.6
        width: height
        anchors.centerIn: parent
        antialiasing: true
        color: 'lavenderblush'

        RotationAnimation
        {
            id: rotate
            target: rect;
            from: 0;
            to: 360;
            duration: 2000
        }

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            Timer
            {
                id: timer
                interval: 200
                onTriggered: rect.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            }

            onClicked: (mouse) =>
            {
                if (mouse.button === Qt.RightButton)
                {
                    if (!rect.radius)
                    {
                        rotate.start()
                    }
                    return
                }

                if (timer.running)
                {
                    rect.radius = !rect.radius ? rect.width / 2 : 0
                    timer.stop()
                }
                else
                {
                    timer.restart()
                }
            }
        }
    }
}
