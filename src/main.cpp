#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QResource>
#include <QtCore>
#include <QSslSocket>

#if defined(Q_OS_WIN)
#include <windows.h>
#endif

#if defined(Q_OS_LINUX) && defined(STATIC)
Q_IMPORT_PLUGIN(QXcbIntegrationPlugin)
#endif

int main(int argc, char *argv[]) {
  Q_INIT_RESOURCE(assets);

  qputenv("QML_DISABLE_DISK_CACHE", "1");
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QCoreApplication::setApplicationName("qml_hello");
  QCoreApplication::setOrganizationDomain("sanderf.nl");
  QCoreApplication::setOrganizationName("sanderf.nl");
  QGuiApplication app(argc, argv);

  const QUrl url(QStringLiteral("qrc:/main.qml"));

  qDebug() << "SSL version: " << QSslSocket::sslLibraryVersionString();
  qDebug() << "SSL build: " << QSslSocket::sslLibraryBuildVersionString();

  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("qtRuntimeVersion", qVersion());
  engine.load(url);

  return QCoreApplication::exec();
}
