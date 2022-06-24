import QtQuick 2.15
import QtQuick.Controls 2.15

Window
{
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr('Lesson 03 - Exercise 1 & 2')

    readonly property string loginFormState: 'login_form'
    readonly property string loggedFormState: 'logged_form'
    readonly property string searchFormState: 'search_form'
    readonly property string finishFormState: 'finish_form'

    Rectangle
    {
        id: rect
        anchors.fill: parent
        color: 'lavenderblush'
        state: loginFormState
        states:
        [
            State
            {
                name: loginFormState
                PropertyChanges { target: loginForm; visible: true }
            },
            State
            {
                name: loggedFormState
                PropertyChanges { target: loggedForm; visible: true; opacity: 1 }
            },
            State
            {
                name: searchFormState
                PropertyChanges { target: searchForm; visible: true; opacity: 1; scale: 1 }
            },
            State
            {
                name: finishFormState
                PropertyChanges { target: finishForm; visible: true; opacity: 1; anchors.verticalCenterOffset: 0 }
            }
        ]

        transitions:
        [
            Transition
            {
                to: loggedFormState
                NumberAnimation { property: 'opacity'; from: 0; to: 1.0; duration: 400 }
            },
            Transition
            {
                to: searchFormState
                NumberAnimation { property: 'opacity'; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { property: 'scale'; from: 0; to: 1.0; duration: 400 }
            },
            Transition
            {
                to: finishFormState
                ParallelAnimation
                {
                    SequentialAnimation
                    {
                        PropertyAnimation { property: 'anchors.verticalCenterOffset'; to: -50; duration: 600 }
                        PropertyAnimation { property: 'anchors.verticalCenterOffset'; to: 30; duration: 500 }
                        PropertyAnimation { property: 'anchors.verticalCenterOffset'; to: -20; duration: 400 }
                        PropertyAnimation { property: 'anchors.verticalCenterOffset'; to: 10; duration: 300 }
                        PropertyAnimation { property: 'anchors.verticalCenterOffset'; to: 0; duration: 200 }
                    }
                    PropertyAnimation { property: 'opacity'; from: 0; to: 1; duration: 2000 }
                }
            }
        ]

        LoginForm
        {
            id: loginForm
            visible: false
            onLoginSuccess: rect.state = loggedFormState
        }

        LoggedForm
        {
            id: loggedForm
            visible: false
            textColor: 'darkturquoise'
            onSearchStarted: rect.state = searchFormState
        }

        SearchForm
        {
            id: searchForm
            visible: false
            onSearchCanceled: rect.state = loggedFormState
            onSearchFinished: rect.state = finishFormState
        }

        FinishForm
        {
            id: finishForm
            visible: false
            textColor: 'darkturquoise'
        }
    }
}
