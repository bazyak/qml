import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import com.bazyak.DateCalc

Window
{
    readonly property int kHeightBig: 900
    readonly property int kHeightSmall: 640
    readonly property int kWidth: 640

    minimumWidth: kWidth
    minimumHeight: Screen.desktopAvailableHeight - 60 > kHeightBig ? kHeightBig : kHeightSmall
    maximumWidth: kWidth
    maximumHeight: Screen.desktopAvailableHeight - 60 > kHeightBig ? kHeightBig : kHeightSmall
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    color: 'lavenderblush'
    title: qsTr('Lesson 02 - Exercise 1 - Registration form')

    function allFieldsRequired()
    {
        if (!name.length || !sex.currentText.length || !day.currentText.length ||
                !month.currentText.length || !year.currentText ||
                (!highEducation.checked && !middleEdutation.checked && !customEducation.checked) ||
                !city.length || !about.length || !partnerSex.currentText.length ||
                    (!partnerHighEducation.checked &&
                     !partnerMiddleEdutation.checked &&
                     !partnerCustomEducation.checked) ||
                (!music.checked && !sport.checked && !coding.checked && !sewing.checked && !photo.checked &&
                 !tableGames.checked && !reading.checked && !walking.checked && !other.checked ||
                    (other.checked && !otherText.length)))
        {
            popup.errorText = 'All fields are required'
            popup.open()
            return false
        }
        return true
    }

    function printAllDataToConsole()
    {
        if (!allFieldsRequired()) return

        print('Имя: ' + name.text)
        print('Пол: ' + sex.currentText)

        const birthday = day.currentText + '.' + month.currentValue + '.' + year.currentText
        const today = new Date()
        const years = dateCalc.diff(birthday, today.toLocaleDateString(Qt.locale(), "d.M.yyyy"))
        print('Возраст: ' + years)

        const edu = highEducation.checked
                  ? highEducation.text
                  : middleEdutation.checked ? middleEdutation.text
                                            : customEducation.text
        print('Образование: ' + edu)

        const hobby = []
        if (music.checked) hobby.push(music.text)
        if (sport.checked) hobby.push(sport.text)
        if (coding.checked) hobby.push(coding.text)
        if (sewing.checked) hobby.push(sewing.text)
        if (photo.checked) hobby.push(photo.text)
        if (tableGames.checked) hobby.push(tableGames.text)
        if (reading.checked) hobby.push(reading.text)
        if (walking.checked) hobby.push(walking.text)
        if (other.checked && otherText.length) hobby.push(otherText.text)
        print('Хобби: ' + hobby.join(', '))

        print('Город: ' + city.text)
        print('О себе: "' + about.text + '"')

        print('Ожидания от партнёра: ')
        const partnerAgeFrom = Math.round(partnerAge.first.value * 100)
        const partnerAgeTo = Math.round(partnerAge.second.value * 100) === Math.round(partnerAge.to * 100)
                           ? ' и старше'
                           : ' и по ' + Math.round(partnerAge.second.value * 100)
        print('Возраст от ' + partnerAgeFrom + partnerAgeTo)
        print('Пол: ' + partnerSex.currentText)
        const partnerEdu = partnerHighEducation.checked
                         ? partnerHighEducation.text
                         : partnerMiddleEdutation.checked ? partnerMiddleEdutation.text
                                                          : partnerCustomEducation.text
        print('Образование: ' + partnerEdu)
    }

    CustomPopup { id: popup }
    DateCalc { id: dateCalc }

    ScrollView
    {
        width: parent.width * 0.9
        height: parent.height * 0.95
        anchors.centerIn: parent
        contentHeight: kHeightBig * 0.95

        Rectangle
        {
            id: frame
            anchors.fill: parent
            color: 'white'
            radius: 5

            Column
            {
                anchors.fill: parent
                padding: 25
                spacing: 10

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    Label
                    {
                        text: qsTr('Имя: ')
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    CustomTextField
                    {
                        id: name
                        anchors.right: parent.right
                        width: parent.width * 3 / 4
                        placeholderText: qsTr('Как вас зовут?')
                        focus: true

                        validator: RegularExpressionValidator { regularExpression: /^([a-zа-яёA-ZА-ЯЁ ]+)$/ }
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    Label
                    {
                        text: qsTr('Пол: ')
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    CustomComboBox
                    {
                        id: sex
                        anchors.right: parent.right
                        width: parent.width * 3 / 4
                        model: [qsTr('Парень'), qsTr('Девушка'),
                            qsTr('Парень, но ощущаю себя девушкой'),
                            qsTr('Девушка, но ощущаю себя парнем'),
                            qsTr('Трансгендер'), qsTr('Пара')]
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    Label
                    {
                        text: qsTr('Дата рождения: ')
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    CustomComboBox
                    {
                        id: day
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4
                        width: parent.width / 5
                        model: ListModel { id: dayModel }

                        Component.onCompleted:
                        {
                            for (var i = 1; i < 32; ++i)
                            {
                                dayModel.append({ value: i })
                            }
                        }
                    }

                    CustomComboBox
                    {
                        id: month
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4 * 2
                        width: parent.width / 4
                        textRole: 'modelData'
                        valueRole: 'value'
                        model: ListModel
                        {
                            ListElement { modelData: qsTr('Январь'); value: 1 }
                            ListElement { modelData: qsTr('Февраль'); value: 2 }
                            ListElement { modelData: qsTr('Март'); value: 3 }
                            ListElement { modelData: qsTr('Апрель'); value: 4 }
                            ListElement { modelData: qsTr('Май'); value: 5 }
                            ListElement { modelData: qsTr('Июнь'); value: 6 }
                            ListElement { modelData: qsTr('Июль'); value: 7 }
                            ListElement { modelData: qsTr('Август'); value: 8 }
                            ListElement { modelData: qsTr('Сентябрь'); value: 9 }
                            ListElement { modelData: qsTr('Октябрь'); value: 10 }
                            ListElement { modelData: qsTr('Ноябрь'); value: 11 }
                            ListElement { modelData: qsTr('Декабрь'); value: 12 }
                        }
                    }

                    CustomComboBox
                    {
                        id: year
                        anchors.right: parent.right
                        width: parent.width / 5
                        model: ListModel { id: yearModel }

                        Component.onCompleted:
                        {
                            const from = new Date().toLocaleDateString(Qt.locale(), "yyyy")
                            for (var i = from; i >= 1900; --i)
                            {
                                yearModel.append({ value: parseInt(i) })
                            }
                        }
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    Label
                    {
                        text: qsTr('Образование: ')
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    CustomRadioButton
                    {
                        id: highEducation
                        text: qsTr('Высшее')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4
                        width: parent.width / 5
                    }

                    CustomRadioButton
                    {
                        id: middleEdutation
                        text: qsTr('Среднее')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4 * 2
                        width: parent.width / 4
                    }

                    CustomRadioButton
                    {
                        id: customEducation
                        text: qsTr('Самоучка')
                        anchors.right: parent.right
                        width: parent.width / 5
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    Label
                    {
                        text: qsTr('Хобби: ')
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    CustomCheckBox
                    {
                        id: music
                        text: qsTr('Музыка')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4
                        width: parent.width / 5
                    }

                    CustomCheckBox
                    {
                        id: sport
                        text: qsTr('Спорт')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4 * 2
                        width: parent.width / 4
                    }

                    CustomCheckBox
                    {
                        id: coding
                        text: qsTr('Кодинг')
                        anchors.right: parent.right
                        width: parent.width / 5
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    CustomCheckBox
                    {
                        id: sewing
                        text: qsTr('Шитьё')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4
                        width: parent.width / 5
                    }

                    CustomCheckBox
                    {
                        id: photo
                        text: qsTr('Фотография')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4 * 2
                        width: parent.width / 4
                    }

                    CustomCheckBox
                    {
                        id: tableGames
                        text: qsTr('Настолки')
                        anchors.right: parent.right
                        width: parent.width / 5
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    CustomCheckBox
                    {
                        id: reading
                        text: qsTr('Чтение')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4
                        width: parent.width / 5
                    }

                    CustomCheckBox
                    {
                        id: walking
                        text: qsTr('Прогулки')
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 4 * 2
                        width: parent.width / 4
                    }

                    CustomCheckBox
                    {
                        id: other
                        text: qsTr('Другое')
                        anchors.right: parent.right
                        width: parent.width / 5
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    CustomTextField
                    {
                        id: otherText
                        anchors.right: parent.right
                        width: parent.width * 3 / 4
                        enabled: other.checked
                        focus: other.checked

                        validator: RegularExpressionValidator { regularExpression: /^([a-zа-яёA-ZА-ЯЁ ,]+)$/ }
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    Label
                    {
                        text: qsTr('Город: ')
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    CustomTextField
                    {
                        id: city
                        anchors.right: parent.right
                        width: parent.width * 3 / 4
                        placeholderText: qsTr('Откуда вы?')
                        focus: true

                        validator: RegularExpressionValidator { regularExpression: /^([a-zа-яёA-ZА-ЯЁ -]+)$/ }
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 80

                    Label
                    {
                        text: qsTr('О себе: ')
                        height: 40
                        horizontalAlignment: Text.AlignRight
                        rightPadding: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width / 4
                        color: '#21be2b'
                    }

                    ScrollView
                    {
                        width: parent.width * 3 / 4
                        height: parent.height
                        anchors.right: parent.right

                        TextArea
                        {
                            id: about
                            placeholderText: qsTr("Расскажите о себе")

                            width: parent.width
                            leftPadding: 10
                            topPadding: 10
                            height: parent.height

                            background: Rectangle
                            {
                                implicitWidth: 200
                                implicitHeight: 40
                                border.color: enabled ? "#21be2b" : "transparent"
                            }
                        }
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 190

                    CustomGroupBox
                    {
                        title: qsTr('Ожидания от партнёра')
                        anchors.topMargin: 30
                        anchors.fill: parent

                        Column
                        {
                            anchors.fill: parent
                            spacing: 10
                            topPadding: 10
                            rightPadding: 10

                            Row
                            {
                                width: parent.width - parent.rightPadding
                                height: 40

                                Label
                                {
                                    text: qsTr('Возраст: ')
                                    horizontalAlignment: Text.AlignRight
                                    rightPadding: 20
                                    font.bold: true
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width / 4
                                    color: '#21be2b'
                                }

                                CustomRangeSlider
                                {
                                    id: partnerAge
                                    from: 0.18
                                    to: 0.65
                                    anchors.right: parent.right
                                    width: parent.width * 3 / 4
                                    height: 40
                                    first.value: 0.3
                                    second.value: 0.4
                                }
                            }

                            Row
                            {
                                width: parent.width - parent.rightPadding
                                height: 40

                                Label
                                {
                                    text: qsTr('Пол: ')
                                    horizontalAlignment: Text.AlignRight
                                    rightPadding: 20
                                    font.bold: true
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width / 4
                                    color: '#21be2b'
                                }

                                CustomComboBox
                                {
                                    id: partnerSex
                                    anchors.right: parent.right
                                    width: parent.width * 3 / 4
                                    model: [qsTr('Парень'), qsTr('Девушка'),
                                        qsTr('Парень, но ощущаю себя девушкой'),
                                        qsTr('Девушка, но ощущаю себя парнем'),
                                        qsTr('Трансгендер'), qsTr('Пара')]
                                }
                            }

                            Row
                            {
                                width: parent.width - parent.rightPadding
                                height: 40

                                Label
                                {
                                    text: qsTr('Образование: ')
                                    horizontalAlignment: Text.AlignRight
                                    rightPadding: 20
                                    font.bold: true
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width / 4
                                    color: '#21be2b'
                                }

                                CustomRadioButton
                                {
                                    id: partnerHighEducation
                                    text: qsTr('Высшее')
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.width / 4
                                    width: parent.width / 4
                                }

                                CustomRadioButton
                                {
                                    id: partnerMiddleEdutation
                                    text: qsTr('Среднее')
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.width / 4 * 2
                                    width: parent.width / 4
                                }

                                CustomRadioButton
                                {
                                    id: partnerCustomEducation
                                    text: qsTr('Самоучка')
                                    anchors.right: parent.right
                                    width: parent.width / 4
                                }
                            }
                        }
                    }
                }

                Row
                {
                    width: parent.width - parent.padding * 2
                    height: 40

                    CustomButton
                    {
                        id: register
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        width: parent.width * 2 / 4
                        text: qsTr('Регистрация')

                        onClicked: printAllDataToConsole()
                    }
                }
            }
        }
    }
}
