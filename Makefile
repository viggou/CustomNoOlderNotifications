ARCHS = arm64 arm64e
TARGET = iphone:clang:11.2:11.2

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomNoOlderNotifications

CustomNoOlderNotifications_FILES = Tweak.xm
CustomNoOlderNotifications_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += cnonprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
