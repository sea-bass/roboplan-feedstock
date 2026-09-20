set -ex

# One CMake configure/build/install of superbuild/ for all packages.
# ROBOPLAN_PYTHON_BINDINGS selects the C++-only stage (OFF) or the Python
# bindings stage (ON); the recipe splits the installed tree into outputs.
if [ "${ROBOPLAN_PYTHON_BINDINGS}" = "ON" ]; then
  PYTHON_ARGS="-DPython_EXECUTABLE=${PYTHON} -DPython3_EXECUTABLE=${PYTHON} -DGENERATE_PYTHON_STUBS=ON"
else
  # The superbuild always installs roboplan_common's pure-Python files, which
  # needs a Python install dir even without bindings. Send them to a scratch
  # location that no output claims, so this stage needs no Python at all.
  PYTHON_ARGS="-DROBOPLAN_PYTHON_INSTALL_DIR=share/roboplan_superbuild_unused"
fi

cmake -S "${SRC_DIR}/superbuild" \
  -B build \
  -G Ninja \
  ${CMAKE_ARGS} \
  ${PYTHON_ARGS} \
  -DBUILD_PYTHON_BINDINGS=${ROBOPLAN_PYTHON_BINDINGS} \
  -DBUILD_TESTING=OFF \
  -DROBOPLAN_BUILD_EXAMPLES=OFF \
  -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
cmake --build build
cmake --install build
