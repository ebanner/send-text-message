on run {input, parameters}
	tell application "Messages"
		set iMessageService to 1st account whose service type = iMessage
		set iMessageBuddy to participant "edward.banner@gmail.com" of iMessageService
		send "Hello!" to iMessageBuddy
	end tell
end run
