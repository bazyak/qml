import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    readonly property string login: 'login'
    readonly property string password: 'password'

    signal loginSuccess

    function checkCredentials()
    {
        if (login === loginTextField.text && password === passwordTextField.text)
        {
            successAnimation.start()
        }
        else
        {
            failAnimation.start()
        }
    }

    id: loginForm
    color: 'white'
    anchors.centerIn: parent
    radius: 5
    width: 300
    height: 250

    property string textColor: '#535353'

    Column
    {
        anchors.fill: parent
        padding: 32
        spacing: 32

        TextField
        {
            id: loginTextField
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr('Логин')
            width: parent.width - parent.padding * 2
            height: 40
            leftPadding: 12
            topPadding: 12
            selectByMouse: true
            background: Rectangle
            {
                color: enabled ? 'transparent' : 'whitesmoke'
                border.color: enabled ? 'lightgray' : 'transparent'
            }
            color: loginForm.textColor
            focus: true

            Keys.onReturnPressed: checkCredentials()
        }

        TextField
        {
            id: passwordTextField
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr('Пароль')
            width: parent.width - parent.padding * 2
            height: 40
            leftPadding: 12
            topPadding: 12
            selectByMouse: true
            background: Rectangle
            {
                color: enabled ? 'transparent' : 'whitesmoke'
                border.color: enabled ? 'lightgray' : 'transparent'
            }
            color: loginForm.textColor

            Keys.onReturnPressed: checkCredentials()
        }

        Button
        {
            id: submitButton
            width: parent.width - parent.padding * 2
            height: 40
            background: Rectangle
            {
                color: parent.down ? '#bbbbbb' : (parent.hovered ? '#d6d6d6' : '#f6f6f6')
            }
            text: qsTr('Вход')
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: checkCredentials()
        }
    }

    ParallelAnimation
    {
        id: failAnimation

        SequentialAnimation
        {
            PropertyAnimation
            {
                targets: [loginTextField, passwordTextField]
                property: 'color'
                to: 'dark red'
                duration: 0
            }

            PropertyAnimation
            {
                targets: [loginTextField, passwordTextField]
                property: 'color'
                to: loginForm.textColor
                duration: 400
            }
        }

        SequentialAnimation
        {
            NumberAnimation
            {
                target: loginForm;
                property: 'anchors.horizontalCenterOffset';
                to: -5;
                duration: 50
            }

            NumberAnimation
            {
                target: loginForm;
                property: 'anchors.horizontalCenterOffset';
                to: 5;
                duration: 100
            }

            NumberAnimation
            {
                target: loginForm;
                property: 'anchors.horizontalCenterOffset';
                to: 0;
                duration: 50
            }
        }
    }

    SequentialAnimation
    {
        id: successAnimation

        PropertyAnimation
        {
            targets: [loginTextField, passwordTextField, submitButton]
            property: 'opacity'
            to: 0
            duration: 400
        }

        PropertyAnimation
        {
            target: loginForm
            property: 'opacity'
            to: 0
            duration: 600
        }

        onFinished: loginSuccess()
    }
}
