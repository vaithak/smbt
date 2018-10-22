-- Handler that writes text to a file
on writeTextToFile(theText, theFile, overwriteExistingContent)
	try
		-- Convert the file to a string
		set theFile to theFile as string
		-- Open the file for writing
		set theOpenedFile to open for access file theFile with write permission
		-- Clear the file if content should be overwritten
		if overwriteExistingContent is true then set eof of theOpenedFile to 0
		-- Write the new content to the file
		write theText to theOpenedFile starting at eof
		-- Close the file
		close access theOpenedFile
		-- Return a boolean indicating that writing was successful
		return true
		-- Handle a write error
	on error
		-- Close the file
		try
			close access file theFile
		end try
		-- Return a boolean indicating that writing failed
		return false
	end try
end writeTextToFile

-- Handler taht converts a list to string
on convertListToString(theList, theDelimiter)
	set AppleScript's text item delimiters to theDelimiter
	set theString to theList as string
	set AppleScript's text item delimiters to ""
	return theString
end convertListToString

-- Handler that gets the position of an item in the list
on getPositionOfItemInList(theItem, theList)
	repeat with a from 1 to count of theList
		if item a of theList is theItem then return a
	end repeat
	return 0
end getPositionOfItemInList


property safariPath : "Users:vaibhavthakkar:Desktop:SafariTabs:"
property chromePath : "Users:vaibhavthakkar:Desktop:ChromeTabs:"

-- Main running handler
on run argv
	set browser_list to {"Safari", "Google Chrome"}
	set all_url_list to {}
	set paths_list to {safariPath, chromePath}
	
	if length of argv is 0 then
		log "No browser name given"
	else if browser_list does not contain argv then
		log "Wrong Browser Name"
	else
		set browserName to item 1 of argv
		set folderName to item (getPositionOfItemInList(browserName, browser_list)) of paths_list
		
		if browserName is "Safari" then
			tell application "Safari"
				activate
				repeat with thisWind in (get windows)
					local url_list
					set url_list to {}
					
					repeat with t in (tabs of thisWind)
						set TabTitle to (name of t)
						set TabURL to (URL of t)
						set TabInfo to ("" & TabTitle & return & TabURL & return)
						copy TabInfo to the end of url_list
					end repeat
					
					copy url_list to the end of all_url_list
				end repeat
			end tell
		else if browserName is "Google Chrome" then
			tell application "Google Chrome"
				activate
				repeat with thisWind in (get windows)
					local url_list
					set url_list to {}
					
					repeat with t in (tabs of thisWind)
						set TabTitle to (title of t)
						set TabURL to (URL of t)
						set TabInfo to ("" & TabTitle & return & TabURL & return)
						copy TabInfo to the end of url_list
					end repeat
					
					copy url_list to the end of all_url_list
				end repeat
			end tell
			
		end if
		
		repeat with a from 1 to length of all_url_list
			local resultText
			set currList to item a of all_url_list
			set resultText to convertListToString(currList, "

")
			writeTextToFile(resultText, folderName & a & ".txt", true)
		end repeat
	end if
	
end run
