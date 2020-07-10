# HideGoXLRWindow
 
This little solution hides the GoXLR App window on startup since there is no way to do that from the software itself.

## How To Install
Just pull down the `HideGoXLR.ps1`, `HideGoXLR_startup.cmd` and `install.bat` files and run the install. You can inspect anything in there, no funny stuff is going on.

The only thing that will happen is it will trigger a little PowerShell script (thanks to [@avodovnik](https://github.com/avodovnik)) that tries to find any GoXLR windows and closes them on startup. 👏
With the install file it moves the files in the right folders to line it up for startup, only for the current user.

The script will try 3 times, with 10 second intervals. If you find that the timing is off, fiddle a little with the param values in the ps1 file. Unfortunately, because of those timing issues it's best to let it actually run those 3*10 minutes, so you will look at a cmd window for a while, but that should disappear on its own. If you know how to fix that, I'm looking forward to a PR!

### Logging
In case anything seems off, you can find a log at `%TEMP%\StartupLog.txt` which holds the output of the startup command
