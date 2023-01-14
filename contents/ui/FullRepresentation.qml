import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

import org.kde.kirigami 2.8 as Kirigami

import org.kde.ksysguard.faces 1.0 as Faces
import org.kde.ksysguard.sensors 1.0 as Sensors

Faces.SensorFace {
    id: root
    contentItem: ColumnLayout {
        Kirigami.Heading {
            Layout.alignment: Qt.AlignHCenter
            text: controller.title
            visible: controller.showTitle
            level: 2
        }

        TotalSensor {}

        Sensors.SensorDataModel {
            id: sensorModel
            sensors: controller.highPrioritySensorIds
            sensorColors: controller.sensorColors
        }

       Faces.ExtendedLegend {
            sourceModel: sensorModel
            sensorIds: controller.lowPrioritySensorIds
            Layout.fillWidth: true
        }
    }
}