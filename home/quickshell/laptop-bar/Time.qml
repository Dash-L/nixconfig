pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root;

    property bool precise: false;
    readonly property string time: {
        Qt.formatDateTime(clock.date, `yyyy-MM-dd ddd hh:mm${root.precise ? ":ss" : ""} AP`)
    }
    
    SystemClock {
        id: clock;
        precision: root.precise ? SystemClock.Seconds : SystemClock.Minutes;
    }
}
