include theos/makefiles/common.mk

BUNDLE_NAME = Eclipse_Settings
Eclipse_Settings_FILES = $(wildcard *.mm) $(wildcard *.m)
Eclipse_Settings_INSTALL_PATH = /Library/PreferenceBundles
Eclipse_Settings_FRAMEWORKS = UIKit
Eclipse_Settings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Eclipse_Settings.plist$(ECHO_END)
