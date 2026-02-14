#! /bin/sh

cmake -S "${SRC_DIR}/roboplan_example_models" \
    -B build/roboplan_example_models \
    -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

cmake --build build/roboplan_example_models
cmake --install build/roboplan_example_models
