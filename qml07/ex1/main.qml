import QtQuick 2.15
import QtQuick.LocalStorage 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels
import Constants
import 'qml'
import 'js/DBEngine.js' as DBEngine

Window
{
    id: root
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

    readonly property variant kTableModels:
    [
        { key: 'Контакты', value: contactsModel },
        { key: 'Вакансии', value: jobsModel }
    ]
    property variant db: ({ })

    Component.onCompleted:
    {
        db = new DBEngine.Database()
        db.createContactsTable()
        db.addContact('Иванов', 'Иван', 'ivanoviv2182@mail.ru', '+798837333112')
        db.addContact('Заварнов', 'Владимир', 'zavlad@mail.ru', '+797798373331')
        db.addContact('Говорун', 'Максим', 'landlord2000@mail.ru', '+79773311111')
        db.createJobsTable()
        db.addJob('C++ Developer', 'Разработка прикладного ПО на языке С++')
        db.addJob('Qt/Qml software engineer',
                  'Разработка и проектирование ПО с использованием фрейморка Qt')
        db.addJob('Felgo/C++ mobile developer',
                  'Разработка и проектирование ПО с использованием фрейморка Felgo')
        db.readContacts(contactsModel)
        db.readJobs(jobsModel)

        kTableModels.forEach((item) => selector.model.append(item))
    }

    TableModel
    {
        id: contactsModel
        TableModelColumn { display: 'id'; accessibleText: () => 'id'; toolTip: 'id' }
        TableModelColumn { display: 'first_name'; accessibleText: () => 'first_name'; toolTip: 'first_name' }
        TableModelColumn { display: 'last_name'; accessibleText: () => 'last_name'; toolTip: 'last_name' }
        TableModelColumn { display: 'email'; accessibleText: () => 'email'; toolTip: 'email' }
        TableModelColumn { display: 'phone'; accessibleText: () => 'phone'; toolTip: 'phone' }
        rows: []
    }

    TableModel
    {
        id: jobsModel
        TableModelColumn { display: 'id'; accessibleText: () => 'id'; toolTip: 'id' }
        TableModelColumn { display: 'title'; accessibleText: () => 'title'; toolTip: 'title' }
        TableModelColumn { display: 'description'; accessibleText: () => 'description'; toolTip: 'description' }
        rows: []
    }

    Column
    {
        id: mainColumn
        anchors.fill: parent
        padding: Constants.kPadding
        spacing: Constants.kSpacing

        CustomComboBox
        {
            id: selector
            anchors.horizontalCenter: parent.horizontalCenter
            textRole: 'key'
            valueRole: 'value'
            model: ListModel { }
            currentIndex: 0
            focus: true
        }

        TableView
        {
            id: table
            anchors.horizontalCenter: parent.horizontalCenter
            height: Constants.kTableHeight
            width: columns > 0
                   ? [...Array(columns).keys()].reduce((prev, cur) => prev + table.columnWidthProvider(cur), 0)
                   : 0
            model: selector.currentValue

            columnWidthProvider: (column) => !column
                                 ? Constants.kCellIdWidth
                                 : model == jobsModel
                                   ? (column === Constants.kJobsBigColumn
                                      ? Constants.kCellJobsBigWidth : Constants.kCellJobsStandardWidth)
                                   : column === Constants.kContactsBigColumn
                                     ? Constants.kCellContactsBigWidth : Constants.kCellContactsStandardWidth

            ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: active = true; }

            delegate: Rectangle
            {
                id: rect
                implicitWidth: table.columnWidthProvider(column)
                implicitHeight: Constants.kCellHeight
                color: row % 2 ? Constants.kOddRowColor : Constants.kEvenRowColor

                HoverHandler { id: hoverHandler }

                Text
                {
                    id: innerText
                    anchors.centerIn: parent
                    width: parent.width - Constants.kCellHorizontalSpacing * 2
                    horizontalAlignment: Text.AlignLeft
                    elide: Text.ElideRight
                    text: display

                    ToolTip
                    {
                        delay: Constants.kToolTipDelay
                        visible: hoverHandler.hovered && innerText.truncated
                        text: toolTip
                    }

                    MouseArea
                    {
                        anchors.fill: parent

                        onDoubleClicked:
                        {
                            if (column)
                            {
                                editLoader.visible = true
                                editLoader.item.forceActiveFocus()
                            }
                        }
                    }
                }

                Rectangle { x: parent.width - 1; y: 0; width: 1; height: parent.height; color: Constants.kLineColor }
                Rectangle { x: 0; y: parent.height - 1; width: parent.width; height: 1; color: Constants.kLineColor }
                Rectangle { x: 0; y: 0; width: parent.width; height: 1; color: Constants.kLineColor; visible: !row }
                Rectangle { x: 0; y: 0; width: 1; height: parent.height; color: Constants.kLineColor; visible: !column }

                Loader
                {
                    id: editLoader
                    anchors { verticalCenter: parent.verticalCenter; left: parent.left }
                    height: parent.height
                    width: parent.width
                    visible: false
                    sourceComponent: visible ? input : undefined

                    Component
                    {
                        id: input

                        CustomTextField
                        {
                            anchors.fill: parent
                            mainColor: Constants.kTextEditBackgroundColor
                            selectByMouse: true
                            text: display

                            onAccepted:
                            {
                                editLoader.visible = false
                                const tableName = table.model == contactsModel ? 'contacts' : 'jobs'
                                if (db.update(tableName, table.model.rows[row].id, accessibleText, text))
                                {
                                    display = text
                                    toolTip = text
                                }
                            }

                            onActiveFocusChanged:
                            {
                                if (!activeFocus)
                                {
                                    editLoader.visible = false
                                }
                            }

                            Keys.onEscapePressed: editLoader.visible = false
                        }
                    }
                }
            }
        }
    }
}
