-- CalFin Script
-- Creates a Calendar log in given Calendar - using Calendar.app's quick edit syntax:
-- eg: eventDescription at 3am till 3h25am today #Pomodoros
-- eg: sat perfectly still for 30 minutes #Habit

-- v2.0
-- by Jaysen Naidoo
-- 201406
-- Licensed Under the GPL v2.0

set defCal to "Pomodoros"
set inputStr to " {query} " as string

set inputArr to explode("#", inputStr) --Split string by #s

set eventStr to item 1 of inputArr
if (length of inputArr) > 1 then
	set calName to trimBoth(item 2 of inputArr)
else
	set calName to defCal
end if


try
	tell application "Calendar" to activate
	tell application "Calendar"
		-- tell (first calendar whose name is calName) to activate
		tell (first calendar whose name is calName)
			show last event
			switch view to day view
			
			tell application "System Events"
				keystroke "n" using {command down}
				keystroke eventStr
				keystroke return
			end tell
		end tell
	end tell
	return "Event: " & eventStr & " - created in Calendar:" & calName
on error eMsg
	error "ERROR: " & eMsg
	return "ERROR: " & eMsg
end try


-- String Utility Functions:

on explode(delimiter, input)
	local delimiter, input, ASTID
	set ASTID to AppleScript's text item delimiters
	try
		set AppleScript's text item delimiters to delimiter
		set input to text items of input
		set AppleScript's text item delimiters to ASTID
		return input --> list
	on error eMsg number eNum
		set AppleScript's text item delimiters to ASTID
		error "Can't explode: " & eMsg number eNum
	end try
end explode

on trimEnd(str)
	local str, whiteSpace
	try
		set str to str as string
		set whiteSpace to {character id 10, return, space, tab}
		try
			repeat while str's last character is in whiteSpace
				set str to str's text 1 thru -2
			end repeat
			return str
		on error number -1728
			return ""
		end try
	on error eMsg number eNum
		error "Can't trimEnd: " & eMsg number eNum
	end try
end trimEnd

on trimStart(str)
	local str, whiteSpace
	try
		set str to str as string
		set whiteSpace to {character id 10, return, space, tab}
		try
			repeat while str's first character is in whiteSpace
				set str to str's text 2 thru -1
			end repeat
			return str
		on error number -1728
			return ""
		end try
	on error eMsg number eNum
		error "Can't trimStart: " & eMsg number eNum
	end try
end trimStart

on trimBoth(str)
	local str
	try
		return my trimStart(my trimEnd(str))
	on error eMsg number eNum
		error "Can't trimBoth: " & eMsg number eNum
	end try
end trimBoth
