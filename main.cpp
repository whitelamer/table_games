#include <QGuiApplication>
#include <QQmlApplicationEngine>

//#include <window.h>
//#include <Qt3DCore/QCamera>
//#include <Qt3DQuick/QQmlAspectEngine>

//#include <Qt3DRender/QRenderAspect>
//#include <Qt3DRender/QFrameGraph>
//#include <Qt3DRender/QForwardRenderer>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
//    Window view;
//          Qt3DCore::Quick::QQmlAspectEngine engine;
//          engine.aspectEngine()->registerAspect(new Qt3DRender::QRenderAspect());
//          QVariantMap data;
//          data.insert(QStringLiteral("surface"), QVariant::fromValue(static_cast<QSurface *>(&view)));
//          data.insert(QStringLiteral("eventSource"), QVariant::fromValue(&view));
//          engine.aspectEngine()->setData(data);
//          engine.setSource(QUrl(QStringLiteral("./main.qml")));
//          view.show();
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("./main.qml")));

    return app.exec();
}
