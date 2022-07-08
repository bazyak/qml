import QtQuick 2.15
import QtQuick.Controls 2.15
import Constants
import '../js/FetchBrakingBad.js' as Fetcher

Popup
{
    Component.onCompleted:
    {
        Fetcher.fetchData('quote?author=' + characterName.replaceAll(' ', '+'), 'quotes', quotes)
    }

    property string characterName: ''

    parent: Overlay.overlay
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 500
    height: 500
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle
    {
        anchors.fill: parent
        border.color: '#1C2833'
        color: '#1C2833'
        radius: 7
    }

    Label
    {
        id: title
        height: 30
        width: parent.width
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: Constants.kMainListItemEpisodeFontSize
        font.bold: true
        color: 'white'
        text: characterName
    }

    Column
    {
        width: parent.width
        topPadding: title.height + Constants.kSpacing

        height: parent.height - topPadding
        spacing: Constants.kSpacing
        padding: Constants.kSpacing

        Rectangle
        {
            width: parent.width - parent.padding * 2
            height: (parent.height - parent.spacing * 3) / 3
            color: 'lavenderblush'
            radius: 5
        }

        Rectangle
        {
            width: parent.width - parent.padding * 2
            height: (parent.height - parent.spacing * 3) / 3
            color: 'lavenderblush'
            radius: 5

            Label
            {
                id: quotesTitle
                text: 'Quotes:'
                font.pointSize: 14
                font.bold: true
                leftPadding: 10
                topPadding: 5
            }

            Flickable
            {
                id: flickable
                anchors.top: parent.top
                anchors.topMargin: quotesTitle.height + 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                width: parent.width - anchors.leftMargin * 2
                height: parent.height - anchors.topMargin - 10
                contentWidth: width
                contentHeight: quotes.implicitHeight
                clip: true

                TextArea
                {
                    id: quotes
                    width: flickable.width
                    font.pointSize: 14
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: transparent
                }

                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }

        Rectangle
        {
            width: parent.width - parent.padding * 2
            height: (parent.height - parent.spacing * 3) / 3
            color: 'lavenderblush'
            radius: 5
        }

//        ListView
//        {
//            id: dths
//            width: parent.width - parent.padding * 2
//            height: (parent.height - parent.spacing * 3) / 3

//            spacing: Constants.kCharactersListSpacing

//            model: ListModel { id: deaths }

//            ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: { active = true } }

//            delegate: Rectangle
//            {
//                width: parent.width
//                color: 'gainsboro'
//                height: Constants.kCharactersListItemHeight
//                radius: Constants.kCharactersListItemRadius

//                Label
//                {
//                    leftPadding: Constants.kSpacing
//                    height: parent.height
//                    verticalAlignment: Text.AlignVCenter
//                    font.pointSize: Constants.kCharactersListItemFontSize
//                    text: model.modelData
//                }
//            }
//        }

    }

//    Text
//    {
//        text: errorText
//        color: 'white'
//        width: 300
//        anchors.centerIn: parent
//        horizontalAlignment: Qt.AlignCenter
//        elide: Text.ElideRight
//        wrapMode: Text.Wrap
//    }
}
