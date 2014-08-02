Alfred-Calendar with Just-Finished Calendar Logging
===================================================

Alfred scripts (Using AppleScript) to quickly create a Calendar Event. Includes keyword and script to log as a Calendar Event, something that has just finished (of given duration) to any named calendar


Installation
------------
Download the alfredworkflow file, double click to add as an Alfred workflow


CalFin Script
--------------
Creates a Calendar log in given Calendar for given minutes ago till now
Uses '#' character to specify Duration and Calendar Name (in that order)

* input-format: **eventDescription** **#duration** **#CalendarName**
* example: Worked on Secret Project #25 #Pomodoros 
* above will create an event in calendar "Pomodoros" starting 25 minutes ago until now, with the description = "Worked on Secret Project")


Cal Script
----------
Creates a Calendar log in given Calendar - using Calendar.app's quick edit syntax

* eg: eventDescription at 3am till 3h25am today #Pomodoros
* eg: sat perfectly still for 30 minutes #Habit


