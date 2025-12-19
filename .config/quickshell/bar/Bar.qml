import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: bar

    readonly property color bgColor: "#dd1e1a24"
    readonly property color surfaceColor: "#2a2630"
    readonly property color textColor: "#e6e1e6"
    readonly property color textDimColor: "#cac4cf"
    readonly property color primaryColor: "#d4bbff"
    readonly property color primaryTextColor: "#3f2d6b"
    readonly property int cornerSize: 23
    readonly property int barHeight: 40
    readonly property int widgetRadius: 17

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            
            required property ShellScreen modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: bar.barHeight + bar.cornerSize
            exclusiveZone: bar.barHeight
            color: "transparent"

            WlrLayershell.namespace: "quickshell:bar"
            WlrLayershell.layer: WlrLayer.Top

            // Main bar content
            Rectangle {
                id: barContent
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: bar.barHeight
                color: bar.bgColor

                // Left: Workspaces
                Rectangle {
                    id: workspacesContainer
                    anchors {
                        left: parent.left
                        leftMargin: 12
                        verticalCenter: parent.verticalCenter
                    }
                    height: 32
                    width: wsRow.width + 20
                    color: bar.surfaceColor
                    radius: bar.widgetRadius

                    Row {
                        id: wsRow
                        anchors.centerIn: parent
                        spacing: 4

                        Repeater {
                            model: 10

                            Rectangle {
                                id: wsButton
                                property int wsId: index + 1
                                property bool isActive: Hyprland.focusedMonitor?.activeWorkspace?.id === wsId
                                property bool hasWindows: {
                                    for (let i = 0; i < Hyprland.workspaces.values.length; i++) {
                                        if (Hyprland.workspaces.values[i].id === wsId) {
                                            return true
                                        }
                                    }
                                    return false
                                }

                                width: isActive ? 28 : 22
                                height: 22
                                radius: 9999
                                color: wsMouseArea.containsMouse ? Qt.lighter(bar.surfaceColor, 1.3) : (isActive ? bar.primaryColor : "transparent")

                                Behavior on width {
                                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                                }
                                Behavior on color {
                                    ColorAnimation { duration: 150 }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: wsId
                                    font.pixelSize: 11
                                    font.weight: Font.DemiBold
                                    font.family: "CaskaydiaMono Nerd Font Mono"
                                    color: isActive ? bar.primaryTextColor : (hasWindows ? bar.textColor : bar.textDimColor)
                                    opacity: hasWindows || isActive ? 1.0 : 0.5
                                }

                                MouseArea {
                                    id: wsMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    acceptedButtons: Qt.LeftButton
                                    onClicked: function(mouse) {
                                        Hyprland.dispatch("workspace " + wsId)
                                    }
                                }
                            }
                        }
                    }
                }

                // Center: Clock (absolutely centered)
                Rectangle {
                    id: clockContainer
                    anchors.centerIn: parent
                    height: 32
                    width: clockText.width + 28
                    color: bar.surfaceColor
                    radius: bar.widgetRadius

                    Text {
                        id: clockText
                        anchors.centerIn: parent
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                        font.family: "CaskaydiaMono Nerd Font Mono"
                        color: bar.textColor
                        text: Qt.formatDateTime(new Date(), "HH:mm • dddd, MM/dd")
                    }

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm • dddd, MM/dd")
                    }
                }

                // Right: System indicators
                Row {
                    id: rightIndicators
                    anchors {
                        right: parent.right
                        rightMargin: 12
                        verticalCenter: parent.verticalCenter
                    }
                    spacing: 6

                    // CPU
                    Rectangle {
                        height: 32
                        width: cpuText.width + 24
                        color: cpuMouse.containsMouse ? Qt.lighter(bar.surfaceColor, 1.2) : bar.surfaceColor
                        radius: bar.widgetRadius

                        Behavior on color { ColorAnimation { duration: 150 } }

                        Text {
                            id: cpuText
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.family: "CaskaydiaMono Nerd Font Mono"
                            color: bar.textColor
                            text: "󰍛"
                        }

                        MouseArea {
                            id: cpuMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton
                            onClicked: function(mouse) {
                                Hyprland.dispatch("exec alacritty -e btop")
                            }
                        }
                    }

                    // Volume
                    Rectangle {
                        height: 32
                        width: volText.width + 24
                        color: volMouse.containsMouse ? Qt.lighter(bar.surfaceColor, 1.2) : bar.surfaceColor
                        radius: bar.widgetRadius

                        Behavior on color { ColorAnimation { duration: 150 } }

                        Text {
                            id: volText
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.family: "CaskaydiaMono Nerd Font Mono"
                            color: bar.textColor
                            text: ""
                        }

                        MouseArea {
                            id: volMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton
                            onClicked: function(mouse) {
                                Hyprland.dispatch("exec pavucontrol")
                            }
                        }
                    }

                    // Network
                    Rectangle {
                        height: 32
                        width: netText.width + 24
                        color: netMouse.containsMouse ? Qt.lighter(bar.surfaceColor, 1.2) : bar.surfaceColor
                        radius: bar.widgetRadius

                        Behavior on color { ColorAnimation { duration: 150 } }

                        Text {
                            id: netText
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.family: "CaskaydiaMono Nerd Font Mono"
                            color: bar.textColor
                            text: "󰤨"
                        }

                        MouseArea {
                            id: netMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton
                            onClicked: function(mouse) {
                                Hyprland.dispatch("exec omarchy-launch-wifi")
                            }
                        }
                    }

                    // Battery
                    Rectangle {
                        height: 32
                        width: batText.width + 24
                        color: batMouse.containsMouse ? Qt.lighter(bar.surfaceColor, 1.2) : bar.surfaceColor
                        radius: bar.widgetRadius

                        Behavior on color { ColorAnimation { duration: 150 } }

                        Text {
                            id: batText
                            anchors.centerIn: parent
                            font.pixelSize: 12
                            font.family: "CaskaydiaMono Nerd Font Mono"
                            color: bar.textColor
                            text: "󰁹 100%"
                        }

                        MouseArea {
                            id: batMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton
                        }
                    }
                }
            }

            // Round corner decorators (the "hug" effect)
            RoundCorner {
                anchors {
                    top: barContent.bottom
                    left: parent.left
                }
                size: bar.cornerSize
                color: bar.bgColor
                corner: RoundCorner.Corner.TopLeft
            }

            RoundCorner {
                anchors {
                    top: barContent.bottom
                    right: parent.right
                }
                size: bar.cornerSize
                color: bar.bgColor
                corner: RoundCorner.Corner.TopRight
            }
        }
    }
}
