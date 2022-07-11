pragma Singleton
import QtQuick 2.15

QtObject
{
    readonly property int kWidth: 450
    readonly property int kHeight: 300
    readonly property string kWindowTitle: qsTr('Урок 06 - Упражнение 3')

    readonly property color kTextColor: 'darkturquoise'

    readonly property string kWelcomeText: qsTr('Введите ваш город')
    readonly property string kFeelLikeText: qsTr('Ощущается как')
    readonly property string kWindText: qsTr('ветер')
    readonly property string kSpeedUnits: qsTr('м/с')
    readonly property string kHumidityText: qsTr('влажность')

    readonly property int kTemperFontSize: 48
    readonly property int kStandardFontSize: 14
    readonly property int kTemperInfoRowHeight: 60
    readonly property int kCityFieldHeight: 40
    readonly property int kLangSelectorHeight: 40

    readonly property int kSpacing: 20

    readonly property string kApiKey: '5c34e75481234f20a42c0f5b710056f4'
}
