import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 480
    height: 480
    visible: true
    color: 'lavenderblush'
    title: qsTr('Lesson 01 - Exercise 3')

    function calculateSquare()
    {
        const xa = parseInt(xA.text)
        const ya = parseInt(yA.text)
        const xb = parseInt(xB.text)
        const yb = parseInt(yB.text)
        const xc = parseInt(xC.text)
        const yc = parseInt(yC.text)

        const a = Math.sqrt((xb - xa)*(xb - xa) + (yb - ya)*(yb - ya))
        const b = Math.sqrt((xc - xb)*(xc - xb) + (yc - yb)*(yc - yb))
        const c = Math.sqrt((xa - xc)*(xa - xc) + (ya - yc)*(ya - yc))

        const p = (a + b + c) / 2
        const s = Math.sqrt(p * (p - a) * (p - b) * (p - c))
        const res = Math.round(s * 100) / 100

        result.value = Number.isNaN(res) ? 'undefined' : res
    }

    Rectangle
    {
        id: frame
        width: 300
        height: 300
        anchors.centerIn: parent
        color: 'white'
        radius: 5

        Column
        {
            anchors.fill: parent
            padding: 32
            spacing: 32

            Row
            {
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8

                TextField
                {
                    id: xA
                    anchors.left: parent.left
                    placeholderText: qsTr('Xa')
                    width: parent.width * 0.45
                    height: 40
                    leftPadding: 12
                    topPadding: 12
                    selectByMouse: true
                    background: Rectangle
                    {
                        color: xA.enabled ? 'transparent' : 'whitesmoke'
                        border.color: xA.enabled ? '#21be2b' : 'transparent'
                    }

                    validator: IntValidator { }
                    focus: true
                    Keys.onReturnPressed: yA.focus = true
                    onTextChanged: calculateSquare()
                }

                TextField
                {
                    id: yA
                    anchors.right: parent.right
                    placeholderText: qsTr('Ya')
                    width: parent.width * 0.45
                    height: 40
                    leftPadding: 12
                    topPadding: 12
                    selectByMouse: true
                    background: Rectangle
                    {
                        color: yA.enabled ? 'transparent' : 'whitesmoke'
                        border.color: yA.enabled ? '#21be2b' : 'transparent'
                    }

                    validator: IntValidator { }
                    Keys.onReturnPressed: xB.focus = true
                    onTextChanged: calculateSquare()
                }
            }

            Row
            {
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8

                TextField
                {
                    id: xB
                    anchors.left: parent.left
                    placeholderText: qsTr('Xb')
                    width: parent.width * 0.45
                    height: 40
                    leftPadding: 12
                    topPadding: 12
                    selectByMouse: true
                    background: Rectangle
                    {
                        color: xB.enabled ? 'transparent' : 'whitesmoke'
                        border.color: xB.enabled ? '#21be2b' : 'transparent'
                    }

                    validator: IntValidator { }
                    focus: true
                    Keys.onReturnPressed: yB.focus = true
                    onTextChanged: calculateSquare()
                }

                TextField
                {
                    id: yB
                    anchors.right: parent.right
                    placeholderText: qsTr('Yb')
                    width: parent.width * 0.45
                    height: 40
                    leftPadding: 12
                    topPadding: 12
                    selectByMouse: true
                    background: Rectangle
                    {
                        color: yB.enabled ? 'transparent' : 'whitesmoke'
                        border.color: yB.enabled ? '#21be2b' : 'transparent'
                    }

                    validator: IntValidator { }
                    Keys.onReturnPressed: xC.focus = true
                    onTextChanged: calculateSquare()
                }
            }

            Row
            {
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8

                TextField
                {
                    id: xC
                    anchors.left: parent.left
                    placeholderText: qsTr('Xc')
                    width: parent.width * 0.45
                    height: 40
                    leftPadding: 12
                    topPadding: 12
                    selectByMouse: true
                    background: Rectangle
                    {
                        color: xC.enabled ? 'transparent' : 'whitesmoke'
                        border.color: xC.enabled ? '#21be2b' : 'transparent'
                    }

                    validator: IntValidator { }
                    focus: true
                    Keys.onReturnPressed: yC.focus = true
                    onTextChanged: calculateSquare()
                }

                TextField
                {
                    id: yC
                    anchors.right: parent.right
                    placeholderText: qsTr('Yc')
                    width: parent.width * 0.45
                    height: 40
                    leftPadding: 12
                    topPadding: 12
                    selectByMouse: true
                    background: Rectangle
                    {
                        color: yC.enabled ? 'transparent' : 'whitesmoke'
                        border.color: yC.enabled ? '#21be2b' : 'transparent'
                    }

                    validator: IntValidator { }
                    Keys.onReturnPressed: xA.focus = true
                    onTextChanged: calculateSquare()
                }
            }

            Label
            {
                id: result
                property string value: 'undefined'
                text: qsTr('S = ' + value)
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8
                height: 40
                color: '#21be2b'
            }
        }
    }
}
