QT += quick widgets

SOURCES += \
        main.cc \
        qml_translator.cc

macx: {
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.15
}

CONFIG += c++17

#resources.files = main.qml
#resources.prefix = /$${TARGET}
RESOURCES += \
    resources.qrc

lupdate_only {
    SOURCES += qml/Constants/Constants.qml
    SOURCES += main.qml
}

TRANSLATIONS += lang_en.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    qml_translator.h
