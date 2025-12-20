import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

ContentPage {
    forceWidth: true

    component SmallLightDarkPreferenceButton: RippleButton {
        id: smallLightDarkPreferenceButton
        required property bool dark
        property color colText: toggled ? Appearance.colors.colOnPrimary : Appearance.colors.colOnLayer2
        padding: 10
        toggled: Appearance.m3colors.darkmode === dark
        colBackground: Appearance.colors.colLayer2
        onClicked: {
            Quickshell.execDetached(["bash", "-c", `${Directories.wallpaperSwitchScriptPath} --mode ${dark ? "dark" : "light"} --noswitch`]);
        }
        contentItem: RowLayout {
            spacing: 8
            MaterialSymbol {
                iconSize: 24
                text: dark ? "dark_mode" : "light_mode"
                color: smallLightDarkPreferenceButton.colText
            }
            StyledText {
                text: dark ? Translation.tr("Dark") : Translation.tr("Light")
                font.pixelSize: Appearance.font.pixelSize.small
                color: smallLightDarkPreferenceButton.colText
            }
        }
    }

    // Wallpaper & Colors
    ContentSection {
        icon: "format_paint"
        title: Translation.tr("Wallpaper & Colors")
        Layout.fillWidth: true

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            // Wallpaper preview
            Item {
                implicitWidth: 200
                implicitHeight: 120
                
                StyledImage {
                    id: wallpaperPreview
                    anchors.fill: parent
                    sourceSize.width: parent.implicitWidth
                    sourceSize.height: parent.implicitHeight
                    fillMode: Image.PreserveAspectCrop
                    source: Config.options.background.wallpaperPath
                    cache: false
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: 200
                            height: 120
                            radius: Appearance.rounding.small
                        }
                    }
                }

                // Choose file overlay button
                RippleButton {
                    anchors.fill: parent
                    buttonRadius: Appearance.rounding.small
                    colBackground: "transparent"
                    colBackgroundHover: Qt.rgba(0, 0, 0, 0.3)
                    onClicked: {
                        Quickshell.execDetached(`${Directories.wallpaperSwitchScriptPath}`);
                    }
                    contentItem: Item {}
                    StyledToolTip {
                        text: Translation.tr("Choose wallpaper")
                    }
                }
            }

            // Controls
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                // Light/Dark toggle
                RowLayout {
                    spacing: 8
                    SmallLightDarkPreferenceButton {
                        dark: false
                    }
                    SmallLightDarkPreferenceButton {
                        dark: true
                    }
                }

                // Scheme selection
                ConfigSelectionArray {
                    currentValue: Config.options.appearance.palette.type
                    onSelected: newValue => {
                        Config.options.appearance.palette.type = newValue;
                        Quickshell.execDetached(["bash", "-c", `${Directories.wallpaperSwitchScriptPath} --noswitch`]);
                    }
                    options: [
                        { "value": "scheme-tonal-spot", "displayName": Translation.tr("Tonal Spot") },
                        { "value": "scheme-content", "displayName": Translation.tr("Content") },
                        { "value": "scheme-fidelity", "displayName": Translation.tr("Fidelity") },
                        { "value": "scheme-neutral", "displayName": Translation.tr("Neutral") },
                        { "value": "scheme-monochrome", "displayName": Translation.tr("Mono") }
                    ]
                }
            }
        }
    }

    // Bar & Screen
    ContentSection {
        icon: "screenshot_monitor"
        title: Translation.tr("Bar & screen")

        ConfigRow {
            ContentSubsection {
                title: Translation.tr("Bar position")
                ConfigSelectionArray {
                    currentValue: (Config.options.bar.bottom ? 1 : 0) | (Config.options.bar.vertical ? 2 : 0)
                    onSelected: newValue => {
                        Config.options.bar.bottom = (newValue & 1) !== 0;
                        Config.options.bar.vertical = (newValue & 2) !== 0;
                    }
                    options: [
                        { displayName: Translation.tr("Top"), icon: "arrow_upward", value: 0 },
                        { displayName: Translation.tr("Left"), icon: "arrow_back", value: 2 },
                        { displayName: Translation.tr("Bottom"), icon: "arrow_downward", value: 1 },
                        { displayName: Translation.tr("Right"), icon: "arrow_forward", value: 3 }
                    ]
                }
            }
            ContentSubsection {
                title: Translation.tr("Bar style")
                ConfigSelectionArray {
                    currentValue: Config.options.bar.cornerStyle
                    onSelected: newValue => {
                        Config.options.bar.cornerStyle = newValue;
                    }
                    options: [
                        { displayName: Translation.tr("Hug"), icon: "line_curve", value: 0 },
                        { displayName: Translation.tr("Float"), icon: "page_header", value: 1 },
                        { displayName: Translation.tr("Rect"), icon: "toolbar", value: 2 }
                    ]
                }
            }
        }

        ConfigRow {
            ContentSubsection {
                title: Translation.tr("Screen round corner")
                ConfigSelectionArray {
                    currentValue: Config.options.appearance.fakeScreenRounding
                    onSelected: newValue => {
                        Config.options.appearance.fakeScreenRounding = newValue;
                    }
                    options: [
                        { displayName: Translation.tr("No"), icon: "close", value: 0 },
                        { displayName: Translation.tr("Yes"), icon: "check", value: 1 },
                        { displayName: Translation.tr("When not fullscreen"), icon: "fullscreen_exit", value: 2 }
                    ]
                }
            }
        }
    }
}
