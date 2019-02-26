export THEOS=/opt/theos

GO_EASY_ON_ME = 1
SDKVERSION = 11.2
SYSROOT = /opt/theos/sdks/iPhoneOS11.2.sdk
ARCHS = arm64

BUNDLE_NAME = Eclipse_Settings
Eclipse_Settings_FILES = $(wildcard *.mm) $(wildcard *.m)
Eclipse_Settings_INSTALL_PATH = /Library/PreferenceBundles
Eclipse_Settings_FRAMEWORKS = UIKit
Eclipse_Settings_PRIVATE_FRAMEWORKS = Preferences
# Eclipse_Settings_LIBRARIES = colorpicker #MobileGestalt

include $(THEOS)/makefiles/common.mk

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Eclipse_Settings.plist$(ECHO_END)
