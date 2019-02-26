export THEOS=/opt/theos

SDKVERSION = 9.3

GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.1.74
#THEOS_DEVICE_IP = 10.5.47.125


TWEAK_NAME = Eclipse
Eclipse_LDFLAGS += -Wl,-segalign,4000
Eclipse_FILES = Tweak.xm UIColor+Eclipse.m UIImage+Eclipse.m
Eclipse_FRAMEWORKS = UIKit CoreGraphics CoreFoundation CoreText QuartzCore
Eclipse_PRIVATE_FRAMEWORKS = BackBoardServices
Eclipse_LIBRARIES = colorpicker

include $(THEOS)/makefiles/common.mk

SUBPROJECTS = eclipse_settings eclipseactivator eclipseflipswitch eclipsesb

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
