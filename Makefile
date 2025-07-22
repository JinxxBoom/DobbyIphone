export THEOS_DEVICE_IP = 127.0.0.1 # Необязательно для сборки, но может быть полезно для отладки
TARGET = iphone:latest
ARCHS = arm64 # Используем arm64, так как у вас есть libdobby.a для этой архитектуры
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DobbyIphoneTweak # Имя вашего твика. Можно изменить.

$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation Security
# Добавьте другие фреймворки, если они нужны вашему main.mm (например, CoreGraphics, if you're drawing)

$(TWEAK_NAME)_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

# Указываем путь к вашей libdobby.a
$(TWEAK_NAME)_OBJ_FILES = dobby/universal/libdobby.a

# Указываем ваш исходный файл main.mm
$(TWEAK_NAME)_FILES = main.mm

# Обязательная библиотека для Theos-твиков, если вы используете хуки
$(TWEAK_NAME)_LIBRARIES += substrate

include $(THEOS_MAKE_PATH)/tweak.mk

# --- Секция для Control файла (метаданные пакета .deb) ---
# Theos автоматически сгенерирует файл control на основе этих переменных
# при создании пакета .deb (make package)
# Если вы хотите только dylib, это не строго обязательно для сборки, но полезно для будущего
# Theos будет использовать эти переменные для создания пакета
PACKAGE_VERSION = 1.0
THEOS_PACKAGE_NAME = DobbyIphoneTweak
THEOS_PACKAGE_BUNDLEID = com.yourcompany.dobbyiphonedevel
THEOS_PACKAGE_DEPENDS = mobilesubstrate
THEOS_PACKAGE_AUTHOR = Your Name
THEOS_PACKAGE_DESCRIPTION = A simple Dobby hook example
THEOS_PACKAGE_MAINTAINER = Your Name