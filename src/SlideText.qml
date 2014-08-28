import QtQuick 2.1

Text {
    font.pixelSize: baseFontSize
    font.family: theParent.fontFamily
    color: theParent.textColor
    property Slide theParent


    property real fontScale: 1

    property real baseFontSize: theParent.fontSize * fontScale
    function chekParent(myParent){
        if(myParent.isSlide){
            theParent=myParent
        } else if (myParent.parent !== null) {
            chekParent(myParent.parent)
        }
    }
    Component.onCompleted: chekParent(parent)
    wrapMode: Text.WordWrap
}
