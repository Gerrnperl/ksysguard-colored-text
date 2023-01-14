import QtQuick 2.9
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.1

import org.kde.kirigami 2.8 as Kirigami
import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.ksysguard.faces 1.0 as Faces
import org.kde.quickcharts 1.0 as Charts
import org.kde.quickcharts.controls 1.0 as ChartControls
import org.kde.plasma.core 2.0 as PlasmaCore

RowLayout {

	property color actualColor 
    property string sensorValue
	property string sensorName
    // property int fixed_width

	id: sensor
	Layout.fillHeight: true 
    Layout.fillWidth: true
    Layout.alignment : Qt.AlignHCenter | Qt.AlignTop
    
    // Layout.preferredWidth: fixed_width
    Layout.minimumWidth: 50
    // Layout.maximumWidth: fixed_width

    Controls.Label {
        Layout.alignment: Qt.AlignLeft
        id: itemLabel
        visible: true
        color: actualColor
        z:1
        horizontalAlignment: Text.AlignHCenter
        text: sensorName
        font.pointSize: Kirigami.Theme.defaultFont.pointSize * 0.8
        antialiasing : true        
    }
    Controls.Label {
        Layout.alignment: Qt.AlignRight
        id: itemValue
        visible: true
        color: actualColor
        z:1
        horizontalAlignment: Text.AlignHCenter
        text: sensorValue
        font.pointSize: Kirigami.Theme.defaultFont.pointSize * 0.8
        antialiasing : true        
    }
}