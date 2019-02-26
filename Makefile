GO_EASY_ON_ME = 1
#THEOS_DEVICE_IP = 192.168.0.34
THEOS_DEVICE_IP = 192.168.0.26
include theos/makefiles/common.mk

TWEAK_NAME = Eclipse
Eclipse_FILES = Tweak.xm
Eclipse_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore
Eclipse_LIBRARIES = MobileGestalt
SUBPROJECTS = eclipse_settings eclipseactivator eclipseflipswitch

export ARCHS = armv7 arm64

TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
