import QtQuick 2.0

Item {
    width: 500
    height: 480
    Rectangle {
        id: rectangle
        color: "#ffffff"
        radius: 15
        anchors.fill: parent

        Text {
            id: text1
            x: 191
            y: 36
            width: 258
            height: 39
            text: qsTr("Белые выиграли")
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 33
        }

        UserCard {
            id: userCard
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: rectangle1
            x: 389
            y: 370
            width: 200
            height: 63
            color: "#129b19"
            anchors.right: parent.right
            anchors.rightMargin: 25

            Text {
                id: text2
                text: qsTr("Повторить")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.pixelSize: 34
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
            }
        }

        Rectangle {
            id: rectangle2
            y: 370
            width: 200
            height: 63
            color: "#129b19"
            anchors.left: parent.left
            anchors.leftMargin: 25
            Text {
                id: text3
                text: qsTr("Меню")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.pixelSize: 34
            }

            MouseArea {
                id: mouseArea1
                anchors.fill: parent
            }
        }
    }
    function setWiner(color,player){
        if(color==0){
            text1.text=qsTr("Белые выиграли")
        }else{
            text1.text=qsTr("Черные выиграли")
        }

    }
}
