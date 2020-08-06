import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: win
    visible: true
    width: 940
    height: 680
    title: "Basic QML"

    Rectangle
    {
        anchors.fill: parent
        gradient: Gradient
        {
            GradientStop {position: 0.000;color: Qt.rgba(1, 0, 0, 1);}
            GradientStop {position: 0.167;color: Qt.rgba(1, 1, 0, 1);}
            GradientStop {position: 0.333;color: Qt.rgba(0, 1, 0, 1);}
            GradientStop {position: 0.500;color: Qt.rgba(0, 1, 1, 1);}
            GradientStop {position: 0.667;color: Qt.rgba(0, 0, 1, 1);}
            GradientStop {position: 0.833;color: Qt.rgba(1, 0, 1, 1);}
            GradientStop {position: 1.000;color: Qt.rgba(1, 0, 0, 1);}
        }
    }
}
