include theos/makefiles/common.mk

TWEAK_NAME = EclipseActivator
EclipseActivator_FRAMEWORKS = UIKit
EclipseActivator_FILES = Tweak.xm
EclipseActivator_LDFLAGS = -lactivator

export ARCHS = armv7 arm64

TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
