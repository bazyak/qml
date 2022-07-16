import QtQuick 2.15
import QtQuick.Controls 2.15

ComboBox
{
    id: control
    currentIndex: -1
    hoverEnabled: true

    property int prevIndex: -1
    property color mainTextColor: 'black'
    property color mainTextColorHovered: 'black'
    property color popupTextColor: 'black'
    property color mainBackgroundColor: 'transparent'
    property color mainBorderColor: 'lightgray'
    property color mainBorderColorHovered: 'darkturquoise'
    property color pipColor: 'lightgray'
    property color pipColorHovered: 'darkturquoise'
    property color pipColorPopupVisibled: 'gray'
    property color popupBorderColor: 'darkturquoise'

    signal customActivated(index: int, prevIndex: int)

    Component.onCompleted: control.prevIndex = control.currentIndex

    onActivated: (index) =>
    {
         control.customActivated(index, control.prevIndex)
         control.prevIndex = index
    }

    delegate: ItemDelegate
    {
        width: control.width
        height: 40
        contentItem: Text
        {
            text: key
            leftPadding: 10
            color: popupTextColor
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    onHoveredChanged: indicator.requestPaint()

    indicator: Canvas
    {
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: '2d'

        onPaint:
        {
            context.reset()
            context.moveTo(0, 0)
            context.lineTo(width, 0)
            context.lineTo(width / 2, height)
            context.closePath()
            context.fillStyle = control.popup.visible
                    ? pipColorPopupVisibled
                    : control.hovered ? pipColorHovered : pipColor
            context.fill()
        }
    }

    contentItem: Text
    {
        leftPadding: 10
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: control.hovered ? mainTextColorHovered : mainTextColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle
    {
        implicitWidth: 120
        implicitHeight: 40
        border.color: control.hovered ? mainBorderColorHovered : mainBorderColor
        border.width: control.visualFocus ? 2 : 1
        color: mainBackgroundColor
        radius: 2
    }

    popup: Popup
    {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        onVisibleChanged: canvas.requestPaint()

        contentItem: ListView
        {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle
        {
            border.color: popupBorderColor
            radius: 2
        }
    }
}
