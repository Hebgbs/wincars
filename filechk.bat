@ECHO OFF
IF NOT EXIST .running (
  ECHO Hey! This script shouldn't be ran by itself.
  ECHO.
  ECHO Try executing any of the scripts inside the
  ECHO directories of this repository instead!
  ECHO.
  ECHO Press any key to exit.
  PAUSE > NUL
  EXIT
)

IF EXIST %gamedir%\revolt.exe GOTO chk_car
IF NOT EXIST %gamedir%\revolt.exe GOTO chk_rvgl
:chk_rvgl
IF EXIST %gamedir%\rvgl.exe GOTO chk_car
IF NOT EXIST %gamedir%\rvgl.exe GOTO no_game
CLS
:no_game
ECHO.
ECHO It seems like the directory set in gamepath.bat isn't set correctly.
ECHO Fix this, then run the script for %car_cc% again.
ECHO.
ECHO Press any key to edit gamepath.bat.
PAUSE > NUL
ECHO.
ECHO Script will exit after notepad.exe closes.
notepad.exe gamepath.bat
EXIT
:chk_car
IF NOT EXIST %des_cc%\%car_cc%\%par_cc% (
  ECHO.
  ECHO Oh dear, it seems like you don't have %car_cc%.
  ECHO If you would like to download it, press any key to continue.
  ECHO.
  ECHO Your browser will open to %rvz_url% after pressing any key.
  ECHO Otherwise terminate this script by pressing C while holding [Ctrl].
  PAUSE > NUL
  CLS
  ECHO Extract the \cars archive to your game's cars directory and press
  ECHO any key to validate you have %car_cc% and proceed with further operations.
  START http://revoltzone.net/sitescripts/dload.php?id=%rvl_id%
  PAUSE > NUL
  ECHO.
  ECHO Once finished, press any key to re-check if you have this vehicle installed.
  PAUSE > NUL
  GOTO chk_car
)
IF EXIST "%des_cc%\%car_cc%\%par_cc% EXIT /b
