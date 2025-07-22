cmake_minimum_required(VERSION 3.15)
project(YourProject CXX ObjectiveC)

# Указываем версию iOS SDK
set(CMAKE_OSX_SYSROOT iphoneos)
set(CMAKE_OSX_DEPLOYMENT_TARGET "13.0") # Установите желаемую минимальную версию iOS

# Указываем архитектуры для сборки (arm64 - стандартная для современных iOS устройств)
set(CMAKE_OSX_ARCHITECTURES "arm64")

# Добавляем пути для заголовочных файлов Dobby
include_directories(DobbyIphone/iphoneos)

# Определяем путь к .dylib файлу Dobby
# Для простоты, будем использовать universal/GNUSparseFile.0/libdobby.dylib
# Если тебе нужна специфичная архитектура, измени путь.
set(DOBBY_DYLIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/DobbyIphone/iphoneos/universal/GNUSparseFile.0/libdobby.dylib)

# Создаем общую библиотеку (.dylib)
add_library(YourProject SHARED
    src/main.mm
)

# Указываем линковку с Dobby
target_link_libraries(YourProject PUBLIC ${DOBBY_DYLIB_PATH})

# Устанавливаем свойства для выходного файла (например, имя)
set_target_properties(YourProject PROPERTIES
    OUTPUT_NAME "YourProjectDylib"
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.yourcompany.YourProjectDylib"
    INSTALL_RPATH "@executable_path/../Frameworks"
)