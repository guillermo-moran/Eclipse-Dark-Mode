export THEOS=/opt/theos

SDKVERSION = 11.2

GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.1.136

#THEOS_DEVICE_PORT=2222

ARCHS = arm64 arm64e

TWEAK_NAME = Eclipse
Eclipse_LDFLAGS += -lCSColorPicker
# Eclipse_CFLAGS = -fobjc-arc
Eclipse_FILES = Tweak.xmi Utils/UIColor+Eclipse.m Utils/UIImage+Eclipse.m Utils/WKWebView+Eclipse.m Utils/DRMUtils.m Utils/Keychain/SFHFKeychainUtils.m
Eclipse_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore WebKit
Eclipse_PRIVATE_FRAMEWORKS = BackBoardServices WiFiKitUI Preferences PhotoLibrary Security
Eclipse_LIBRARIES = MobileGestalt

include $(THEOS)/makefiles/common.mk

SUBPROJECTS = eclipsesb eclipse_settings eclipse_sharesheets eclipse_aaui #eclipseactivator eclipseflipswitch

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
 
after-install::
	install.exec "killall -9 SpringBoard"
