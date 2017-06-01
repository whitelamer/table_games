#include <QApplication>
#include <QDesktopWidget>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include "process.h"
#include "bulletsim.h"
//#include <Qt3DRender/QRenderAspect>
//#include <Qt3DInput/QInputAspect>
//#include <Qt3DQuick/QQmlAspectEngine>

#include <QGuiApplication>
#include <QtQml>

//#include <window.h>

//#include <Qt3DCore/QCamera>
//#include <Qt3DQuick/QQmlAspectEngine>

//#include <Qt3DRender/QRenderAspect>
//#include <Qt3DRender/QFrameGraph>
//#include <Qt3DRender/QForwardRenderer>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //bulletSim *b=new bulletSim();
    qmlRegisterType<Process>("Processlib", 1, 0, "Process");
    qmlRegisterType<bulletSim>("BulletSim", 1, 0, "BulletSim");
    //engine.rootContext()->setContextProperty("bullet", &b);
    engine.load(QUrl(QStringLiteral("./main.qml")));

    return app.exec();
}
/*int main(int argc, char* argv[])
  {
      QGuiApplication app(argc, argv);
      Window view;
      Qt3DCore::Quick::QQmlAspectEngine engine;

      engine.aspectEngine()->registerAspect(new Qt3DRender::QRenderAspect());
      engine.aspectEngine()->registerAspect(new Qt3DInput::QInputAspect());
      qmlRegisterType<Process>("Processlib", 1, 0, "Process");
      QVariantMap data;
      data.insert(QStringLiteral("surface"), QVariant::fromValue(static_cast<QSurface *>(&view)));
      data.insert(QStringLiteral("eventSource"), QVariant::fromValue(&view));
      engine.aspectEngine()->setData(data);
      engine.setSource(QUrl("./main3d.qml"));
      view.show();
      //view.setWindowState(Qt::WindowFullScreen);
      return app.exec();
  }*/
