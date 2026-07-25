cmake_minimum_required(VERSION 3.25)
project(test_thing LANGUAGES OBJC)

add_executable(test_thing MACOSX_BUNDLE main.m)
target_link_libraries(test_thing PRIVATE "-framework AppKit")
target_compile_options(test_thing PRIVATE -fobjc-arc)

set_target_properties(
    test_thing
    PROPERTIES
        MACOSX_BUNDLE_BUNDLE_NAME "Test thing"
        MACOSX_BUNDLE_GUI_IDENTIFIER "io.renjin.test"
)
