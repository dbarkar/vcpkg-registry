vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO WohlSoft/SDL-Mixer-X
    REF bd501efb74e6fad1cb384510ce08a9fb087de740
    SHA512 227f0036f356dc6a73e72ae7153e23fe2dd22c847de2196ce66164bc70c0933614d4ec147c6340f19d59e0bccd515f8eaa1515c5e70e5b66d7e315ecc7b259f2
    HEAD_REF master
    PATCHES
        cmake-package-export.patch
        fix-pkgconfig.patch
        fix-static-target-libraries.patch
)

string(COMPARE EQUAL ${VCPKG_LIBRARY_LINKAGE} "dynamic" SDL_MIXER_X_SHARED)
string(COMPARE EQUAL ${VCPKG_LIBRARY_LINKAGE} "static" SDL_MIXER_X_STATIC)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        libadlmidi  USE_MIDI_ADLMIDI
        libadlmidi  USE_MIDI
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        ${FEATURE_OPTIONS}
        -DSDL_MIXER_X_SHARED=${SDL_MIXER_X_SHARED}
        -DSDL_MIXER_X_STATIC=${SDL_MIXER_X_STATIC}
        -DMIXERX_ENABLE_GPL=ON
        -DMIXERX_ENABLE_LGPL=ON
        -DUSE_SYSTEM_SDL2=ON
        -DUSE_DRFLAC=OFF
        -DUSE_GME=OFF
        -DUSE_MIDI_EDMIDI=OFF
        -DUSE_MIDI_FLUIDLITE=OFF
        -DUSE_MIDI_OPNMIDI=OFF
        -DUSE_MIDI_TIMIDITY=OFF
        -DUSE_MODPLUG=OFF
        -DUSE_MP3_DRMP3=OFF
        -DUSE_OPUS=OFF
        -DUSE_WAV=OFF
        -DUSE_XMP=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_mixer_ext CONFIG_PATH lib/cmake/SDL2_mixer_ext)

vcpkg_fixup_pkgconfig()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

set(LICENSE_FILES
    "${SOURCE_PATH}/COPYING.txt"
    "${SOURCE_PATH}/GPLv2.txt"
    "${SOURCE_PATH}/GPLv3.txt"
    "${SOURCE_PATH}/SDL2_mixer_ext.License.txt"
)
vcpkg_install_copyright(FILE_LIST ${LICENSE_FILES})
