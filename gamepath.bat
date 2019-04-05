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

REM | 32-bit Program files check; Only important for people who installed retail copy to default path.
IF EXIST "%programfiles(x86)%" SET prgm="%programfiles(x86)%"
IF NOT EXIST "%programfiles(x86)%" SET prgm="%programfiles%"

SET gamedir=%prgm%\Acclaim\re-volt
EXIT /b

REM | If filechk.bat is giving you trouble about game path not being correct,
REM | then edit the set command above so %gamedir% points to where your game is!