-- CalFin Script
-- Creates a Calendar log in given Calendar for given minutes ago till now

-- User hits Alfred keystroke - then enters the description, 
---- then a hash (#) and the Duration, 
---- then a hash (#) and the Calendar name, 
---- and an event is created starting <Duration> minutes ago and ending now, in given <Calendar>

-- Input of form: eventDescription #timeAgo #CalendarName
-- eg: sat perfectly still #20 #Habit

-- v2.1
-- by Jaysen Naidoo
-- 201406
-- Licensed Under the GPL v2.0


set defCal to "Pomodoros"
set defTime to 25

--to TEST Outside Alfred: 
--set inputStr to "test#100#Habit " as string

set inputStr to trimBoth(" {query} ")
set inputArr to explode("#", inputStr)

set eventStr to item 1 of inputArr

-- check for given time length:
if (length of inputArr) > 1 then
	set timeAgo to trimBoth(item 2 of inputArr) as integer
else
	set timeAgo to defTime
end if
-- check for calendarName:
if (length of inputArr) > 2 then
	set calName to trimBoth(item 3 of inputArr) as string
else
	set calName to defCal
end if


set nowTime to current date
set startValue to (current date) - timeAgo * minutes


set qstr to "" & eventStr & " : " & timeAgo & " mins"
set descr to "LAST " & timeAgo & "mins - " & eventStr & " in Cal:" & calName
try
	tell application "Calendar" to activate
	tell application "Calendar"
		tell (first calendar whose name is calName)
			make new event at end of events with properties {summary:qstr, start date:startValue, end date:nowTime}
		end tell
	end tell
	return "" & calName & ":" & timeAgo & "m: " & eventStr
on error eMsg
	return "ERR: " & eMsg
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