import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import 'qml'
import 'js/FetchData.js' as Rates
import Constants

Window
{
    property string rateString: qsTr('Курс %1 к %2: %3')

    id: root
    width: Const.kWidth
    height: Const.kHeight
    minimumWidth: Const.kWidth * 0.5
    minimumHeight: Const.kHeight
    maximumWidth: Const.kWidth * 1.5
    maximumHeight: Const.kHeight
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    title: Const.kWindowTitle

    Component.onCompleted: Rates.fetchData(source, dest, Const.kSourceCurr, Const.kDestCurr)

    Column
    {
        id: main
        anchors.fill: parent
        spacing: Const.kSpacing
        padding: Const.kSpacing

        Row
        {
            width: parent.width - parent.padding * 2
            height: Const.kRowHeight
            spacing: Const.kSpacing

            CustomTextField
            {
                id: sourceAmount
                width: (parent.width - parent.spacing) / 2
                focus: true
                validator: RegularExpressionValidator { regularExpression: /(\d+)([.]\d{1,2})?$/ }

                onTextEdited: Rates.updateAmount(dest, source, destAmount, sourceAmount)
            }

            CustomComboBox
            {
                id: source
                width: (parent.width - parent.spacing) / 2
                textRole: 'key'
                valueRole: 'value'
                model: ListModel { }
                currentIndex: 0

                onCustomActivated: function(index, prevIndex)
                {
                    if (index == dest.currentIndex)
                    {
                        Rates.updateIndex(dest, prevIndex)
                    }
                    Rates.updateAmount(dest, source, destAmount, sourceAmount)
                }
            }
        }

        Row
        {
            width: parent.width - parent.padding * 2
            height: Const.kRowHeight
            spacing: Const.kSpacing

            CustomTextField
            {
                id: destAmount
                width: (parent.width - parent.spacing) / 2
                validator: RegularExpressionValidator { regularExpression: /(\d+)([.]\d{1,2})?$/ }

                onTextEdited: Rates.updateAmount(source, dest, sourceAmount, destAmount)
            }

            CustomComboBox
            {
                id: dest
                width: (parent.width - parent.spacing) / 2
                textRole: 'key'
                valueRole: 'value'
                model: ListModel { }
                currentIndex: 0

                onCustomActivated: function(index, prevIndex)
                {
                    if (index == source.currentIndex)
                    {
                        Rates.updateIndex(source, prevIndex)
                    }
                    Rates.updateAmount(dest, source, destAmount, sourceAmount)
                }
            }
        }

        Row
        {
            width: parent.width - parent.padding * 2
            height: Const.kRowHeight

            Label
            {
                id: currRate
                text: rateString.arg(source.currentText).arg(dest.currentText).arg(Rates.currentRate(source, dest))
                horizontalAlignment: Text.AlignRight
                rightPadding: Const.kSpacing
                font.bold: true
                font.pointSize: Const.kLabelFontSize
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: Const.kLabelColor
            }
        }

        Row
        {
            width: parent.width - parent.padding * 2
            height: Const.kRowHeight

            CustomButton
            {
                id: swapCurrencies
                text: Const.kSwapButtonText
                width: Const.kSwapButtonWidth
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                onClicked:
                {
                    const index = source.currentIndex
                    Rates.updateIndex(source, dest.currentIndex)
                    Rates.updateIndex(dest, index)
                    Rates.updateAmount(dest, source, destAmount, sourceAmount)
                }
            }
        }
    }
}
