import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

WBarAttachedPanelContent {
    id: root

    property int workspaceId: Hyprland.focusedMonitor?.activeWorkspace?.id ?? 1

    property Timer timer: Timer {
        id: autoCloseTimer
        running: true
        interval: Config.options.osd.timeout
        repeat: false
        onTriggered: {
            root.close();
        }
    }

    Connections {
        target: Hyprland.focusedMonitor
        function onActiveWorkspaceChanged() {
            root.timer.restart();
        }
    }

    contentItem: WPane {
        anchors.centerIn: parent
        borderColor: Looks.colors.ambientShadow

        contentItem: Item {
            implicitWidth: 80
            implicitHeight: 46

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                FluentIcon {
                    Layout.alignment: Qt.AlignVCenter
                    icon: "applist"
                    implicitSize: 18
                }

                WTextWithFixedWidth {
                    text: root.workspaceId
                    implicitWidth: 20
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
