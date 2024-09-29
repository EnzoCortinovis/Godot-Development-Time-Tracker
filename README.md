# Godot-Development-Time-Tracker

## Overview
The Godot Development Time Tracker is a plugin designed to help developers track the amount of time they spend working on their projects within the Godot Engine.

## Features
- Automatic tracking of development time
- Detailed time logs

## Installation
1. Download the plugin from the [Godot Asset Library](https://godotengine.org/asset-library) or **here**.
2. Extract the downloaded zip file.
3. Copy the `addons` folder to your Godot project directory.
4. Enable the plugin in your project settings:
   - Go to `Project` -> `Project Settings` -> `Plugins`.
   - Find `Godot Development Time Tracker` in the list and set the status to `Active`.
5. Once the plugin is activated, it will start tracking your development time automatically.

## What will the logs look like?

The logs will be in the following format:
```
#############################################################
# Overall time spent on the <YourProjectName> project :
# Total hours: 15 heure(s) et 0 minute(s)
#############################################################

Session of 6 hour(s) and 9 minute(s).  on 01/01/1970
Session of 2 hour(s) and 2 minute(s).  on 02/12/2000
Session of 0 hour(s) and 54 minute(s).  on 29/9/2024
```

## How to get the logs

The plugin will automatically generate a log file in the `user://` directory of your project. You can access this file by going to `Project` -> `Open User Data Directory` and then navigating to the `logs` folder.

Depending on your OS the path should look something like this:
- **Windows:** `C:\Users\YourUserName\AppData\Roaming\Godot\app_userdata\YourProjectName\dev_time_log.txt`
- **Linux:** `~/.local/share/godot/app_userdata/<YourProjectName>/dev_time_log.txt`
- **macOS:** `~/Library/Application Support/Godot/app_userdata/<YourProjectName>/dev_time_log.txt`

## How to change the path of the log file:

If you want to change the path of the log file, you can do so by modifying the `file_path` property in the `time_tracker.gd` script in the addon folder. 

The default path is `user://dev_time_log.txt`.

## Contributing
If you would like to contribute to the development of this plugin, please follow these steps:
1. Fork the repository on GitHub.
2. Create a new branch for your feature or bugfix.
3. Commit your changes and push them to your fork.
4. Create a pull request with a detailed description of your changes.

## License
This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Credits
Developed by [Enzo Cortinovis](https://github.com/EnzoCortinovis).

## Support
If you encounter any issues or have any questions, please open an issue on the [GitHub repository](https://github.com/EnzoCortinovis/Godot-Development-Time-Tracker/issues).




