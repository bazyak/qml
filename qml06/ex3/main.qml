import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import Constants
import 'qml'
import 'js/FetchWeather.js' as Weather

Window
{
    id: root
    width: Constants.kWidth
    height: Constants.kHeight
    minimumWidth: Constants.kWidth
    minimumHeight: Constants.kHeight
    maximumWidth: Constants.kWidth
    maximumHeight: Constants.kHeight
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    title: Constants.kWindowTitle

    Component.onCompleted:
    {
        const lang = Qt.locale().name.substring(0, 2)
        english.checked = lang === 'en'
        russian.checked = lang === 'ru'
        qmlTranslator.setTranslation(lang)
    }

    function translate(lang)
    {
        qmlTranslator.setTranslation(lang)
        if (city.text.length)
        {
            fetchWeather(city.text)
        }
    }

    Connections
    {
        target: qmlTranslator

        function onLanguageChanged()
        {
            root.title = qsTr(Constants.kWindowTitle)
            city.placeholderText = qsTr(Constants.kWelcomeText)
        }
    }

    function fetchWeather(city)
    {
        const lang = english.checked ? 'en' : 'ru'
        Weather.fetchData('city=' + city + '&lang=' + lang, weatherInfo)
    }

    Item
    {
        id: weatherInfo
        property string windDir: ''
        property string windSpeed: ''
        property string temp: ''
        property string appTemp: ''
        property string icon: ''
        property string description: ''
        property string hum: ''

        anchors.fill: parent

        Column
        {
            width: parent.width
            spacing: Constants.kSpacing
            padding: Constants.kSpacing

            CustomTextField
            {
                id: city
                height: Constants.kCityFieldHeight
                width: parent.width - parent.padding * 2
                placeholderText: Constants.kWelcomeText

                Keys.onReturnPressed: fetchWeather(text)
            }

            Row
            {
                width: parent.width - parent.padding * 2
                height: Constants.kTemperInfoRowHeight

                Label
                {
                    id: temper
                    font.pointSize: Constants.kTemperFontSize
                    font.bold: true
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: Constants.kTextColor
                    text: weatherInfo.temp.length ? weatherInfo.temp + 'º' : ''
                }

                Image
                {
                    id: icon
                    source: weatherInfo.icon.length ? 'qrc:/icons/' + weatherInfo.icon + '.png' : ''
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.height
                    anchors.left: temper.right
                }

                Label
                {
                    font.pointSize: Constants.kStandardFontSize
                    anchors.left: icon.right
                    anchors.leftMargin: Constants.kSpacing
                    anchors.verticalCenter: icon.verticalCenter
                    color: Constants.kTextColor
                    text: weatherInfo.description + '\n' +
                          (weatherInfo.appTemp.length
                           ? qsTr(Constants.kFeelLikeText) + ' ' + weatherInfo.appTemp + 'º' : '')
                }
            }

            Label
            {
                font.pointSize: Constants.kStandardFontSize
                color: Constants.kTextColor
                text: weatherInfo.windSpeed.length
                      ? qsTr(Constants.kWindText) + ' ' + weatherInfo.windSpeed + ' ' +
                        qsTr(Constants.kSpeedUnits) + ' ' + weatherInfo.windDir.toLowerCase()
                      : ' '
            }

            Label
            {
                font.pointSize: Constants.kStandardFontSize
                color: Constants.kTextColor
                text: weatherInfo.hum.length ? qsTr(Constants.kHumidityText) + ' ' + weatherInfo.hum + '%' : ' '
            }

            Row
            {
                width: parent.width - parent.padding * 2
                height: Constants.kLangSelectorHeight

                CustomRadioButton
                {
                    id: english
                    text: 'English'
                    checked: false
                    anchors.right: russian.left

                    onCheckedChanged: translate('en')
                }

                CustomRadioButton
                {
                    id: russian
                    text: 'Русский'
                    checked: false
                    anchors.right: parent.right

                    onCheckedChanged: translate('ru')
                }
            }
        }
    }
}
