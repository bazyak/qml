pragma Singleton
import QtQuick 2.0

QtObject
{
    readonly property int kWidth: 860
    readonly property int kHeight: 480
    readonly property string kWindowTitle: 'Lesson 07 - Exercise 1'

    readonly property int kCellHorizontalSpacing: 20
    readonly property int kCellHeight: 40
    readonly property int kCellIdWidth: 60
    readonly property int kCellContactsStandardWidth: 170
    readonly property int kCellContactsBigWidth: 250
    readonly property int kCellJobsStandardWidth: 250
    readonly property int kCellJobsBigWidth: 400

    readonly property int kSpacing: 60
    readonly property int kPadding: 20
    readonly property int kTableHeight: 360

    readonly property int kJobsBigColumn: 2
    readonly property int kContactsBigColumn: 3
    readonly property int kToolTipDelay: 500

    readonly property color kOddRowColor: 'lavenderblush'
    readonly property color kEvenRowColor: 'snow'
    readonly property color kLineColor: 'lightgray'
    readonly property color kTextEditBackgroundColor: 'white'
}
