#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFile>
#include <QStandardPaths>

int main(int argc, char *argv[])
{
	//QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);
	QString tempDir = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
	bool result = QFile::copy(":/sounds/track1.mp3", tempDir + "/track1.mp3" );
	app.setOrganizationName("tarmo-qt");
	app.setOrganizationDomain("tarmo-qt.com");		  app.setApplicationName("clicktrack-player");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
