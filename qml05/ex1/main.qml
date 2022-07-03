import QtQuick 2.15
import 'qml'
import 'js/ShapesScript.js' as Magic

Window
{
    readonly property int kSpacing: 20
    readonly property int kComboBoxHeight: 40
    readonly property int kWidth: 640
    readonly property int kHeight: kWidth + kComboBoxHeight + kSpacing
    readonly property int kLineWidth: 1 + shapeScale * 14
    readonly property string kWindowTitle: qsTr('Lesson 05 - Exercise 1')
    readonly property color kLineColor: 'darkturquoise'
    readonly property variant kModelKeys: ['Звёздочка', 'Кольцо', 'Домик', 'Песочные часы']
    readonly property variant kModelValues: ['star', 'circle', 'house', 'sandglass']

    property double shapeScale: 1

    width: kWidth
    height: kHeight
    minimumWidth: kWidth * 0.5
    minimumHeight: kHeight * 0.5
    maximumHeight: Screen.desktopAvailableHeight * 0.8
    maximumWidth: Screen.desktopAvailableWidth * 0.8
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    title: kWindowTitle

    Component.onCompleted:
    {
        for (const [i, key] of kModelKeys.entries())
        {
            if (i < kModelValues.length)
            {
                listModel.append({ key: key, value: kModelValues[i] })
            }
        }
    }

    Column
    {
        anchors.fill: parent
        spacing: kSpacing
        padding: kSpacing

        CustomComboBox
        {
            id: shapeType
            width: parent.width - parent.padding * 2
            height: kComboBoxHeight
            textRole: 'key'
            valueRole: 'value'
            model: ListModel { id: listModel }
            currentIndex: 0
            focus: true

            onActivated: canvas.requestPaint()
        }

        Rectangle
        {
            width: parent.width - parent.padding * 2
            height: parent.height - shapeType.height - parent.padding * 3
            border.color: 'lavenderblush'

            Canvas
            {
                id: canvas
                anchors.fill: parent

                onPaint:
                {
                    var ctx = getContext('2d')
                    ctx.clearRect(0, 0, width, height)
                    ctx.lineJoin = 'round'
                    ctx.beginPath()
                    const points = Magic.getShape(shapeType.currentValue, canvas.canvasSize, shapeScale);
                    for (const [i, point] of points.entries())
                    {
                        const funcName = !i ? 'moveTo' : 'lineTo'
                        eval('ctx.' + funcName + '(point.x, point.y)')
                    }
                    ctx.closePath()
                    ctx.lineWidth = kLineWidth
                    ctx.strokeStyle = kLineColor
                    ctx.stroke()
                }
            }
        }
    }
}
