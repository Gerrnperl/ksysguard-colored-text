import QtQuick 2.9
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.1

Rectangle {
    id: percentBar
    property double percent
    property color color
    property string place
    property int parent_w
    property int parent_h

	property int bar_height: 3
	property bool place_bottom: place === "bottom"

    readonly property int barWidth: controller.faceConfiguration.barWidth

    width: place_bottom ? parent_w : barWidth
    height: place_bottom ? barWidth : parent_h
    color: "transparent"

    Rectangle {
        width: place_bottom ? percentBar.parent_w : percentBar.barWidth
        height: place_bottom ? percentBar.barWidth : percentBar.parent_h
        color: Qt.rgba(percentBar.color.r, percentBar.color.g, percentBar.color.b, 0.3);
		anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

	Rectangle {
        width: place_bottom ? percentBar.parent_w * percentBar.percent : percentBar.barWidth
        height: place_bottom ? percentBar.barWidth : percentBar.parent_h * percentBar.percent
        color: percentBar.color
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }
}
