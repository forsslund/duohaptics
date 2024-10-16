################################################################################
# KTH Duohaptics Application
# Developed by Jonas Forsslund / Forsslund Systems AB december 2017
#
# To run make sure executable directory is the source directory in order
# to find textures and hdPhantom64.dll needed in Windows to access Phantom
# haptic devices.
#
################################################################################
TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp

#CONFIG += use_osc

win32{
    CHAI3D = c:/chai3d
}

use_osc {
    SOURCES += osc/osc/OscOutboundPacketStream.cpp  \
               osc/osc/OscPrintReceivedElements.cpp \
               osc/osc/OscReceivedElements.cpp \
               osc/osc/OscTypes.cpp \
               osc/ip/IpEndpointName.cpp \
               osc/ip/win32/NetworkingUtils.cpp \
               osc/ip/win32/UdpSocket.cpp
    HEADERS += osc/osc/OscException.h \
               osc/osc/OscOutboundPacketStream.h \
               osc/osc/OscTypes.h \
               osc/ip/IpEndpointName.h \
               osc/ip/NetworkingUtils.h \
               osc/ip/UdpSocket.h
    INCLUDEPATH += osc/
    INCLUDEPATH += osc/osc
    LIBS+=-lWs2_32 -lwinmm
}


win32{
    DR = "debug"
    CONFIG(release, debug|release): DR = release

    QTVER = Qt_$${QT_MAJOR_VERSION}_$${QT_MINOR_VERSION}_$${QT_PATCH_VERSION}

    # Turn off some warnings
    QMAKE_CXXFLAGS += /wd4100 # Ignore warning C4100 unreferenced formal parameter
    QMAKE_CXXFLAGS_WARN_ON -= -w34100 # Specifically:
    #https://stackoverflow.com/questions/20402722/why-disable-specific-warning-not-working-in-visual-studio

    DEFINES += WIN64
    DEFINES += D_CRT_SECURE_NO_DEPRECATE
    QMAKE_CXXFLAGS += /EHsc /MP

    INCLUDEPATH += $${CHAI3D}/src
    INCLUDEPATH += $${CHAI3D}/external/Eigen
    INCLUDEPATH += $${CHAI3D}/external/glew/include
    INCLUDEPATH += $${CHAI3D}/extras/GLFW/include

    DEPENDPATH += $${CHAI3D}/src
    LIBS += -L$${CHAI3D}/Release/ -lchai3d -lglu32 -lopengl32 -lwinmm
    LIBS += -L$${CHAI3D}/extras/GLFW/Release/ -lglfw
    LIBS += -lglu32 -lOpenGl32 -lglu32 -lOpenGl32 -lwinmm -luser32
    LIBS += kernel32.lib
    LIBS += user32.lib
    LIBS += gdi32.lib
    LIBS += winspool.lib
    LIBS += comdlg32.lib
    LIBS += advapi32.lib
    LIBS += ole32.lib
    LIBS += oleaut32.lib
    LIBS += uuid.lib
    LIBS += odbc32.lib
    LIBS += odbccp32.lib

    # Windows release wanted this...
    LIBS += -lshell32

    # Bullet things
    INCLUDEPATH += $${CHAI3D}/modules/BULLET/src
    DEPENDPATH  += $${CHAI3D}/modules/BULLET/src
    INCLUDEPATH += $${CHAI3D}/modules/BULLET/external/bullet/src
    LIBS += -L$${CHAI3D}/modules/bullet/Release/ -lchai3d-BULLET
}


unix {
    CHAI3D = ../chai3d
    INCLUDEPATH += $${CHAI3D}/src
    INCLUDEPATH += $${CHAI3D}/external/Eigen
    INCLUDEPATH += $${CHAI3D}/external/glew/include
    INCLUDEPATH += $${CHAI3D}/extras/GLFW/include
    DEFINES += LINUX
    QMAKE_CXXFLAGS += -std=c++0x
    LIBS += -L$${CHAI3D}/external/DHD/lib/lin-x86_64/
    LIBS += -L$${CHAI3D}/extras/GLFW
    LIBS += -L$${CHAI3D}/
    LIBS += -lchai3d
    LIBS += -ldrd
    LIBS += -lpthread
    LIBS += -lrt
    LIBS += -ldl
    LIBS += -lGL
    LIBS += -lGLU
    LIBS += -lusb-1.0
    LIBS += -lglfw
    LIBS += -lX11
    LIBS += -lXcursor
    LIBS += -lXrandr
    LIBS += -lXinerama

    INCLUDEPATH += $${CHAI3D}/modules/BULLET/src
    DEPENDPATH  += $${CHAI3D}/modules/BULLET/src
    INCLUDEPATH += $${CHAI3D}/modules/BULLET/external/bullet/src
    LIBS += -L$${CHAI3D}/modules/BULLET -lchai3d-BULLET
}


