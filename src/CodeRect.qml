/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QML Presentation System.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/


import QtQuick 2.0

Item {
    id: root;
    implicitHeight: listView.contentHeight * 1.2

    property Presentation presentation
    property string codeFontFamily : presentation.codeFontFamily
    property variant code:[]
    property real codeFontSize: parentSlide.baseFontSize * 0.5;
    property Slide parentSlide
    property real lineHight:10

    function checkParentPrezentation(myParent){
        if(myParent.isPresentation){
            presentation=myParent
        } else if (myParent.parent !== null) {
            checkParentPrezentation(myParent.parent)
        }
    }
    function checkSlide(myParent){
        if(myParent.isSlide){
            parentSlide=myParent
        } else if (myParent.parent !== null) {
            checkSlide(myParent.parent)
        }
    }

    Component.onCompleted: {
        checkParentPrezentation(parent);
        checkSlide(parent);
    }

    Rectangle {
        property real bw: height / 250
        id: background
        anchors.fill: parent
        radius: height / 10;
        gradient: Gradient {
            GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
            GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
        }
        border.color: parentSlide.textColor;
        border.width: bw < 0.53 ? 0.53 : (bw > 1 ? 1 : bw)
        antialiasing: true
    }

    onVisibleChanged: {
        listView.focus = root.visible;
        listView.currentIndex = -1;
        if(visible == true)
            showTheCode.start();
    }

    ListView {
        id: listView;

        anchors.fill: parent;
        anchors.margins: background.radius / 2
        clip: true

        model: code;
        focus: true;

        MouseArea {
            anchors.fill: parent
            onClicked: {
                listView.focus = true;
                listView.currentIndex = listView.indexAt(mouse.x, mouse.y + listView.contentY);
            }

        }

        delegate: Item {

            id: itemDelegate

            height: lineLabel.height
            width: parent.width

            Rectangle {
                id: lineLabelBackground
                width: lineLabel.height * 3;
                height: lineLabel.height;
                color: parentSlide.textColor;
                opacity: 0.1;
            }

            Text {
                id: lineLabel
                anchors.right: lineLabelBackground.right;
                text: (index+1) + ":"
                color: parentSlide.textColor;
                font.family: root.codeFontFamily
                font.pixelSize: root.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem;
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9;

            }

            Rectangle {
                id: lineContentBackground
                anchors.fill: lineContent;
                anchors.leftMargin: -height / 2;
                color: parentSlide.textColor
                opacity: 0.2
                visible: itemDelegate.ListView.isCurrentItem;
            }

            Text {
                id: lineContent
                anchors.left: lineLabelBackground.right
                anchors.leftMargin: lineContent.height;
                anchors.right: parent.right;
                color: parentSlide.textColor;
                text: code[index];
                font.family: root.codeFontFamily
                font.pixelSize: root.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem;
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9;
            }
        }
    }
    ParallelAnimation{
        id:showTheCode
        NumberAnimation { target: root; property: "opacity"; from: 0; to: 1; duration: presentation.transitionTime; easing.type: Easing.InQuart }
        NumberAnimation { target: root; property: "scale"; from: 0.7; to: 1; duration:presentation.transitionTime; easing.type: Easing.InOutQuart }
    }
}
