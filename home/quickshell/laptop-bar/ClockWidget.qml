import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperMouseArea {
    id: root;
    
    property bool preciseLocked: false;

    hoverEnabled: true;
    onClicked: { root.preciseLocked = !root.preciseLocked; }
    onEntered: { Time.precise = true; }
    onExited: { Time.precise = root.preciseLocked; }

    WrapperRectangle {
        color: "#515151";
        radius: 10;
        topMargin: 3;
        bottomMargin: 3;
        leftMargin: 10;
        rightMargin: 10;

        Text {
            text: Time.time;
            color: root.preciseLocked || !Time.precise ? "white" : "#c5eff7";
            font {
                pointSize: 9;
                family: "SpaceMono";
            }
        }
    }
}
