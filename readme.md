# Huh? What the hell is this?
This is a directory full of vehicles successfully turned into clockwork cars.
Edit gamepath.bat to reflect your Re-Volt / RVGL location and have fun.
It will search for either Re-Volt or RVGL, by executable name before proceeding.

To apply changes, open the car you want (if you have it already) and run the batch files therein.
If you don't have the car, you will be prompted to download via Re-Volt Zone.
To undo changes, manually edit your game to restore the original wincar4; it's in `\cars`.

### License information
Creative Commons CC0.

# How does this really work?
_Do note, this will only work on Windows Vista or greater, with NTFS partitions. If your installation of Windows is what's considered as "Typical" for the average end-user, then you should be good to use these scripts._

Each configuration batch file will execute other files at repository trunk;
* `gamepath.bat` defines where the game is. If these scripts are unable to function fix them by setting correct path for game binary. (Do not subvert error checking.)
* `filechk.bat` will 1) check if `revolt.exe` exists, if not, 2) check for `rvgl.exe` and if it finds the game, 3) check for the car specific to the script executed.
* `lnchoice.bat` is for determining link behaviour, and produces the file `.lncmd.bat`.
* The scripts will seek out `.lncmd.bat` for knowing what to do; either symbolic links or hard links. If `.lncmd.bat` doesn't exist it will call upon `lnchoice.bat`.
   * If you had chosen poorly, just edit `.lncmd.bat` by hand; either `mklink` or `mklink /h`.
* When completed, the script inside the cars directory to be affected (which ends in `_cc.bat`) will link all files therein so target acts as clockwork.

Open the game, select game mode Clockwork Carnage and enjoy thirty of any vehicle you've chosen.

### Wait, _Clockwork Carnage?_
If you've never completed Stunt Arena by collecting all thirty stars around the map, then you'll never had earned this reward. To unlock it without doing this tedious effort, one of two things can be done;
* Press key combination :arrow_up::arrow_right::arrow_down::arrow_left::arrow_up::arrow_left::arrow_down::arrow_right: at main menu
* Launch the game from desktop shortcut or in command line with `-dev`.

# So how do I actually use this?
Open the car directory you want to apply changes for and execute its batch file. _Simple._ Windows will take care of the rest; The requisite batch files will execute, the things will be done, and you can run your game with confidence knowing your changes were applied.

# `For developers`
### Contribution
You want to cocntribute with your own fun vehicle to use in Clockwork Carnage? Great! Just follow the steps below:

1. Fork the repository. This is a given to create pushes with your changes in Git.
2. Create a new directory which will contain all the files necessary for completion. **Name this the same as the car directory in the game's `cars` directory.**
   * _i.e._ if the directory for use in-game is `trashcan`, name your project directory `trashcan`.
3. Put into it the following files:
   * Any texture files for rendering car graphics
   * A copy of any batch file for another vehicle (i.e. `trashcan_cc.bat`)
   * `parameters.txt`
