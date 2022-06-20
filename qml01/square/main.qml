import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Square

Window
{
    id: root
    width: Constants.width
    height: Constants.height + toolBar.height
    title: qsTr('Lesson 01')
    visible: true

    ToolBar
    {
        id: toolBar
        anchors.right: parent.right
        anchors.left: parent.left
        contentHeight: toolButton.implicitHeight
        background: Rectangle
        {
            implicitHeight: 40
            color: '#eeeeee'

            Rectangle
            {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: 'transparent'
                border.color: '#21be2b'
            }
        }

        ToolButton
        {
            id: toolButton
            text: stackView.depth > 1 ? '\u25C0' : '\u2630'
            font: Constants.largeFont

            contentItem: Text
            {
                text: toolButton.text
                font: toolButton.font
                opacity: enabled ? 1.0 : 0.3
                color: toolButton.hovered ? '#17a81a' : '#21be2b'
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle
            {
                implicitWidth: 40
                implicitHeight: 40
                color: Qt.darker('#33333333', toolButton.enabled && (toolButton.checked || toolButton.highlighted) ? 1.5 : 1.0)
                opacity: enabled ? 1 : 0.3
                visible: toolButton.down || (toolButton.enabled && (toolButton.checked || toolButton.highlighted))
            }

            onClicked:
            {
                if (stackView.depth > 1)
                {
                    stackView.pop()
                }
                else
                {
                    drawer.open()
                }
            }
        }

        Label
        {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    StackView
    {
        id: stackView
        anchors.top: toolBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        initialItem: Screen01 { }

        onCurrentItemChanged:
        {
            currentItem.forceActiveFocus()
        }

        popEnter: Transition
        {
            XAnimator
            {
                from: (stackView.mirrored ? -1 : 1) * - stackView.width
                to: 0
                duration: 400
                easing.type: Easing.OutCubic
            }
        }

        popExit: Transition
        {
            XAnimator
            {
                from: 0
                to: (stackView.mirrored ? -1 : 1) * stackView.width
                duration: 400
                easing.type: Easing.OutCubic
            }
        }
    }

    Drawer
    {
        id: drawer
        width: root.width * 0.33
        height: root.height

        background: Rectangle
        {
            Rectangle
            {
                x: parent.width - 1
                width: 1
                height: parent.height
                color: '#21be2b'
            }
        }

        Column
        {
            anchors.fill: parent

            CustomItemDelegate
            {
                text: qsTr('Exercise 2')
                width: parent.width
                height: 40
                onClicked:
                {
                    stackView.push('Screen02.qml')
                    drawer.close()
                }
            }

            CustomItemDelegate
            {
                text: qsTr('Exercise 3')
                width: parent.width
                height: 40
                onClicked:
                {
                    stackView.push('Screen03.qml')
                    drawer.close()
                }
            }
        }
    }
}

