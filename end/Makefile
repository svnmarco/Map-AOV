export THEOS=/home/phamduc612010/theos


ARCHS = arm64 

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ESP




ESP_FRAMEWORKS =  UIKit Foundation Security QuartzCore CoreGraphics CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController
ESP_LDFLAGS += API/libAPIClient.a
ESP_LDFLAGS += JRMemory.framework/JRMemory
ESP_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
ESP_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

ESP_FILES = ImGuiDrawView.mm  FPSDisplay.m $(wildcard Esp/*.mm) $(wildcard Esp/*.m) $(wildcard KittyMemory/*.cpp) $(wildcard KittyMemory/*.mm) $(wildcard KittyMemory/*.m) 



#LQMNemOS_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk

echo $THEOS

