vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dbarkar/libsmacker
    REF 2e2b136ba45647135f06474d1cb920ab03a0e7a3
    SHA512 a34d8b237fc0903822f60e5601ad69e522401873ffe7cc4380e398b91a362ff4fe2e8afbad76df84a7366122f14ed0c5f45d24bb18e7d802f0c0d4f3db85e6e0
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        tools LIBSMACKER_BUILD_TOOLS
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        ${FEATURE_OPTIONS}
    OPTIONS_DEBUG
        -DLIBSMACKER_BUILD_TOOLS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME libsmacker)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

if("tools" IN_LIST FEATURES)
    vcpkg_copy_tools(TOOL_NAMES driver smk2avi AUTO_CLEAN)
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
