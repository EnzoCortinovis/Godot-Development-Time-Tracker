@tool
extends EditorPlugin

var session_start_time
const file_path:String = "user://dev_time_log.txt" # Path to the log file. Feel free to change it to your liking.
# to find your log file, go to the Godot editor, click on the "Editor" menu, then "Open Editor Data Directory" then click app_userdata, then click on the folder with the name of your project, then click on dev_time_log.txt
# Or see generic path depending on your OS:
# Windows: C:\Users\YourUserName\AppData\Roaming\Godot\app_userdata\YourProjectName\dev_time_log.txt
# Linux: ~/.local/share/godot/app_userdata/<YourProjectName>/dev_time_log.txt
# macOS: ~/Library/Application Support/Godot/app_userdata/<YourProjectName>/dev_time_log.txt

func _enter_tree():
	# Get the current time in milliseconds at the start of the session.
	session_start_time = Time.get_ticks_msec()

func _exit_tree():
	# Get the current time in milliseconds at the end of the session.
	var session_end_time = Time.get_ticks_msec()
	var session_duration_seconds: int = (session_end_time - session_start_time) / 1000
	
	# Convert seconds to hours and minutes.
	var hours = int(session_duration_seconds / 3600)
	var minutes = int((session_duration_seconds % 3600) / 60)

	# Log the session duration and update total hours.
	await log_session_duration(hours, minutes)
	update_total_hours(hours, minutes)

func log_session_duration(hours: int, minutes: int):
	var timeDict = Time.get_datetime_dict_from_system()
	var readOnlyFile = FileAccess.open(file_path, FileAccess.READ)
	if readOnlyFile == null:
		await createBaseFile()
	if readOnlyFile!= null: readOnlyFile.close()
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	# Move to the end of the file to avoid overwriting existing data.
	file.seek_end()
	# Store the session duration in a formatted string.
	file.store_line("Session of " + str(hours) + " hour(s) and " + str(minutes) + " minute(s).  on " + str(timeDict["day"]) + "/" + str(timeDict["month"]) + "/" + str(timeDict["year"]))
	file.close()

func update_total_hours(new_hours: int, new_minutes: int):
	var total_minutes = 0
	# Open the file for reading.
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	var lines = []
	var lineNb = 0
	
	# Read all the lines in the file.
	while not file.eof_reached():
		var line = file.get_line()
		if line.strip_edges() != "" or lineNb<5:  # Add only non-empty lines after header.
			lines.append(line)
		lineNb+=1
	file.close()

	for i in range(len(lines)):
		if lines[i].begins_with("# Total hours:"):
			# Extract the current total hours and minutes from the line.
			var existing_time = lines[i].split(":")[1].strip_edges().split(" ")
			var existing_hours = int(existing_time[0])  # Extract hours
			var existing_minutes = int(existing_time[3])  # Extract minutes
			
			# Convert everything to total minutes.
			total_minutes = (existing_hours * 60) + existing_minutes + (new_hours * 60) + new_minutes
			# Update the line with the new total time in hours and minutes.
			lines[i] = "# Total hours: " + str(total_minutes / 60) + " hour(s) and " + str(total_minutes % 60) + " minute(s)"
			break

	# Write the updated lines back to the file.
	file = FileAccess.open(file_path, FileAccess.WRITE)
	for line in lines:
		file.store_line(line)
	file.close()

func createBaseFile():
	var gameName = ProjectSettings.get_setting("application/config/name")
	var baseFile = FileAccess.open(file_path, FileAccess.WRITE)
	baseFile.store_line("#############################################################")
	baseFile.store_line("# Overall time spent on the "+gameName+" project :")
	baseFile.store_line("# Total hours: 0 hour(s) and 0 minute(s)")
	baseFile.store_line("#############################################################")
	baseFile.store_line("")
	baseFile.close()