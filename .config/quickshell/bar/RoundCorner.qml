import QtQuick
import QtQuick.Shapes

Item {
    id: root

    enum Corner { TopLeft, TopRight, BottomLeft, BottomRight }
    property int corner: RoundCorner.Corner.TopLeft
    property int size: 16
    property color color: "#1e1a24"

    implicitWidth: size
    implicitHeight: size

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.smooth: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeWidth: 0
            fillColor: root.color

            startX: (root.corner === RoundCorner.Corner.TopLeft || root.corner === RoundCorner.Corner.BottomLeft) ? 0 : root.size
            startY: (root.corner === RoundCorner.Corner.TopLeft || root.corner === RoundCorner.Corner.TopRight) ? 0 : root.size

            PathAngleArc {
                moveToStart: false
                centerX: root.size - ((root.corner === RoundCorner.Corner.TopLeft || root.corner === RoundCorner.Corner.BottomLeft) ? 0 : root.size)
                centerY: root.size - ((root.corner === RoundCorner.Corner.TopLeft || root.corner === RoundCorner.Corner.TopRight) ? 0 : root.size)
                radiusX: root.size
                radiusY: root.size
                startAngle: {
                    switch (root.corner) {
                        case RoundCorner.Corner.TopLeft: return 180
                        case RoundCorner.Corner.TopRight: return -90
                        case RoundCorner.Corner.BottomLeft: return 90
                        case RoundCorner.Corner.BottomRight: return 0
                    }
                }
                sweepAngle: 90
            }
            PathLine {
                x: (root.corner === RoundCorner.Corner.TopLeft || root.corner === RoundCorner.Corner.BottomLeft) ? 0 : root.size
                y: (root.corner === RoundCorner.Corner.TopLeft || root.corner === RoundCorner.Corner.TopRight) ? 0 : root.size
            }
        }
    }
}
