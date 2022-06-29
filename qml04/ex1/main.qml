import QtQuick 2.15
import com.bazyak.ChartsBackend 1.0
import QtCharts 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "qml"

Window
{
    readonly property int kChartSpace: 120
    readonly property int kSpacing: 20
    readonly property int kWidth: 640
    readonly property int kHeight: 480
    readonly property int kStepSize: 5
    readonly property string kWindowTitle: qsTr('Lesson 04 - Exercise 1')

    width: kWidth
    height: kHeight
    minimumHeight: kHeight * 0.7
    minimumWidth: kWidth * 0.7
    maximumHeight: Screen.desktopAvailableHeight * 0.8
    maximumWidth: Screen.desktopAvailableWidth * 0.8
    x: Screen.width / 2 - kWidth / 2
    y: Screen.height / 2 - kHeight / 2
    visible: true
    title: kWindowTitle

    Connections
    {
        target: chartsBackend
        function onVectorYChanged(vector)
        {
            lineChart.removePoints(0, lineChart.count)
            for (var x in chartsBackend.vectorX)
            {
                if (x < vector.length && isFinite(vector[x]))
                {
                    lineChart.append(chartsBackend.vectorX[x], vector[x])
                }
            }
            var filtered = vector.filter((val, idx, arr) => { return isFinite(val); });
            const mx = Math.max.apply(Math, filtered)
            axisY.min = Math.floor(Math.min.apply(Math, filtered))
            axisY.max = Math.ceil(Math.max.apply(Math, filtered))

            axisY.tickAnchor = axisY.min
            const step = Math.floor((axisY.max - axisY.min) / kStepSize)
            axisY.tickInterval = step > 1 ? step : (step < 1 ? 0.5 : 1)
            axisY.tickType = ValueAxis.TicksDynamic
        }
    }

    Column
    {
        anchors.fill: parent
        padding: kSpacing

        CustomComboBox
        {
            id: chartTypeSelector
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - kChartSpace
            model: chartsBackend.allTitles
            currentIndex: model.length-1
            focus: true

            onActivated: (index) => chartsBackend.type = index

            Component.onCompleted: activated(currentIndex)
        }

        Item
        {
            width: parent.width - parent.padding * 2
            height: parent.height - chartTypeSelector.height - parent.padding
            ChartView
            {
                title: chartsBackend.title
                anchors.fill: parent
                antialiasing: true
                legend.visible: false

                ValueAxis
                {
                    id: axisX
                    min: chartsBackend.vectorX[0]
                    max: chartsBackend.vectorX[chartsBackend.vectorX.length-1]
                    tickCount: kStepSize + 1
                }
                ValueAxis { id: axisY }

                LineSeries
                {
                    id: lineChart
                    axisX: axisX
                    axisY: axisY
                    color: chartsBackend.color
                }
            }
        }
    }
}
