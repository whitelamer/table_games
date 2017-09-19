TEMPLATE = app
#3dcore 3drender 3dinput 3dquick
QT += qml quick widgets
CONFIG += c++11 link_pkgconfig
CONFIG+=qml_debug
#PKGCONFIG += bullet
SOURCES += main.cpp

RESOURCES +=

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    three.js \
    main.qml \
    calibration.sh \
    DropAreaDelegate.qml \
    cannon.js \
    CUB.json \
    ammo.js \
    physics.js \
    DragFishkaDelegate_Column.qml \
    DragFishkaDelegate_Row.qml \
    DropAreaDelegate_Column.qml \
    Fishka.qml \
    temp_design.qml \
    Drop.qml \
    menu1x.qml \
    Menu1x_.qml \
    ListsDelegate.qml \
    UserCard.qml \
    TableButton.qml \
    oldandtempfunc.js \
    Backgammon1x.qml \
    Backgammon2x.qml \
    WinForm.qml \
    GameSettingsMenu.qml \
    GameSelectMenu.qml \
    Menu1x_test.qml \
    backgammon_logic.js \
    gl_draw_code.js \
    gl_logic.js \
    index.html \
    calc_script.js

HEADERS += \
    process.h
