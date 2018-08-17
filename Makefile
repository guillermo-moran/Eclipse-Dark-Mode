export THEOS=/opt/theos

SDKVERSION = 10.1

GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.1.84
#THEOS_DEVICE_IP = 10.5.45.232
#THEOS_DEVICE_IP = 192.168.1.84

#THEOS_DEVICE_PORT=2222

TWEAK_NAME = Eclipse
Eclipse_LDFLAGS += -lCSColorPicker
#Eclipse_CFLAGS = -fobjc-arc
Eclipse_FILES = Tweak.xmi Utils/UIColor+Eclipse.m Utils/UIImage+Eclipse.m Utils/WKWebView+Eclipse.m
Eclipse_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore WebKit
Eclipse_PRIVATE_FRAMEWORKS = BackBoardServices
# Eclipse_LIBRARIES = colorpicker

include $(THEOS)/makefiles/common.mk

SUBPROJECTS = eclipse_settings eclipsesb #eclipseactivator eclipseflipswitch

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
