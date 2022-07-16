pragma Singleton
import QtQuick 2.15

QtObject
{
    readonly property int kWidth: 480
    readonly property int kHeight: 320
    readonly property int kSpacing: 20
    readonly property string kWindowTitle: 'Lesson 07 - Exercise 3'

    readonly property color kPopupTextColor: 'white'
    readonly property color kPopupColor: '#1C2833'
    readonly property int kPopupBorderRadius: 7

    readonly property variant kComboBoxModel: [ 'Apple', 'Banana', 'Orange' ]
}
