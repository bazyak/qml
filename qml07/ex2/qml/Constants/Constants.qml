pragma Singleton
import QtQuick 2.15

QtObject
{
    readonly property int kWidth: 800
    readonly property int kHeight: 480
    readonly property string kWindowTitle: 'Lesson 07 - Exercise 2'

    readonly property int kDataListColumn: 3
    readonly property int kToolTipVerticalOffset: -20
    readonly property int kToolTipDelay: 500

    readonly property int kCellHorizontalSpacing: 20
    readonly property int kCellHeight: 50
    readonly property int kCellIdWidth: 60
    readonly property int kCellStandardWidth: 170
    readonly property int kCellBigWidth: 270

    readonly property int kSpacing: 60
    readonly property int kPadding: 20
    readonly property int kTableHeight: 360

    readonly property color kOddRowColor: 'lavenderblush'
    readonly property color kEvenRowColor: 'snow'
    readonly property color kLineColor: 'lightgray'
}
