include theos/makefiles/common.mk

BUNDLE_NAME = EclipseFlipswitch
EclipseFlipswitch_FILES = Switch.x
EclipseFlipswitch_FRAMEWORKS = UIKit CoreFoundation
EclipseFlipswitch_LIBRARIES = flipswitch
EclipseFlipswitch_INSTALL_PATH = /Library/Switches

export ARCHS = armv7 arm64

TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

include $(THEOS_MAKE_PATH)/bundle.mk