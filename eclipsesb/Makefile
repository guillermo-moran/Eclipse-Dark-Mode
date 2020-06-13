export THEOS=/opt/theos

GO_EASY_ON_ME = 1
SDKVERSION = 13.0
ARCHS = arm64 arm64e


TWEAK_NAME = EclipseSB
EclipseSB_FILES = Tweak.xm
EclipseSB_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore
EclipseSB_LIBRARIES = MobileGestalt


# TARGET_CXX = xcrun -sdk iphoneos clang++
# TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS)/makefiles/common.mk


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
