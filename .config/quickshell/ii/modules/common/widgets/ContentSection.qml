import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets

ColumnLayout {
    id: root
    property string title
    property string icon: ""
    property bool collapsed: true
    property bool collapsible: true
    default property alias data: sectionContent.data

    Layout.fillWidth: true
    spacing: 6

    RowLayout {
        spacing: 6
        Layout.fillWidth: true

        OptionalMaterialSymbol {
            icon: root.icon
            iconSize: Appearance.font.pixelSize.hugeass
        }
        StyledText {
            text: root.title
            font.pixelSize: Appearance.font.pixelSize.larger
            font.weight: Font.Medium
            color: Appearance.colors.colOnSecondaryContainer
            Layout.fillWidth: true
        }
        MaterialSymbol {
            visible: root.collapsible
            text: root.collapsed ? "expand_more" : "expand_less"
            iconSize: Appearance.font.pixelSize.larger
            color: Appearance.colors.colOnSurfaceVariant
            
            Behavior on text {
                enabled: Appearance.animations.enabled
            }
        }

        MouseArea {
            anchors.fill: parent
            visible: root.collapsible
            cursorShape: Qt.PointingHandCursor
            onClicked: root.collapsed = !root.collapsed
        }
    }

    ColumnLayout {
        id: sectionContent
        Layout.fillWidth: true
        spacing: 4
        visible: !root.collapsed
        opacity: root.collapsed ? 0 : 1

        Behavior on opacity {
            enabled: Appearance.animations.enabled
            NumberAnimation {
                duration: Appearance.animations.durationSmall
                easing.type: Easing.OutQuad
            }
        }
    }
}
