import QtQuick 2.15
import QtQuick.Controls 2.15
import Constants
import 'qml'
import 'js/FetchBrakingBad.js' as Fetcher

Window
{
    id: root
    width: Constants.kWidth
    height: Constants.kHeight
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height
    visible: true
    title: Constants.kWindowTitle

    property int deaths: -1

    function seriesSelected(series)
    {
        deaths = -1
        Fetcher.fetchData('episodes?series=' + series.replaceAll(' ', '+'), 'episodes', episodesModel)
        if (series === Constants.kSeriesModelList[0])
        {
            Fetcher.fetchData('death-count', 'deathsCount', 'deaths')
        }
    }

    function showCharacterInfo(name)
    {
        characterInfo.characterName = name
        characterInfo.open()
    }

    Component.onCompleted: seriesSelected(Constants.kSeriesModelList[0])

    CharacterInfo { id: characterInfo }

    SortListModel
    {
        id: episodesModel
        sortColumnName: 'id'
        order: 'asc'
    }

    ListView
    {
        id: list
        anchors.fill: parent
        model: episodesModel
        spacing: Constants.kMainListSpacing
        ScrollBar.vertical: ScrollBar
        {
            id: lane
            visible: false

            Timer
            {
                id: timer
                interval: 1000
                onTriggered: lane.visible = false
            }

            onActiveChanged:
            {
                if (active)
                {
                    timer.stop()
                    visible = true
                }
                else timer.restart()
            }
        }

        header: Rectangle
        {
            id: rectH
            width: parent.width
            height: Constants.kHeaderHeight
            color: Constants.kHeaderColor

            CustomComboBox
            {
                width: Constants.kSeriesSelectorWidth
                anchors.centerIn: parent
                font.pointSize: Constants.kSeriesSelectorFontSize
                model: Constants.kSeriesModelList
                currentIndex: 0

                onActivated: seriesSelected(currentText)
            }

            Label
            {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: Constants.kSpacing
                color: Constants.kDeathsCountColor
                font.bold: true
                text: deaths === -1 ? '' : Constants.kTotalDeathsString + deaths
            }
        }

        footer: Rectangle
        {
            width: parent.width
            height: Constants.kFooterHeight
            color: Constants.kFooterColor

            Text
            {
                anchors.centerIn: parent
                text: Constants.kFooterText
                color: Constants.kFooterTextColor
            }
        }

        section.delegate: Rectangle
        {
            width: parent.width
            height: Constants.kSectionHeight
            color: Constants.kSectionColor

            Text
            {
                anchors.centerIn: parent
                text: section
                color: Constants.kSectionTextColor
                font.weight: Font.Bold
            }
        }
        section.property: 'season'

        delegate: Rectangle
        {
            id: cell
            width: list.width
            height: Constants.kMainListItemHeight
            color: Constants.kMainListItemColor

            Row
            {
                anchors.fill: parent
                spacing: Constants.kSpacing

                Column
                {
                    width: parent.width / 2
                    height: parent.height
                    leftPadding: Constants.kSpacing

                    Label
                    {
                        height: cell.height / 3
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: Constants.kMainListItemTitleFontSize
                        font.bold: true
                        text: title
                    }

                    Label
                    {
                        height: cell.height / 3
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: Constants.kMainListItemEpisodeFontSize
                        text: Constants.kMainListItemEpisodePrefix + episode
                    }

                    Label
                    {
                        height: cell.height / 3
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: Constants.kMainListItemAirDateFontSize
                        text: airDate
                    }
                }

                ListView
                {
                    id: charactersList
                    spacing: Constants.kCharactersListSpacing
                    anchors.top: parent.top
                    anchors.topMargin: Constants.kSpacing

                    width: cell.width / 2 - Constants.kMainListCharactersPadding
                    height: cell.height - Constants.kMainListCharactersPadding
                    model: characters

                    ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: { active = true } }

                    delegate: Rectangle
                    {
                        width: charactersList.width
                        color: charactersMouseArea.containsMouse
                               ? Constants.kCharactersListItemColorHovered
                               : Constants.kCharactersListItemColor
                        height: Constants.kCharactersListItemHeight
                        radius: Constants.kCharactersListItemRadius

                        Label
                        {
                            id: name
                            leftPadding: Constants.kSpacing
                            height: parent.height
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: Constants.kCharactersListItemFontSize
                            text: model.modelData
                        }

                        MouseArea
                        {
                            id: charactersMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: showCharacterInfo(name.text)
                        }
                    }
                }
            }
        }

        focus: true

        add: Transition
        {
            NumberAnimation
            {
                property: 'y'
                duration: Constants.kListLoadingAnimationDuration
                easing.type: Easing.OutExpo
            }
        }
    }
}
