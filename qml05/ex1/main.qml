import QtQuick 2.15
import 'qml'
import 'js/ShapesScript.js' as Magic

Window
{
    readonly property int kModelCount: 7
    readonly property int kInputWidth: 80
    readonly property int kRowHeight: 40

    readonly property int kChartSpace: 120
    readonly property int kSpacing: 20
    readonly property int kMaxWidth: Screen.desktopAvailableWidth * 0.8
    readonly property int kWidth: Math.min(kModelCount * kInputWidth * 1.5, kMaxWidth) * 0.9
    readonly property int kHeight: kWidth * 0.8
    readonly property string kWindowTitle: qsTr('Lesson 05 - Exercise 1')
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

    Column
    {
        anchors.fill: parent
        padding: kSpacing

        CustomComboBox
        {
            id: shapeType
            width: parent.width - parent.padding * 2
            textRole: 'key'
            valueRole: 'value'
            model: ListModel
            {
                ListElement { key: 'Звёздочка'; value: 'star' }
                ListElement { key: 'Кольцо'; value: 'circle' }
                ListElement { key: 'Домик'; value: 'house' }
                ListElement { key: 'Песочные часы'; value: 'sandglass' }
            }
            currentIndex: 0
            focus: true

            onActivated: canvas.requestPaint()
        }

        Canvas
        {
            id: canvas
            width: parent.width - parent.padding * 2
            height: parent.height - shapeType.height - parent.padding

            onPaint:
            {
                var ctx = getContext('2d')
                ctx.clearRect(0, 0, width, height)
                ctx.fillStyle = Qt.rgba(1, 0, 0, 1)
                ctx.beginPath()
                // const points = Magic.getShape(shapeType.currentValue, canvas.canvasSize);

                ctx.moveTo(300, 20);          // Create a horizontal line
                ctx.arcTo(500, 20, 500, 220, 200); // Create an arc
                ctx.arcTo(500, 420, 300, 420, 200); // Create an arc
                ctx.arcTo(100, 420, 100, 220, 200); // Create an arc
                ctx.arcTo(100, 20, 300, 20, 200); // Create an arc



//                ctx.arcTo(150, 150, 200, 100, 50)
//                ctx.arcTo(200, 100, 150, 50, 50)
//                ctx.arcTo(150, 50, 100, 100, 50)

//                for (const [i, point] of points.entries())
//                {
//                    if (!i)
//                    {
//                        ctx.moveTo(point.x, point.y)
//                    }
//                    else
//                    {
//                        ctx.lineTo(point.x, point.y)
//                    }
//                }
                ctx.closePath()
                ctx.lineWidth = 15
                ctx.stroke()
                //ctx.fill()
            }
        }
    }
}
