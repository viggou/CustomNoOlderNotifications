ARCHS = arm64
TARGET = iphone:clang:11.2:11.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomNoOlderNotifications
CustomNoOlderNotifications_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += cnonprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
