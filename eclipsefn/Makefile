export THEOS=/opt/theos

GO_EASY_ON_ME = 1
SDKVERSION = 11.2
SYSROOT = /opt/theos/sdks/iPhoneOS11.2.sdk
ARCHS = arm64 arm64e


TWEAK_NAME = EclipseFN
EclipseFN_FILES = Tweak.xm
EclipseFN_FRAMEWORKS = UIKit Foundation CoreFoundation


# TARGET_CXX = xcrun -sdk iphoneos clang++
# TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS)/makefiles/common.mk


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
