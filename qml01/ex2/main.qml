import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 480
    height: 480
    visible: true
    color: 'lavenderblush'
    title: qsTr('Lesson 01 - Exercise 2')

    function calculateSquare()
    {
        const a = parseFloat(sideA.text.replace(",", "."))
        const b = parseFloat(sideB.text.replace(",", "."))
        const c = parseFloat(sideC.text.replace(",", "."))

        const p = (a + b + c) / 2
        const s = Math.sqrt(p * (p - a) * (p - b) * (p - c))
        const res = Math.round((s + Number.EPSILON) * 100) / 100

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

            TextField
            {
                id: sideA
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr('Side A')
                width: parent.width * 0.8
                height: 40
                leftPadding: 12
                topPadding: 12
                selectByMouse: true
                background: Rectangle
                {
                    color: sideA.enabled ? 'transparent' : 'whitesmoke'
                    border.color: sideA.enabled ? '#21be2b' : 'transparent'
                }

                validator: DoubleValidator { bottom: 0; decimals: 5; }
                focus: true
                Keys.onReturnPressed: sideB.focus = true
                onTextChanged: calculateSquare()
            }

            TextField
            {
                id: sideB
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr('Side B')
                width: parent.width * 0.8
                height: 40
                leftPadding: 12
                topPadding: 12
                selectByMouse: true
                background: Rectangle
                {
                    color: sideB.enabled ? 'transparent' : 'whitesmoke'
                    border.color: sideB.enabled ? '#21be2b' : 'transparent'
                }

                validator: DoubleValidator { bottom: 0; decimals: 5; }
                Keys.onReturnPressed: sideC.focus = true
                onTextChanged: calculateSquare()
            }

            TextField
            {
                id: sideC
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr('Side C')
                width: parent.width * 0.8
                height: 40
                leftPadding: 12
                topPadding: 12
                selectByMouse: true
                background: Rectangle
                {
                    color: sideC.enabled ? 'transparent' : 'whitesmoke'
                    border.color: sideC.enabled ? '#21be2b' : 'transparent'
                }

                validator: DoubleValidator { bottom: 0; decimals: 5; }
                Keys.onReturnPressed: sideA.focus = true
                onTextChanged: calculateSquare()
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
