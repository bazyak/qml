import QtQuick 2.15
import QtQuick.Controls 2.15
import Constants

Window
{
    width: Constants.kWidth
    height: Constants.kHeight
    minimumWidth: Constants.kWidth
    minimumHeight: Constants.kHeight
    maximumWidth: Math.min(Constants.kWidth * 1.5, Screen.desktopAvailableWidth * 0.8)
    maximumHeight: Math.min(Constants.kHeight * 1.5, Screen.desktopAvailableWidth * 0.8)
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    title: Constants.kWindowTitle

    Column
    {
        id: mainColumn
        anchors.fill: parent
        padding: Constants.kPadding
        spacing: Constants.kSpacing

        TableView
        {
            id: table
            anchors.horizontalCenter: parent.horizontalCenter
            height: Constants.kTableHeight
            width: columns > 0
                   ? [...Array(columns).keys()].reduce((prev, cur) => prev + table.columnWidthProvider(cur), 0)
                   : 0
            model: mdl

            columnWidthProvider: (column) => !column
                                 ? Constants.kCellIdWidth
                                 : column === Constants.kDataListColumn
                                   ? Constants.kCellBigWidth : Constants.kCellStandardWidth

            ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: active = true; }

            delegate: Rectangle
            {
                id: rect
                implicitWidth: table.columnWidthProvider(column)
                implicitHeight: Constants.kCellHeight
                color: row % 2 ? Constants.kOddRowColor : Constants.kEvenRowColor

                SwipeView
                {
                    id: swipeView
                    anchors.centerIn: parent
                    contentHeight: parent.height
                    contentWidth: parent.width - Constants.kCellHorizontalSpacing * 2
                    clip: true

                    Component.onCompleted: currentIndex = 0

                    Repeater
                    {
                        model: column === Constants.kDataListColumn ? display.length : 1

                        Loader
                        {
                            active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem

                            sourceComponent: Text
                            {
                                HoverHandler { id: hoverHandler }

                                text: column === Constants.kDataListColumn ? display[index] : display
                                wrapMode: Text.NoWrap
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter

                                ToolTip
                                {
                                    delay: Constants.kToolTipDelay
                                    y: Constants.kToolTipVerticalOffset
                                    visible: hoverHandler.hovered && parent.truncated
                                    text: column === Constants.kDataListColumn ? toolTip[index] : toolTip
                                }
                            }
                        }
                    }
                }

                PageIndicator
                {
                    id: indicator
                    visible: swipeView.count > 1
                    count: swipeView.count
                    currentIndex: swipeView.currentIndex
                    anchors.bottom: swipeView.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle { x: parent.width - 1; y: 0; width: 1; height: parent.height; color: Constants.kLineColor }
                Rectangle { x: 0; y: parent.height - 1; width: parent.width; height: 1; color: Constants.kLineColor }
                Rectangle { x: 0; y: 0; width: parent.width; height: 1; color: Constants.kLineColor; visible: !row }
                Rectangle { x: 0; y: 0; width: 1; height: parent.height; color: Constants.kLineColor; visible: !column }
            }
        }
    }
}
