pragma Singleton
import QtQuick 2.15

QtObject
{
    readonly property int kSpacing: 20
    readonly property int kRowHeight: 40
    readonly property int kWidth: 640
    readonly property int kHeight: 480
    readonly property string kWindowTitle: qsTr('Lesson 06 - Exercise 2')
    readonly property string kSwapButtonText: qsTr('Swap currencies')
    readonly property string kSourceCurr: 'USD'
    readonly property string kDestCurr: 'RUB'
    readonly property int kSwapButtonWidth: 200
    readonly property int kLabelFontSize: 20
    readonly property color kLabelColor: 'darkturquoise'
}
