-- Handler that converts a list to string
on splitText(theText, theDelimiter)
	set AppleScript's text item delimiters to theDelimiter
	set theTextItems to every text item of theText
	set AppleScript's text item delimiters to ""
	return theTextItems
end splitText

-- Handler that gets the position of an item in the list
on getPositionOfItemInList(theItem, theList)
	repeat with a from 1 to count of theList
		if item a of theList is theItem then return a
	end repeat
	return 0
end getPositionOfItemInList

-- Main running handler
on run argv
	set LF to character id 10
	try
		set currFile to POSIX file (item 2 of argv)
		tell application "Finder" to set {fType, nExt} to ({file type, name extension} of (currFile as alias))
		if (fType is "TEXT") or (nExt is "txt") then
			set fileData to read currFile
			set sites_list to splitText(fileData, LF & LF)
			set currBrowser to item 1 of argv
			
			if currBrowser is "Google Chrome" then
				
				repeat with a from 1 to length of sites_list
					set curr_site to splitText(item a of sites_list, LF)
					set currUrl to item 2 of curr_site
					
					tell application "Google Chrome"
						if a is 1 then
							set thisWind to make new window
						end if
						set newTab to make new tab at end of tabs of thisWind with properties {URL:currUrl}
					end tell
					
				end repeat
				tell application "Google Chrome" to tell tab 1 of thisWind to close
				
			else if currBrowser is "Safari" then
				
				repeat with a from 1 to length of sites_list
					set curr_site to splitText(item a of sites_list, LF)
					set currUrl to item 2 of curr_site
					
					tell application "Safari"
						if a is 1 then
							make new document at end of documents with properties {URL:currUrl}
						else
							tell front window
								make new tab at end of tabs with properties {URL:currUrl}
							end tell
						end if
					end tell
					
				end repeat
				
			end if
			
			
		else
			log "Please enter a valid path for a textfile"
		end if
	on error
		log "Usage: osascript ombt.applescript [browser_name] [path_of_text_file_containing_links]"
	end try
end run