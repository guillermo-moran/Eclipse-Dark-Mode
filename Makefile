export THEOS=/opt/theos

GO_EASY_ON_ME = 1
#THEOS_DEVICE_IP = 192.168.0.2

TWEAK_NAME = Eclipse
Eclipse_FILES = Tweak.xm UIColor+Eclipse.m
Eclipse_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore
Eclipse_PRIVATE_FRAMEWORKS = BackBoardServices
Eclipse_LIBRARIES = colorpicker

include $(THEOS)/makefiles/common.mk

SUBPROJECTS = eclipse_settings eclipseactivator eclipseflipswitch eclipsesb

#export ARCHS = armv7 arm64

TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
