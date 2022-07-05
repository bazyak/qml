import QtQuick 2.15
import QtQuick.Controls 2.15

TextField
{
    height: 40
    leftPadding: 12
    topPadding: 12
    selectByMouse: true
    background: Rectangle
    {
        color: enabled ? 'transparent' : 'whitesmoke'
        border.color: enabled ? 'lightgray' : 'transparent'
    }
}
