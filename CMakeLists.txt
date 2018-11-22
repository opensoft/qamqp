cmake_minimum_required(VERSION 3.12.0)
project(QAMQP VERSION 0.5.0 LANGUAGES CXX)

find_package(Qt5Core CONFIG REQUIRED)
find_package(Qt5Network CONFIG REQUIRED)

execute_process(COMMAND git describe --long --dirty --tags
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    OUTPUT_VARIABLE QAMQP_GIT_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(SOURCE_FILES
    src/qamqpauthenticator.cpp
    src/qamqpchannel.cpp
    src/qamqpchannelhash.cpp
    src/qamqpclient.cpp
    src/qamqpexchange.cpp
    src/qamqpframe.cpp
    src/qamqpmessage.cpp
    src/qamqpqueue.cpp
    src/qamqptable.cpp
)

set(PUBLIC_HEADERS
    src/qamqpauthenticator.h
    src/qamqpchannel.h
    src/qamqpclient.h
    src/qamqpexchange.h
    src/qamqpglobal.h
    src/qamqpmessage.h
    src/qamqpqueue.h
    src/qamqptable.h
)

set(PRIVATE_HEADERS
    src/qamqpchannel_p.h
    src/qamqpchannelhash_p.h
    src/qamqpclient_p.h
    src/qamqpexchange_p.h
    src/qamqpframe_p.h
    src/qamqpmessage_p.h
    src/qamqpqueue_p.h
)

add_library(qamqp SHARED ${SOURCE_FILES} ${PUBLIC_HEADERS} ${PRIVATE_HEADERS})

target_compile_definitions(qamqp
    PUBLIC QAMQP_SHARED
    PRIVATE QAMQP_BUILD GIT_VERSION=\"${QAMQP_GIT_VERSION}\"
)
if(MSVC)
    # QList<QAmqpMessage>:warning C4661: no suitable definition provided for explicit template instantiation request
    target_compile_options(qamqp PRIVATE -wd4661)
endif()

set_target_properties(qamqp PROPERTIES
    CXX_STANDARD 14
    CXX_STANDARD_REQUIRED ON
    AUTOMOC ON
)

target_include_directories(qamqp
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(qamqp
    PUBLIC
    Qt5::Core
    Qt5::Network
)

install(TARGETS qamqp
    EXPORT qamqp-targets
    RUNTIME DESTINATION lib
    LIBRARY DESTINATION lib
)

install(EXPORT qamqp-targets DESTINATION lib/cmake/3rdparty
    FILE qamqp-config.cmake
)

install(FILES ${PUBLIC_HEADERS}
    DESTINATION include/3rdparty/qamqp/src
)

export (TARGETS qamqp FILE qamqp-config.cmake)
