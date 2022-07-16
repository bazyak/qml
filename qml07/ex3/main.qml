import QtQuick 2.15
import QtQuick.Controls 2.15
import Constants
import 'qml'

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

    CustomComboBox
    {
        id: selector
        anchors.top: parent.top
        anchors.topMargin: Constants.kSpacing
        anchors.horizontalCenter: parent.horizontalCenter
        model: Constants.kComboBoxModel
        currentIndex: 0
        focus: true

        onClosed: popup.open()
    }

    CustomPopup
    {
        id: popup
        borderRadius: Constants.kPopupBorderRadius
        backgroundColor: Constants.kPopupColor
        borderColor: Constants.kPopupColor

        Text
        {
            id: error
            text: selector.currentText
            color: Constants.kPopupTextColor
            anchors.centerIn: parent
        }
    }
}
