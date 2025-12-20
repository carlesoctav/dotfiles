import qs.modules.common
import qs.modules.common.widgets
import qs.services
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root
    property int workspaceId: Hyprland.focusedMonitor?.activeWorkspace?.id ?? 1

    property real valueIndicatorVerticalPadding: 12
    property real valueIndicatorHorizontalPadding: 24

    implicitWidth: Appearance.sizes.osdWidth + 2 * Appearance.sizes.elevationMargin
    implicitHeight: valueIndicator.implicitHeight + 2 * Appearance.sizes.elevationMargin

    StyledRectangularShadow {
        target: valueIndicator
    }
    Rectangle {
        id: valueIndicator
        anchors {
            fill: parent
            margins: Appearance.sizes.elevationMargin
        }
        radius: Appearance.rounding.full
        color: Appearance.colors.colLayer0

        implicitWidth: contentRow.implicitWidth + valueIndicatorHorizontalPadding * 2
        implicitHeight: contentRow.implicitHeight + valueIndicatorVerticalPadding * 2

        RowLayout {
            id: contentRow
            anchors.centerIn: parent
            spacing: 8

            StyledText {
                color: Appearance.colors.colOnLayer0
                font.pixelSize: Appearance.font.pixelSize.normal
                text: "Workspace"
            }

            StyledText {
                color: Appearance.colors.colOnLayer0
                font.pixelSize: Appearance.font.pixelSize.larger
                font.weight: Font.Medium
                text: root.workspaceId
            }
        }
    }
}
