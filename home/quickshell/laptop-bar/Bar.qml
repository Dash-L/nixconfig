import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens;
        PanelWindow {
            required property var modelData;

            screen: modelData;

            color: "transparent";

            anchors {
                top: true;
                left: true;
                right: true;
            }

            margins {
                left: 30;
                right: 30;
            }

            implicitHeight: 30;

            ClockWidget {
                anchors.centerIn: parent;
            }

            BluetoothWidget {
                anchors.right: parent.right;
                anchors.verticalCenter: parent.verticalCenter;
            }
        }
    }
}
