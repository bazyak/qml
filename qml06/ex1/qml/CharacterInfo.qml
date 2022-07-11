import QtQuick 2.15
import QtQuick.Controls 2.15
import Constants
import '../js/FetchBrakingBad.js' as Fetcher

Popup
{
    onOpened:
    {
        info.photo = ''
        info.nickname = ''
        info.birthday = ''
        info.status = ''
        info.occupation = ''
        quotes.text = ''
        death.text = ''
        const name = characterName.replaceAll(' ', '+')
        Fetcher.fetchData('quote?author=' + name, 'quotes', quotes)
        Fetcher.fetchData('characters?name=' + name, 'character', info)
        Fetcher.fetchData('death?name=' + name, 'death', death)
    }

    property string characterName: ''

    width: Constants.kInfoDialogWidth
    height: Constants.kInfoDialogHeight
    parent: Overlay.overlay
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle
    {
        anchors.fill: parent
        border.color: Constants.kInfoDialogBackgroundColor
        color: Constants.kInfoDialogBackgroundColor
        // color: '#1C2833'
        radius: 7
    }

    Label
    {
        id: title
        height: 30
        width: parent.width
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: Constants.kInfoDialogTitleFontSize
        font.bold: true
        color: Constants.kInfoDialogTitleColor
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
            property string photo: ''
            property string nickname: ''
            property string birthday: ''
            property string status: ''
            property string occupation: ''

            id: info
            width: parent.width - parent.padding * 2
            height: (parent.height - parent.spacing * 3) / 3
            color: Constants.kInfoDialogTileColor
            radius: Constants.kInfoDialogTileRadius

            Image
            {
                source: info.photo
                fillMode: Image.PreserveAspectFit
                width: parent.width / 4
                height: parent.height - Constants.kSmallSpacing * 2
                anchors.top: parent.top
                anchors.topMargin: Constants.kSmallSpacing
                anchors.left: parent.left
                anchors.leftMargin: Constants.kSmallSpacing
            }

            Column
            {
                width: parent.width / 4 * 3
                height: parent.height
                anchors.right: parent.right
                leftPadding: Constants.kSpacing
                spacing: Constants.kSmallSpacing

                Row
                {
                    height: (info.height - parent.spacing * 2) / 3
                    width: parent.width - parent.leftPadding

                    Label
                    {
                        anchors.left: parent.left
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: Constants.kInfoDialogNicknameFontSize
                        font.bold: true
                        text: info.nickname.length ? info.nickname : Constants.kInfoDialogNoInfoText
                    }

                    Label
                    {
                        anchors.right: parent.right
                        anchors.rightMargin: Constants.kSpacing
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        font.pointSize: Constants.kInfoDialogStandardFontSize
                        text: info.status.length ? '[' + info.status + ']' : ''
                    }
                }

                Label
                {
                    height: (info.height - parent.spacing * 2) / 3
                    verticalAlignment: Text.AlignTop
                    font.pointSize: Constants.kInfoDialogBirthdayFontSize
                    text: info.birthday.length ? Constants.kInfoDialogBornPrefixText + info.birthday : ''
                }

                Flickable
                {
                    id: flickableOccupation
                    anchors.left: parent.left
                    anchors.leftMargin: Constants.kSmallSpacing * 3
                    height: (info.height - parent.spacing * 2) / 3 - parent.spacing
                    width: parent.width - parent.leftPadding * 2 + Constants.kSmallSpacing
                    contentWidth: width
                    contentHeight: occupationArea.implicitHeight
                    clip: true

                    TextArea
                    {
                        id: occupationArea
                        width: flickableOccupation.width
                        font.pointSize: Constants.kInfoDialogOccupationFontSize
                        wrapMode: Text.Wrap
                        selectByMouse: true
                        textFormat: TextEdit.AutoText
                        text: info.occupation.length
                              ? '<b>' + Constants.kInfoDialogOccupationPrefixText + '</b> ' + info.occupation
                              : ''
                        background: Rectangle { color: Constants.kInfoDialogTextAreaColor }
                    }

                    ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: { active = true } }
                }
            }
        }

        Rectangle
        {
            width: parent.width - parent.padding * 2
            height: (parent.height - parent.spacing * 3) / 3
            color: Constants.kInfoDialogTileColor
            radius: Constants.kInfoDialogTileRadius

            Label
            {
                id: quotesTitle
                text: quotes.text.length
                      ? Constants.kInfoDialogQuotesPrefixText
                      : Constants.kInfoDialogNoQuotesText
                //visible: quotes.length
                font.pointSize: Constants.kInfoDialogStandardFontSize
                font.bold: true
                leftPadding: Constants.kSmallSpacing * 2
                topPadding: Constants.kSmallSpacing
            }

            Flickable
            {
                id: flickableQuotes
                anchors.top: parent.top
                anchors.topMargin: quotesTitle.height + Constants.kSmallSpacing
                anchors.left: parent.left
                anchors.leftMargin: Constants.kSmallSpacing
                width: parent.width - anchors.leftMargin * 2
                height: parent.height - anchors.topMargin - Constants.kSmallSpacing * 2
                contentWidth: width
                contentHeight: quotes.implicitHeight
                clip: true

                TextArea
                {
                    id: quotes
                    width: flickableQuotes.width
                    font.pointSize: Constants.kInfoDialogStandardFontSize
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    background: Rectangle { color: Constants.kInfoDialogTextAreaColor }
                }

                ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: { active = true } }
            }
        }

        Rectangle
        {
            width: parent.width - parent.padding * 2
            height: (parent.height - parent.spacing * 3) / 3
            color: Constants.kInfoDialogTileColor
            radius: Constants.kInfoDialogTileRadius

            Label
            {
                id: deathTitle
                text: death.text.length
                      ? Constants.kInfoDialogDeathPrefixText
                      : Constants.kInfoDialogNoDeathText
                // visible: death.length
                font.pointSize: Constants.kInfoDialogStandardFontSize
                font.bold: true
                leftPadding: Constants.kSmallSpacing * 2
                topPadding: Constants.kSmallSpacing
            }

            Flickable
            {
                id: flickableDeath
                anchors.top: parent.top
                anchors.topMargin: quotesTitle.height + Constants.kSmallSpacing
                anchors.left: parent.left
                anchors.leftMargin: Constants.kSmallSpacing
                width: parent.width - anchors.leftMargin * 2
                height: parent.height - anchors.topMargin - Constants.kSmallSpacing * 2
                contentWidth: width
                contentHeight: death.implicitHeight
                clip: true

                TextArea
                {
                    id: death
                    width: flickableDeath.width
                    font.pointSize: Constants.kInfoDialogStandardFontSize
                    wrapMode: Text.Wrap
                    selectByMouse: true
                    textFormat: TextEdit.AutoText
                    background: Rectangle { color: Constants.kInfoDialogTextAreaColor }
                }

                ScrollIndicator.vertical: ScrollIndicator { active: true; onActiveChanged: { active = true } }
            }
        }
    }
}
