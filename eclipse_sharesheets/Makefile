export THEOS=/opt/theos

SDKVERSION = 11.2

GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.1.126

ARCHS = arm64 arm64e


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = EclipseShareSheets
EclipseShareSheets_FILES = Tweak.xm
EclipseShareSheets_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
