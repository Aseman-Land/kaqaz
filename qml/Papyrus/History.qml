/*
    Copyright (C) 2014 Aseman
    http://aseman.co

    Papyrus is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Papyrus is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import Papyrus 1.0
import AsemanTools 1.0

Item {
    id: history
    width: 100
    height: 62

    Image {
        anchors.fill: parent
        anchors.topMargin: -View.statusBarHeight
        anchors.bottomMargin: -View.navigationBarHeight
        source: "files/menu_background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Header {
        id: title
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        light: true
    }

    ListView {
        id: history_list
        anchors.top: title.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 20*Devices.density
        highlightMoveDuration: 250
        clip: true
        maximumFlickVelocity: View.flickVelocity

        model: HistoryModel {}
        delegate: Rectangle {
            id: item
            width: history_list.width
            height: 50*Devices.density
            color: marea.pressed? "#3B97EC" : "#00000000"

            Text{
                id: txt
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 25*Devices.density
                y: parent.height/2 - height/2
                text: model.text
                font.pixelSize: 11*Devices.fontDensity
                font.family: AsemanApp.globalFont.family
                color: "#ffffff"
            }

            Rectangle{
                id: papers_count
                width: height
                height: 22*Devices.density
                radius: 3*Devices.density
                color: "#ffffff"
                anchors.verticalCenter: item.verticalCenter
                anchors.left: (txt.horizontalAlignment == Qt.AlignRight)? item.left : item.right
                anchors.leftMargin: (txt.horizontalAlignment == Qt.AlignRight)? 10*Devices.density : -width - 10*Devices.density

                Text{
                    id: papers_count_txt
                    x: papers_count.width/2 - width/2
                    y: papers_count.height/2 - height/2
                    color: "#235089"
                    text: model.papersCount
                }
            }

            MouseArea{
                id: marea
                anchors.fill: parent
                onClicked: {
                    var nodes = database.papersOf(CalendarConv.convertDaysToDate(model.date))
                    if( nodes.length === 0 )
                        return

                    main.setCurrentGroup(model.date,PaperManager.Date)
                    main.popPreference()
                }
            }
        }

        focus: true
        highlight: Rectangle { color: "#3B97EC"; radius: 3; smooth: true }
        currentIndex: -1

        onCurrentItemChanged: {
            if( !currentItem )
                return
        }
    }

    ScrollBar {
        scrollArea: history_list; height: history_list.height; width: 6*Devices.density
        anchors.right: history_list.right; anchors.top: history_list.top; color: "#ffffff"
    }

    Connections{
        target: papyrus
        onLanguageChanged: initTranslations()
    }

    function initTranslations(){
        title.text = qsTr("History")
    }

    Component.onCompleted: {
        initTranslations()
    }
}
