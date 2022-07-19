cmake_minimum_required(VERSION 3.15)

project(test_swig LANGUAGES CXX)

find_package(Python3 COMPONENTS Interpreter Development REQUIRED)
find_package(SWIG 4.0 COMPONENTS python)
include(${SWIG_USE_FILE})


set_property(SOURCE multi.i PROPERTY CPLUSPLUS ON)
set_property(SOURCE multi.i PROPERTY COMPILE_OPTIONS -cppext cc -builtin -O)
swig_add_library(multi
                 TYPE SHARED
                 LANGUAGE python
                 #NO_PROXY
                 #[OUTPUT_DIR <directory>]
                 #[OUTFILE_DIR <directory>]
                 SOURCES multi.i
                )
target_link_libraries(multi PRIVATE Python3::Module)
target_include_directories(multi PRIVATE ${CMAKE_CURRENT_LIST_DIR})

configure_file(test_multi.py ${CMAKE_CURRENT_BINARY_DIR}/test_multi.py COPYONLY)

include(CTest)
enable_testing()
add_test(
	NAME test_leak COMMAND ${Python3_EXECUTABLE} test_multi.py
)
