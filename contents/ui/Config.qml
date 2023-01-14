import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.2 as Controls

import org.kde.kirigami 2.8 as Kirigami

import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.ksysguard.faces 1.0 as Faces

Kirigami.FormLayout {
    id: root

	property alias cfg_autoRange: autoRangeCheckbox.checked
	property alias cfg_rangeFrom: rangeFromSpin.value
	property alias cfg_rangeFromMultiplier: rangeFromSpin.multiplier
	property alias cfg_rangeTo: rangeToSpin.value
	property alias cfg_rangeToMultiplier: rangeToSpin.multiplier
	property alias cfg_enableColorGradient: enableColorGradientCheckbox.checked
	property alias cfg_colorGradientFrom: colorGradientFromColorbox.color
	property alias cfg_colorGradientTo: colorGradientToColorbox.color
	property alias cfg_showBar: showBarCheckbox.checked
	property string cfg_barPosition: controller.faceConfiguration.barPosition

	Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    ColumnLayout {
        Kirigami.FormData.label: "Data"
		spacing: 10
		Layout.alignment: Qt.AlignHCenter
        Controls.CheckBox {
			id: autoRangeCheckbox
            text: i18n("Auto data range")
        }

        Row {
			spacing: 20
            Controls.Label {
                text: i18n("Range from: ")
            }
            Faces.SensorRangeSpinBox {
				id: rangeFromSpin
                value: rangeFrom
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				sensors: controller.totalSensors
				width: 100
				enabled: !cfg_autoRange
            }
        }
        Row {
			spacing: 20
            Controls.Label {
                text: i18n("Range to:   ")
            }
			Faces.SensorRangeSpinBox {
				id: rangeToSpin
				value: rangeTo
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				sensors: controller.totalSensors
				width: 100
				enabled: !cfg_autoRange
			}
        }
	}

	Kirigami.Separator {
        Kirigami.FormData.isSection: true
    }

	ColumnLayout {
        Kirigami.FormData.label: "Color"
		spacing: 10
        Controls.CheckBox {
			id: enableColorGradientCheckbox
            text: i18n("Enable color gradient")
        }
        Row {
            Controls.Label {
                text: i18n("Color gradient from: ")
            }
			Rectangle{
				id: colorGradientFromColorbox
				color: colorGradientFrom
				width: Kirigami.Theme.defaultFont.pointSize * 1.5
				height: Kirigami.Theme.defaultFont.pointSize * 1.5
				border.color: "grey"
				border.width: 1
				radius: 3
				visible: true
				MouseArea {
					anchors.fill: parent
					onClicked: fromColorDialog.open()
				}
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				enabled: cfg_enableColorGradient
			}
			ColorDialog {
				id: fromColorDialog
				title: i18n("Please choose a color")
				color: cfg_colorGradientFrom
				onAccepted: {
					cfg_colorGradientFrom = fromColorDialog.color
				}
				visible: false
				modality: Qt.WindowModal
			}
        }
        Row {
			Controls.Label {
				text: i18n("Color gradient to:   ")
			}
			Rectangle{
				id: colorGradientToColorbox
				color: colorGradientTo
				width: Kirigami.Theme.defaultFont.pointSize * 1.5
				height: Kirigami.Theme.defaultFont.pointSize * 1.5
				border.color: "grey"
				border.width: 1
				radius: 3
				visible: true
				MouseArea {
					anchors.fill: parent
					onClicked: toColorDialog.open()
				}
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				enabled: cfg_enableColorGradient
			}
			ColorDialog {
				id: toColorDialog
				title: i18n("Please choose a color")
				color: cfg_colorGradientTo
				onAccepted: {
					cfg_colorGradientTo = toColorDialog.color
				}
				visible: false
				modality: Qt.WindowModal
			}
        }
	}

	Kirigami.Separator {
        Kirigami.FormData.isSection: true
    }

	ColumnLayout {
        Kirigami.FormData.label: "Bar"
		spacing: 10
        Controls.CheckBox {
			id: showBarCheckbox
			text: i18n("Show bar")
		}

		Controls.ButtonGroup {
            id: typeGroup
        }
        Controls.RadioButton {
            text: "bottom"
            checked: cfg_barPosition == this.text
			enabled: cfg_showBar
            Controls.ButtonGroup.group: typeGroup
            onCheckedChanged: {
                if (checked) {
                    cfg_barPosition = this.text
                }
            }
        }
        Controls.RadioButton {
            text: "right"
            Controls.ButtonGroup.group: typeGroup
            checked: cfg_barPosition == this.text
			enabled: cfg_showBar
            onCheckedChanged: {
                if (checked) {
                    cfg_barPosition = this.text
                }
            }
        }
	}
}
