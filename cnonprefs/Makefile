ARCHS = arm64 arm64e
TARGET = iphone:10.3:10.3

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = cnonprefs
cnonprefs_FILES = CNONRootListController.m
cnonprefs_INSTALL_PATH = /Library/PreferenceBundles
cnonprefs_FRAMEWORKS = UIKit
cnonprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/cnonprefs.plist$(ECHO_END)
