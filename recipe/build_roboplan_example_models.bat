@echo off

cmake -S "%SRC_DIR%\cpp" ^
      -B build\roboplan_example_models ^
      -G Ninja ^
      %CMAKE_ARGS%

if errorlevel 1 exit /b 1

cmake --build build\roboplan_example_models
if errorlevel 1 exit /b 1

cmake --install build\roboplan_example_models
if errorlevel 1 exit /b 1
