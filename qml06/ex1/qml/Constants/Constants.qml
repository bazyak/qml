pragma Singleton
import QtQuick 2.15

QtObject
{
    readonly property int kWidth: 640
    readonly property int kHeight: 640
    readonly property string kWindowTitle: qsTr('Lesson 06 - Exercise 1')

    readonly property variant kSeriesModelList: ['Breaking Bad', 'Better Call Saul']
    property string kTotalDeathsString: qsTr('Total deaths: ')

    readonly property color kHeaderColor: 'darkturquoise'
    readonly property color kFooterColor: 'darkturquoise'
    readonly property color kFooterTextColor: 'white'
    readonly property string kFooterText: qsTr('Powered by Ruslan Bazyak')
    readonly property color kDeathsCountColor: 'white'
    readonly property int kSpacing: 20
    readonly property int kHeaderHeight: 40
    readonly property int kFooterHeight: 40
    readonly property int kSeriesSelectorWidth: 140
    readonly property int kSeriesSelectorFontSize: 14

    readonly property int kMainListSpacing: 2
    readonly property int kSectionHeight: 25
    readonly property color kSectionColor: 'paleturquoise'
    readonly property color kSectionTextColor: 'royalblue'

    readonly property int kMainListItemHeight: 120
    readonly property color kMainListItemColor: 'whitesmoke'
    readonly property int kMainListItemTitleFontSize: 20
    readonly property int kMainListItemEpisodeFontSize: 16
    readonly property int kMainListItemAirDateFontSize: 10
    readonly property string kMainListItemEpisodePrefix: qsTr('Episode ')

    readonly property int kMainListCharactersPadding: 40
    readonly property int kCharactersListSpacing: 3
    readonly property int kCharactersListItemHeight: 20
    readonly property int kCharactersListItemFontSize: 12
    readonly property int kCharactersListItemRadius: 5

    readonly property int kListLoadingAnimationDuration: 1500

    // character dialog constants
    readonly property string kCharacterDialogTitle: qsTr('Character info')

}
