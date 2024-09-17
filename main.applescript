on run {input, parameters}
	-- Path to the CSV file (you can customize this)
	set csvFilePath to POSIX file "phone_numbers.csv"
	
	-- Read the CSV file
	set phoneNumbersAndMessages to readCSV(csvFilePath)
	
	-- Send iMessage to each phone number with corresponding message
	repeat with phoneData in phoneNumbersAndMessages
		set phoneNumber to item 1 of phoneData
		set textMessage to item 2 of phoneData
		sendMessage(phoneNumber, textMessage)
	end repeat
end run

-- Function to read the CSV file and return a list of phone numbers
on readCSV(filePath)
	set phoneNumberList to {}
	
	-- Open the CSV file and read its content
	set fileRef to open for access filePath
	set fileContents to read fileRef as «class utf8»
	close access fileRef
	-- Split the file contents by line breaks
	set csvLines to paragraphs of fileContents
	
	-- Set the text item delimiters to comma (for splitting CSV)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ","
	
	-- Extract phone numbers from each line (assuming phone numbers are in the first column)
	repeat with myline in csvLines
		if myline is not "" then
			set phoneData to text items of myline
			copy phoneData to the end of phoneNumberList
		end if
	end repeat
	
	return phoneNumberList
end readCSV

-- Function to send an iMessage
on sendMessage(phoneNumber, messageText)
	tell application "Messages"
		set iMessageService to 1st account whose service type = iMessage
		set iMessageBuddy to participant phoneNumber of iMessageService
		send messageText to iMessageBuddy
	end tell
end sendMessage
