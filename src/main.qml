import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2


ApplicationWindow {
    id: appWindow
    title: "Hello"
    width: 1920
    height: 1080
    visible: true
    color: "black"

    Rectangle {
        anchors.centerIn: parent
        color: "grey"
        width: 512
        height: 64

        Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: true
            width: 32
            height: 32
            source: "qrc:///assets/video_tab_icon.svg"
            z: parent.z + 1
        }
    }

    Component.onCompleted: {
        console.log("ApplicationWindow loaded!");
        console.log("QT runtime: " + qtRuntimeVersion);
    }
}
