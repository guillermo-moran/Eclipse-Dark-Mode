export THEOS=/opt/theos

SDKVERSION = 13.0

GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.25.77

#THEOS_DEVICE_PORT=2222

ARCHS = arm64e

TWEAK_NAME = Eclipse
Eclipse_LDFLAGS += -lCSColorPicker
# Eclipse_CFLAGS = -fobjc-arc
Eclipse_FILES = Tweak.xmi Utils/UIColor+Eclipse.m Utils/UIImage+Eclipse.m Utils/WKWebView+Eclipse.m Utils/DRMUtils.m Utils/Keychain/SFHFKeychainUtils.m
Eclipse_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore WebKit
Eclipse_PRIVATE_FRAMEWORKS = BackBoardServices WiFiKitUI Preferences Security AppSupport UIKitServices
Eclipse_LIBRARIES = MobileGestalt

include $(THEOS)/makefiles/common.mk

SUBPROJECTS = eclipse_settings

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
 
after-install::
	install.exec "killall -9 SpringBoard"
