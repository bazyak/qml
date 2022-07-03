import QtQuick 2.15
import QtQuick.Controls 2.15
import 'qml'
// import 'js/CompsCreater.js' as Creator // just for experience

Window
{
    readonly property int kWidth: 640
    readonly property int kHeight: 480
    readonly property int kMinWidth: 350
    readonly property int kMinHeight: 300
    readonly property int kMaxWidth: Math.min(kWidth * 1.5, Screen.desktopAvailableWidth * 0.8)
    readonly property int kMaxHeight: Math.min(kHeight * 1.5, Screen.desktopAvailableHeight * 0.8)

    readonly property string kWindowTitle: qsTr('Lesson 05 - Exercise 2')
    readonly property color kMainBackColor: 'lavenderblush'
    readonly property color kFormTextColor: 'darkturquoise'

    readonly property string loginFormState: 'login_form'
    readonly property string loggedFormState: 'logged_form'
    readonly property string searchFormState: 'search_form'
    readonly property string finishFormState: 'finish_form'

    width: kWidth
    height: kHeight
    minimumWidth: kMinWidth
    minimumHeight: kMinHeight
    maximumWidth: kMaxWidth
    maximumHeight: kMaxHeight
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true
    title: kWindowTitle

    Rectangle
    {
        id: rect
        anchors.fill: parent
        color: kMainBackColor

        /*
         * just for experience
         *
        Component.onCompleted:
        {
            var comp = new Creator.CustomObject(rect, '../qml/LoginForm.qml')
            comp.getObject().loginSuccess.connect(function() { print('logged in') })
        }
        */

        Loader { id: loader }

        state: loginFormState
        states:
        [
            State
            {
                name: loginFormState
                PropertyChanges { target: loader; sourceComponent: loginComponent }
            },
            State
            {
                name: loggedFormState
                PropertyChanges { target: loader; sourceComponent: loggedComponent }
            },
            State
            {
                name: searchFormState
                PropertyChanges { target: loader; sourceComponent: searchComponent }
            },
            State
            {
                name: finishFormState
                PropertyChanges { target: loader; sourceComponent: finishComponent }
            }
        ]

        Component
        {
            id: loginComponent

            LoginForm
            {
                id: loginForm
                parent: rect
                onLoginSuccess: rect.state = loggedFormState
            }
        }

        Component
        {
            id: loggedComponent

            LoggedForm
            {
                id: loggedForm
                parent: rect
                textColor: kFormTextColor
                onSearchStarted: rect.state = searchFormState

                Component.onCompleted: animLogged.start()

                NumberAnimation { id: animLogged; target: loggedForm; property: 'opacity'; from: 0; to: 1.0; duration: 400 }
            }
        }

        Component
        {
            id: searchComponent

            SearchForm
            {
                id: searchForm
                parent: rect
                onSearchCanceled: rect.state = loggedFormState
                onSearchFinished: rect.state = finishFormState

                Component.onCompleted: animSearch.start()

                ParallelAnimation
                {
                    id: animSearch
                    NumberAnimation { target: searchForm; property: 'opacity'; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { target: searchForm; property: 'scale'; from: 0; to: 1.0; duration: 400 }
                }
            }
        }

        Component
        {
            id: finishComponent

            FinishForm
            {
                id: finishForm
                parent: rect
                textColor: kFormTextColor

                Component.onCompleted: animFinish.start()

                ParallelAnimation
                {
                    id: animFinish
                    SequentialAnimation
                    {
                        PropertyAnimation { target: finishForm; property: 'anchors.verticalCenterOffset'; to: -50; duration: 600 }
                        PropertyAnimation { target: finishForm; property: 'anchors.verticalCenterOffset'; to: 30; duration: 500 }
                        PropertyAnimation { target: finishForm; property: 'anchors.verticalCenterOffset'; to: -20; duration: 400 }
                        PropertyAnimation { target: finishForm; property: 'anchors.verticalCenterOffset'; to: 10; duration: 300 }
                        PropertyAnimation { target: finishForm; property: 'anchors.verticalCenterOffset'; to: 0; duration: 200 }
                    }
                    PropertyAnimation { target: finishForm; property: 'opacity'; from: 0; to: 1; duration: 2000 }
                }
            }
        }
    }
}
