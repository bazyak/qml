import QtQuick 2.15
import QtQuick.Controls 2.15
import Square

Rectangle
{
    width: Constants.width
    height: Constants.height
    color: 'lavenderblush'
    property string title: 'Exercise 2'

    function calculateSquareBySides()
    {
        const a = parseFloat(sideA.text.replace(',', '.'))
        const b = parseFloat(sideB.text.replace(',', '.'))
        const c = parseFloat(sideC.text.replace(',', '.'))

        const p = (a + b + c) / 2
        const s = Math.sqrt(p * (p - a) * (p - b) * (p - c))
        const res = Math.round((s + Number.EPSILON) * 100) / 100

        resultBySides.value = Number.isNaN(res) ? 'undefined' : res
    }

    onFocusChanged:
    {
        sideA.focus = true
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

            CustomTextField
            {
                id: sideA
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr('Side A')
                width: parent.width * 0.8

                validator: DoubleValidator { bottom: 0; decimals: 5; }
                Keys.onReturnPressed: sideB.focus = true
                onTextChanged: calculateSquareBySides()
            }

            CustomTextField
            {
                id: sideB
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr('Side B')
                width: parent.width * 0.8

                validator: DoubleValidator { bottom: 0; decimals: 5; }
                Keys.onReturnPressed: sideC.focus = true
                onTextChanged: calculateSquareBySides()
            }

            CustomTextField
            {
                id: sideC
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr('Side C')
                width: parent.width * 0.8

                validator: DoubleValidator { bottom: 0; decimals: 5; }
                Keys.onReturnPressed: sideA.focus = true
                onTextChanged: calculateSquareBySides()
            }

            Label
            {
                id: resultBySides
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
