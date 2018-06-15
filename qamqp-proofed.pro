TEMPLATE = lib
TARGET = qamqp
QT += core network
QT -= gui
DESTDIR = $$(PROOF_PATH)/lib
CONFIG += c++14
win32:CONFIG *= skip_target_version_ext

msvc:QMAKE_CXXFLAGS += /wd4127

DEFINES += QAMQP_BUILD QAMQP_SHARED

VERSION = 0.5.0
GIT_VERSION = $$system(git describe --long --dirty --tags)
DEFINES += GIT_VERSION=\\\"$$GIT_VERSION\\\"

HEADERS += \
    src/qamqpauthenticator.h \
    src/qamqpchannel_p.h \
    src/qamqpchannel.h \
    src/qamqpchannelhash_p.h \
    src/qamqpclient_p.h \
    src/qamqpclient.h \
    src/qamqpexchange_p.h \
    src/qamqpexchange.h \
    src/qamqpframe_p.h \
    src/qamqpglobal.h \
    src/qamqpmessage_p.h \
    src/qamqpmessage.h \
    src/qamqpqueue_p.h \
    src/qamqpqueue.h \
    src/qamqptable.h

SOURCES += \
    src/qamqpauthenticator.cpp \
    src/qamqpchannel.cpp \
    src/qamqpchannelhash.cpp \
    src/qamqpclient.cpp \
    src/qamqpexchange.cpp \
    src/qamqpframe.cpp \
    src/qamqpmessage.cpp \
    src/qamqpqueue.cpp \
    src/qamqptable.cpp

