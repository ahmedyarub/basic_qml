#include <QApplication>
#include <QQmlContext>

#include <QQmlApplicationEngine>

int main(int argc, char **argv) {
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    app.setOrganizationName("Mind Power");
    app.setOrganizationDomain("mindpower.com");
    app.setApplicationName("Basic QML");

    engine.load(QUrl("qrc:/main.qml"));

    qDebug() << "Starting application";

    return QApplication::exec();
}
