cmake_minimum_required(VERSION 3.10)
project(Duohaptics)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Find operating system
if(WIN32)
    set(CHAI3D_DIR "c:/chai3d")
elseif(UNIX)
    set(CHAI3D_DIR "/home/stork-drives/Documents/haptikenhet/sourcecode/chai3d")
endif()

# Include directories for CHAI3D and Bullet
include_directories(
    ${CHAI3D_DIR}/src
    ${CHAI3D_DIR}/external/Eigen
    ${CHAI3D_DIR}/external/glew/include
    ${CHAI3D_DIR}/extras/GLFW/include
    ${CHAI3D_DIR}/modules/BULLET/src
    ${CHAI3D_DIR}/modules/BULLET/external/bullet/src
)

# Add source files
add_executable(duohaptics main.cpp)

# Link libraries based on the platform
if(WIN32)
    target_compile_definitions(duohaptics PRIVATE WIN64 D_CRT_SECURE_NO_DEPRECATE)
    target_compile_options(duohaptics PRIVATE /EHsc /MP /wd4100)

    # Update the path to the chai3d library
    target_link_libraries(duohaptics
        ${CHAI3D_DIR}/Release/chai3d.lib  # Corrected path to chai3d.lib
        Ws2_32.lib
        winmm.lib
        shell32.lib
        opengl32.lib  # Link OpenGL
        glu32.lib     # Link GLU for gluErrorString
        ${CHAI3D_DIR}/extras/GLFW/Release/glfw.lib  # Link GLFW from the correct location
    )

    # Bullet libraries for physics, assuming they exist in CHAI3D directory
    target_include_directories(duohaptics PRIVATE ${CHAI3D_DIR}/modules/BULLET/src)
    target_link_libraries(duohaptics ${CHAI3D_DIR}/modules/bullet/Release/chai3d-BULLET.lib)

elseif(UNIX)
    target_compile_definitions(duohaptics PRIVATE LINUX)
    target_compile_options(duohaptics PRIVATE -std=c++0x)

    target_link_libraries(duohaptics
        ${CHAI3D_DIR}/libchai3d.a
        ${CHAI3D_DIR}/external/DHD/lib/lin-x86_64/libdrd.a
        pthread
        rt
        dl
        GL
        GLU
        usb-1.0
        ${CHAI3D_DIR}/extras/GLFW/libglfw.a
        X11
        Xcursor
        Xrandr
        Xinerama
    )

    # Bullet libraries for physics
    target_include_directories(duohaptics PRIVATE ${CHAI3D_DIR}/modules/BULLET/src)
    target_link_libraries(duohaptics ${CHAI3D_DIR}/modules/BULLET/libchai3d-BULLET.a)
endif()
