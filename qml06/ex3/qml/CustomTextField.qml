import QtQuick 2.15
import QtQuick.Controls 2.15

TextField
{
    property color mainColor: 'transparent'
    property color mainColorDisabled: 'whitesmoke'
    property color borderColor: 'lightgray'
    property color borderColorDisabled: 'transparent'

    height: 40
    leftPadding: 12
    topPadding: 12
    selectByMouse: true
    background: Rectangle
    {
        color: enabled ? mainColor : mainColorDisabled
        border.color: enabled ? borderColor : borderColorDisabled
    }
}
