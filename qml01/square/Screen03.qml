import QtQuick 2.15
import QtQuick.Controls 2.15
import Square

Rectangle
{
    width: Constants.width
    height: Constants.height
    color: 'lavenderblush'
    property string title: 'Exercise 3'

    function calculateSquareByPoints()
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

        resultByPoints.value = Number.isNaN(res) ? 'undefined' : res
    }

    onFocusChanged:
    {
        xA.focus = true
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

                CustomTextField
                {
                    id: xA
                    anchors.left: parent.left
                    placeholderText: qsTr('Xa')
                    width: parent.width * 0.45
                    focus: true

                    validator: IntValidator { }
                    Keys.onReturnPressed: yA.focus = true
                    onTextChanged: calculateSquareByPoints()
                }

                CustomTextField
                {
                    id: yA
                    anchors.right: parent.right
                    placeholderText: qsTr('Ya')
                    width: parent.width * 0.45

                    validator: IntValidator { }
                    Keys.onReturnPressed: xB.focus = true
                    onTextChanged: calculateSquareByPoints()
                }
            }

            Row
            {
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8

                CustomTextField
                {
                    id: xB
                    anchors.left: parent.left
                    placeholderText: qsTr('Xb')
                    width: parent.width * 0.45

                    validator: IntValidator { }
                    Keys.onReturnPressed: yB.focus = true
                    onTextChanged: calculateSquareByPoints()
                }

                CustomTextField
                {
                    id: yB
                    anchors.right: parent.right
                    placeholderText: qsTr('Yb')
                    width: parent.width * 0.45

                    validator: IntValidator { }
                    Keys.onReturnPressed: xC.focus = true
                    onTextChanged: calculateSquareByPoints()
                }
            }

            Row
            {
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.8

                CustomTextField
                {
                    id: xC
                    anchors.left: parent.left
                    placeholderText: qsTr('Xc')
                    width: parent.width * 0.45

                    validator: IntValidator { }
                    Keys.onReturnPressed: yC.focus = true
                    onTextChanged: calculateSquareByPoints()
                }

                CustomTextField
                {
                    id: yC
                    anchors.right: parent.right
                    placeholderText: qsTr('Yc')
                    width: parent.width * 0.45

                    validator: IntValidator { }
                    Keys.onReturnPressed: xA.focus = true
                    onTextChanged: calculateSquareByPoints()
                }
            }

            Label
            {
                id: resultByPoints
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