4. Open `parameters.txt` and replace the car directory with `\wincar4\`
   * _i.e._ replacing `\trashcan\` with `\wincar4\`
5. Rename your batch file; This can be anything, but preferably something which reflects the project vehicle.
6. Follow advice for editing the batch file
7. Follow advice for making it good.

### Editing the batch file
Whatever batch you use as a base doesn't really matter because it's the same stuff, with some slight changes.

#### Head
At the head of the batch file are variables necessary for code underneath to be functional. WHile it may seem like this makes editing harder, it actually makes editing _easier_ because a lot of things below it are used more than once, which makes it tedious and time-consuming otherwise to scrub through and make sure everything is correct.

An example head from `trashcan_cc.bat`:
```
SET par_cc=parameters.txt
REM | Car name and body assets.
SET car_cc=trashcan
SET bdy_cc=body.prm
SET hul_cc=hull.hul
SET tex_cc=trashcan.bmp
REM | Car wheels
SET wfd_cc=
SET wfp_cc=
SET wrd_cc=wheel_l.prm
SET wrp_cc=wheel_r.prm
REM | Car spinner
SET spn_cc=
REM | Re-Volt Zone item number
SET rvz_id=8185
```
While there are a lot of non-defined variables, this is fine: They go unused. Do note if there isn't an equal sign (`=`) to represent a _blank_ variable, the batch script will produce errors about undefined variables.

The one important thing to make sure of is that `rvz_id` matches what vehicle is referred to in `car_cc` or else when a user is prompted to download this missing vehicle they will get the wrong car, or worse, no car at all. If you goof this, it will be fixed for you but try to save me some work please. As an example, to get the ID for trashcan _simply copy the ID from the address bar._ Address for example vehicle:
http://revoltzone.net/cars/8185/Trashcan

See **8185** there? That is the vehicle's ID in Re-Volt Zone and is what's used for `rvz_id`.

#### Body
Everything between the head and the foot of the batch file is splash text and background stuff for the end-user. The _only_ thing which matters is the splash text. Make it good, and optionally, let people know where original assets not under your copyright come from.

Everything in this repository is CC0. **No negotiation.**

#### Foot
Where the rubber meet the road. Using the variables from the head of the document, apply them here. Example from `trashcan_cc.bat`:
```
CALL ..\.lncmd.bat
%mln% %des_cc%\wincar4\%par_cc% %src_cc%\%par_cc%
%mln% %des_cc%\wincar4\%tex_cc% %src_cc%\%tex_cc%
MKLINK /H %des_cc%\wincar4\%bdy_cc% %des_cc%\%car_cc%\%bdy_cc%
MKLINK /H %des_cc%\wincar4\%hul_cc% %des_cc%\%car_cc%\%hul_cc%
MKLINK /H %des_cc%\wincar4\%wrd_cc% %des_cc%\%car_cc%\%wrd_cc%
MKLINK /H %des_cc%\wincar4\%wrp_cc% %des_cc%\%car_cc%\%wrp_cc%
```
Don't be fussed if `.lncmd.bat` doesn't exist at the base of the repository. This is fine; `lnchoice.bat` will prompt the user for link behaviour.

Everything else after that _does_ matter. If you hadn't noticed there is a variable called `mln` which will use the behaviour as defined in `.lncmd.bat`. Without this file being called, these variables remain undefined and will not be applied (which means your script is broken). The lines with `mln` are pulling from your project folder. Everything else are hard links, since they reside on the same physical partition as the game and will pull from the game's `cars` directory.

As for `src_cc` and `des_cc`, those variables are defined in the batch body, which will always be as shown:
```
SET src_cc=%~dp0
SET des_cc=%gamedir%\cars
```
There is no reason to tinker with this, if conforming to the conventional file structure present for other vehicles.

### Making it good
To make your project not suck when used as a clockwork car, you ought to do the following;

#### Blender
**Get Blender.** After getting Blender, visit https://re-volt.github.io/re-volt-addon/html/index.html and get the Blender addon, installing in in your Blender scripts.

Once opened, do the following:

1. Press A twice, then Delete. (Confirm deleting everything in default scene).
2. At the top pane in Info, select File > Import > Re-Volt
3. Open the `.prm` file which represents the car's body in the game's `cars` directory
4. In the right pane of the default Blender layout, change Properties to UV/Image editor
5. At the bottom toolbar in UV/Image editor, open the image list and select the car's texture
   * You may want to select Image > Open image instead if the dummy file loaded with no other option instead.
5. In 3D View, Right-click on the imported `.prm` file and change on the bottom toolbar for 3D View from Object Mode to Edit Mode
6. Press A to select all vertex points (and thus, highlight all faces).
7. In UV/Image Editor, press A to select all UV points.
8. At the bottom toolbar of UV/Image Editor select UVs > Export UV Layout
   * Note that UVs doesn''t show up if 3D View is set to Object Mode.
9. Save as whatever you like. Begin file name with a period to not submit it in a pull request later.

#### GNU Image Manipulation Program
**Get GIMP.** After getting GIMP there is nothing else special you have to do except open it.

Do as follows for best results:

1. Open the car texture from your project directory.
2. Open again, _except_ this time drag your UV map from Blender into the layers tab.
3. Use the Fuzzy Select tool to select all _outside_ the UV map.
   * Touch up if you have to; By default for select tools `[Ctrl]` is remove from selection, while `[Shift]` is add to selection.
4. At the top toolbar or from context menu, go to Select > Invert
   * Optionally, after inverting selection go to Select > Grow and expand by 1px.
   * Touch up afterward if you have to,
5. Use any variety of means to de-saturate the selection.
   * In 2.10, you can go to Colour > Components > Mono Mixer for a solid means of manipulating de-saturation per colour channel.
6. _Export as_ a `.bmp` file, named after the original in the game's `cars` directory.
   * Optionally, export a "q" bitmap for renaming as a `.bmq` file after.
      * You will need to make Windows Explorer not hide known file extensions before attempting this. Google it.

# BTW
Have fun, and don't be afraid to dick around. It's how I got this stuff to happen, and you can too! The primary difference is I got all the hard stuff done.
