@ECHO OFF
REM | Program files check; Only important for people who installed retail copy to default path.
IF EXIST "%programfiles(x86)%" SET prgm="%programfiles(x86)%"
IF NOT EXIST "%programfiles(x86)%" SET prgm="%programfiles%"
REM | Exit behaviour; Change this to include /b if you want cmd to remain open. Useful for development.
SET exitCmd=EXIT
REM | !!! Hey end-user, if you touch any of this you are now a developer. Congratulations. :tada: :confetti_ball:
REM | ----------------------------------
REM | Script variable settings
REM | These are used for :cc_inst below.
REM | ----------------------------------
REM | !!! If you added any variables here, they should be reflected in :cc_inst!
REM | Parametres / Parameters
SET par_cc=parameters.txt
REM | Car name and body assets.
SET car_cc=Sabre_Storm
SET bdy_cc=body.prm
SET hul_cc=hull.hul
SET tex_cc=car.bmp
REM | Car wheels and axles
SET wfd_cc=wheelf.prm
SET wfp_cc=wheelr.prm
SET afd_cc=axlefl.prm
SET afp_cc=axlefr.prm
SET ard_cc=axlebl.prm
SET arp_cc=axlebr.prm
REM | Car springs and spinner
SET spl_cc=springl.prm
SET spr_cc=springr.prm
SET spn_cc=

ECHO Requesting for administrative privileges...
cd /d "%~dp0" && (if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs") && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit )
ECHO.
ECHO Privileges received!
ECHO.
ECHO This script will install assets for %car_cc% as a Clockwork car.
ECHO This is a file specific for this vehicle, but can be modified for
ECHO use with other vehicles should you view its contents for modification.
ECHO.
ECHO To continue, press any key.
PAUSE > NUL
REM | -------------------------------------------
REM | Don't touch this. It is for link behaviour.
REM | This is handled by separate files.
REM | -------------------------------------------
CD %~dp0\..
COPY NUL > .running
CALL gamepath.bat
SET src_cc=%~dp0
SET des_cc=%gamedir%\cars
IF EXIST %des_ln%\%car_cc% GOTO ln_bhv
IF NOT EXIST %des_ln%\%car_cc% (
SET rvz_url=http://revoltzone.net/sitescripts/dload.php?id=2950
CALL filechk.bat
)
:ln_bhv
CD %~dp0
IF EXIST ..\.lncmd.bat GOTO cc_inst
IF NOT EXIST ..\.lncmd.bat CALL ..\lnchoice.bat

:cc_inst
CLS
ECHO Writing assets...
ECHO -----------------
IF EXIST %des_cc%\wincar4Old (
  REM | For repeat operations; seek existing new directory and delete if old backup directory exists.
  RMDIR %des_cc%\wincar4 /Q /S
)
IF EXIST %des_cc%\wincar4 (
  REM | For first-time operation; Seek original directory and rename it.
  REN %des_cc%\wincar4 wincar4Old
)
MKDIR %des_cc%\wincar4
REM | !!! Developer, begin writing your operations here.
REM |     Don't forget to set variables above admin request.
CALL ..\.lncmd.bat
%mln% %des_cc%\wincar4\%par_cc% %src_cc%\%par_cc%
%mln% %des_cc%\wincar4\%tex_cc% %src_cc%\%tex_cc%
MKLINK /H %des_cc%\wincar4\%bdy_cc% %des_cc%\%car_cc%\%bdy_cc%
MKLINK /H %des_cc%\wincar4\%hul_cc% %des_cc%\%car_cc%\%hul_cc%
MKLINK /H %des_cc%\wincar4\%wfd_cc% %des_cc%\%car_cc%\%wfd_cc%
MKLINK /H %des_cc%\wincar4\%wfp_cc% %des_cc%\%car_cc%\%wfp_cc%
MKLINK /H %des_cc%\wincar4\%afd_cc% %des_cc%\%car_cc%\%afd_cc%
MKLINK /H %des_cc%\wincar4\%afp_cc% %des_cc%\%car_cc%\%afp_cc%
MKLINK /H %des_cc%\wincar4\%ard_cc% %des_cc%\%car_cc%\%ard_cc%
MKLINK /H %des_cc%\wincar4\%arp_cc% %des_cc%\%car_cc%\%arp_cc%
MKLINK /H %des_cc%\wincar4\%spl_cc% %des_cc%\%car_cc%\%spl_cc%
MKLINK /H %des_cc%\wincar4\%spr_cc% %des_cc%\%car_cc%\%spr_cc%

REM | End developer parametres.
ECHO.
ECHO Finished! Run Re-Volt and play Clockwork Carnage mode to see your changes!
ECHO Press any key to exit this script.
PAUSE > NUL
DEL ..\.running
%exitCmd%