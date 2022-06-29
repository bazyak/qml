import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import com.bazyak.LsmService 1.0
import "qml"
import "js/PaintFuncs.js" as Painter

Window
{
    readonly property int kModelCount: 8
    readonly property int kInputWidth: 80
    readonly property int kRowHeight: 40
    readonly property int kChartSpace: 120
    readonly property int kSpacing: 20
    readonly property int kMaxWidth: Screen.desktopAvailableWidth * 0.8
    readonly property int kWidth: Math.min(kModelCount * kInputWidth * 1.5, kMaxWidth) * 0.9
    readonly property int kHeight: kWidth * 0.8
    readonly property string kWindowTitle: qsTr('Lesson 04 - Exercise 2')
    readonly property string kChartTitle: qsTr('Least-Squares method linear dependence')
    readonly property color kScatterColor: 'darkturquoise'
    readonly property color kLineColor: 'darkorange'
    readonly property color kLabelColor: 'gray'
    readonly property string kLabelXText: 'X'
    readonly property string kLabelYText: 'Y'
    readonly property var kInitVectorX: [7, 31, 61, 99, 129, 178, 209]
    readonly property var kInitVectorY: [13, 10, 9, 10, 12, 20, 26]

    width: kWidth
    height: kHeight
    minimumHeight: kHeight
    minimumWidth: kWidth
    maximumHeight: Screen.desktopAvailableHeight * 0.8
    maximumWidth: Screen.desktopAvailableWidth * 0.8
    x: Screen.width / 2 - kWidth / 2
    y: Screen.height / 2 - kHeight / 2
    visible: true
    title: kWindowTitle

    Connections
    {
        target: lsmService
        function onLineVectorYChanged(vector) { Painter.linePaint() }
    }

    Component.onCompleted:
    {
        for(var i = 0; i < kModelCount; ++i)
        {
            repeaterX.itemAt(i).text = kInitVectorX[i]
            repeaterY.itemAt(i).text = kInitVectorY[i]
        }
        Painter.rePaint()
    }

    Column
    {
        anchors.fill: parent
        padding: kSpacing

        Row
        {
            id: coordX
            anchors.horizontalCenter: parent.horizontalCenter
            width: kModelCount * kInputWidth + labelX.width
            height: kRowHeight

            Label
            {
                id: labelX
                text: kLabelXText
                horizontalAlignment: Text.AlignRight
                rightPadding: kSpacing
                font.bold: true
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: kLabelColor
            }

            Repeater
            {
                id: repeaterX
                model: kModelCount

                CustomTextField
                {
                    width: kInputWidth
                    anchors.left: parent.left
                    anchors.leftMargin: labelX.width + modelData * width
                    anchors.verticalCenter: parent.verticalCenter
                    validator: DoubleValidator { }
                    onTextChanged: Painter.rePaint()
                }
            }
        }

        Row
        {
            id: coordY
            anchors.horizontalCenter: parent.horizontalCenter
            width: kModelCount * kInputWidth + labelY.width
            height: kRowHeight

            Label
            {
                id: labelY
                text: kLabelYText
                horizontalAlignment: Text.AlignRight
                rightPadding: kSpacing
                font.bold: true
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: kLabelColor
            }

            Repeater
            {
                id: repeaterY
                model: kModelCount

                CustomTextField
                {
                    width: kInputWidth
                    anchors.left: parent.left
                    anchors.leftMargin: labelY.width + modelData * width
                    anchors.verticalCenter: parent.verticalCenter
                    validator: DoubleValidator { }
                    onTextChanged: Painter.rePaint()
                }
            }
        }

        Item
        {
            width: parent.width - parent.padding * 2
            height: parent.height - coordX.height * 2 - parent.padding
            ChartView
            {
                title: kChartTitle
                anchors.fill: parent
                antialiasing: true
                legend.visible: false

                ValueAxis { id: axisX }
                ValueAxis { id: axisY }

                LineSeries
                {
                    id: lineChart
                    axisX: axisX
                    axisY: axisY
                    color: kLineColor
                }

                ScatterSeries
                {
                    id: scatterChart
                    axisX: axisX
                    axisY: axisY
                    color: kScatterColor
                }
            }
        }
    }
}
