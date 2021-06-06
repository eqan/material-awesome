local user_preferences = {}
local config;

-- Screen	WIDTHxHEIGHT
user_preferences.user_resolution =  '1366x768'

-- Offset 	x,y
user_preferences.user_offset =  '0,0'

-- bool   	true or false
user_preferences.user_audio =  false

-- String 	$HOME
user_preferences.user_save_directory = '$(xdg-user-dir VIDEOS)/Recordings/'

-- String
user_preferences.user_mic_lvl = '20'

-- String
user_preferences.user_fps = '30'

return user_preferences
