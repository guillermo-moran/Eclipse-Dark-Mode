GO_EASY_ON_ME = 1
include theos/makefiles/common.mk

TWEAK_NAME = EclipseSB
EclipseSB_FILES = Tweak.xm
EclipseSB_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore
EclipseSB_LIBRARIES = MobileGestalt


TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
