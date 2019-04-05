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

SET gamedir=%prgm%\Acclaim\re-volt
EXIT /b

REM | If filechk.bat is giving you trouble about game path not being correct,
REM | then edit the set command so %gamedir% points to where your game is!
