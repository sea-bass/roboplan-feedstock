rem One CMake configure/build/install of superbuild\ for all packages.
rem ROBOPLAN_PYTHON_BINDINGS selects the C++-only stage (OFF) or the Python
rem bindings stage (ON); the recipe splits the installed tree into outputs.
rem Stub generation cannot import the freshly built extensions on Windows
rem (dependent DLLs are not on the loader search path in the build tree), so
rem the committed .pyi stubs from the source tree are installed instead.
if "%ROBOPLAN_PYTHON_BINDINGS%"=="ON" (
  set "PYTHON_ARGS=-DPython_EXECUTABLE=%PYTHON% -DPython3_EXECUTABLE=%PYTHON% -DGENERATE_PYTHON_STUBS=OFF"
) else (
  rem roboplan_common's pure-Python files always get installed; park them in a
  rem scratch location no output claims so this stage needs no Python.
  set "PYTHON_ARGS=-DROBOPLAN_PYTHON_INSTALL_DIR=share/roboplan_superbuild_unused"
)

cmake -S "%SRC_DIR%\superbuild" ^
  -B build ^
  -G Ninja ^
  %CMAKE_ARGS% ^
  %PYTHON_ARGS% ^
  -DBUILD_PYTHON_BINDINGS=%ROBOPLAN_PYTHON_BINDINGS% ^
  -DBUILD_TESTING=OFF ^
  -DROBOPLAN_BUILD_EXAMPLES=OFF
if errorlevel 1 exit 1
cmake --build build
if errorlevel 1 exit 1
cmake --install build
if errorlevel 1 exit 1
