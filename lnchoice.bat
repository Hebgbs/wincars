@ECHO OFF
IF NOT EXIST ../.running (
  ECHO Hey! This script shouldn't be ran by itself.
  ECHO.
  ECHO Try executing any of the scripts inside the
  ECHO directories of this repository instead!
  ECHO.
  ECHO Press any key to exit.
  PAUSE > NUL
  EXIT
)

CLS
ECHO Before you continue, since these scripts rely on mklink
ECHO this menu is so you can define link behaviour.
ECHO.
ECHO 1. Create symbolic links
ECHO    If your game and clockwork files are on separate partitions, choose this.
ECHO 2. Create hard links
ECHO    If your game is on the same partition as system, choose this.
ECHO.
CHOICE /N /C:12 /M "Selection: "
IF ERRORLEVEL 1 SET LNB=1
IF ERRORLEVEL 2 SET LNB=2
IF %LNB%==1 (
ECHO REM This file does nothing on its own. Run the batch file instead! > ..\.lncmd.bat
ECHO SET mln=MKLINK >> ..\.lncmd.bat
ECHO EXIT /b >> ..\.lncmd.bat
)
IF %LNB%==2 (
ECHO REM This file does nothing on its own. Run the batch file instead! > ..\.lncmd.bat
ECHO SET mln=MKLINK /h >> ..\.lncmd.bat
ECHO EXIT /b >> ..\.lncmd.bat
)
EXIT /b
