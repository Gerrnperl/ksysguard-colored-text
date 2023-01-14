import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

import org.kde.kirigami 2.8 as Kirigami

import org.kde.ksysguard.faces 1.0 as Faces
import org.kde.ksysguard.sensors 1.0 as Sensors


ColumnLayout {
	id: total

	Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

    readonly property bool autoRange: controller.faceConfiguration.autoRange
    readonly property double rangeFrom: controller.faceConfiguration.rangeFrom * controller.faceConfiguration.rangeFromMultiplier
    readonly property double rangeTo: controller.faceConfiguration.rangeTo * controller.faceConfiguration.rangeToMultiplier
    readonly property bool enableColorGradient: controller.faceConfiguration.enableColorGradient
	readonly property color colorGradientFrom: controller.faceConfiguration.colorGradientFrom
	readonly property color colorGradientTo: controller.faceConfiguration.colorGradientTo
    readonly property bool showBar: controller.faceConfiguration.showBar
    readonly property string barPosition: controller.faceConfiguration.barPosition

    ColorUtils.Gradien {
        id : gradien
    }

	visible: true
	property double percent :sensor.value / (autoRange ? (sensor.maximum - sensor.minimum) : (rangeTo - rangeFrom))
	property double clamped_percent : percent > 1 ? 1 : (percent < 0 ? 0 : percent)
	property color actualColor : enableColorGradient ? gradien.generateGradient(colorGradientFrom, colorGradientTo, clamped_percent) : Kirigami.Theme.textColor

	Layout.minimumWidth: main.width + 5

	Sensors.Sensor {
		id: sensor
		sensorId: root.controller.totalSensors[0]
	}

	GridLayout {
		id: main
		columns : total.barPosition == "bottom" ? 1 : 2
		Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
		TextSensor {
			Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
			id: textSensor
			actualColor: total.actualColor
			sensorValue: sensor.formattedValue
			sensorName: root.controller.sensorLabels[root.controller.totalSensors[0]] || sensor.shortName
		}

		PercentBar {
			id: percentBar
			percent: total.clamped_percent
			color: total.actualColor
			place: total.barPosition
			visible: total.showBar
			parent_w: parent.width
			parent_h: parent.height
			Layout.alignment: Qt.AlignBottom
		}
	}
}