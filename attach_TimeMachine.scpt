try
	-- (0) check server's response  
	set max_retry to 2
	set k to 0
	repeat while (do shell script "ping -c 1 192.168.0.66") contains "100% packet loss"
		delay 5
		set k to k + 1
		if k > max_retry then error "Server is not responding for predefined period." number 8000
	end repeat
	
	tell application "Finder"
		set mounted_Disks to list disks
		--display dialog result as string
		--set mounted_Disks to every disk whose (ejectable is true)
		if mounted_Disks does not contain "upriv" then
			mount volume "afp://192.168.0.66/upriv" as user name "username here" with password "password here"
		end if
	end tell
	
	-- call python shell to attach TimeMachine.sparsebundle
	do shell script "/usr/local/bin/python3 /Users/k/Dropbox/py/misc/MAC/attach.py"
on error errs number errn
	display dialog errs & " " & errn with icon 2
	--error errs number errn  
end try

--reference
--https://discussions.apple.com/thread/3479873?start=0&tstart=0