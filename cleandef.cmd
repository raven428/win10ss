@echo off
rd "default\Cookies"
rd "default\Local Settings"
rd "default\My Documents"
rd "default\NetHood"
rd "default\PrintHood"
rd "default\Recent"
rd "default\Templates"
rd "default\SendTo"
rd "default\Start Menu"
rd "default\Application Data"
rd "default\AppData\Local\history"
rd "default\AppData\Local\Temporary Internet Files"
rd "default\AppData\Local\Application Data"

rd /s /q "default\AppData\Local\Temp"
rd /s /q "default\AppData\Local\Microsoft\Windows\WebCache"
rd /s /q "default\AppData\Local\Microsoft\Windows\Temporary Internet Files"
rd /s /q "default\AppData\Local\Microsoft\Windows\Explorer"
rd /s /q "default\AppData\Local\Microsoft\Windows\1033"
rd /s /q "default\AppData\Local\Microsoft\Windows\Caches"
rd /s /q "default\AppData\Local\Microsoft\Windows\Themes"
rd /s /q "default\AppData\Local\Microsoft\Windows\Burn"
rd /s /q "default\AppData\Local\Microsoft\Windows\History"
rd /s /q "default\AppData\Local\Microsoft\Windows\AppCache"
rd /s /q "default\AppData\Local\Microsoft\Windows\GameExplorer"
rd /s /q "default\AppData\Local\Microsoft\Windows\Ringtones"
rd /s /q "default\AppData\Local\Microsoft\Windows\WER"
mkdir "default\AppData\Local\Microsoft\Windows\GameExplorer"
mkdir "default\AppData\Local\Microsoft\Windows\History"
mkdir "default\AppData\Local\Microsoft\Windows\Temporary Internet Files"

rd /s /q "default\AppData\Local\Microsoft\Assistance"
rd /s /q "default\AppData\Local\Microsoft\Windows Media"
rd /s /q "default\AppData\Local\Microsoft\Windows Mail"
rd /s /q "default\AppData\Local\Microsoft\PlayReady"
rd /s /q "default\AppData\Local\Microsoft\Media Player"
rd /s /q "default\AppData\Local\Microsoft\Internet Explorer"
rd /s /q "default\AppData\Local\Microsoft\Feeds Cache"
rd /s /q "default\AppData\Local\Microsoft\Feeds"
rd /s /q "default\AppData\Local\Microsoft\Device Metadata"
rd /s /q "default\AppData\Local\Microsoft\Credentials"
rd /s /q "default\AppData\Local\VirtualStore"

rem rd /s /q "default\AppData\LocalLow"
rd /s /q "default\AppData\LocalLow\Sun\Java\Deployment\cache"
rem должно быть: default\AppData\LocalLow\Sun\Java\Deployment\deployment.properties
rd /s /q "default\AppData\Roaming\Adobe"
rd /s /q "default\AppData\Roaming\Identities"
rd /s /q "default\AppData\Roaming\WinRAR"
rd /s /q "default\AppData\Roaming\Microsoft\Credentials"
rd /s /q "default\AppData\Roaming\Microsoft\MMC"
rd /s /q "default\AppData\Roaming\Microsoft\Network"
rd /s /q "default\AppData\Roaming\Microsoft\Protect"
rd /s /q "default\AppData\Roaming\Microsoft\Speech"
rd /s /q "default\AppData\Roaming\Microsoft\SystemCertificates"
rd /s /q "default\AppData\Roaming\Microsoft\Internet Explorer\UserData"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\Cookies"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\DNTException"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\IECompatCache"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\IECompatUACache"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\IEDownloadHistory"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\PrivacIE"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\Recent"
rd /s /q "default\AppData\Roaming\Microsoft\Windows\Themes"
attrib -h "default\AppData\Local\*"
del /f /q "default\AppData\Local\*"
del /f /q default\EurekaLog\toad.elf

mkdir "default\AppData\Roaming\Microsoft\Windows\Recent"
mkdir "default\AppData\Roaming\Microsoft\Windows\Cookies"
attrib +s "default\AppData\Local\Microsoft\Windows\History"
attrib +s "default\AppData\Local\Microsoft\Windows\Temporary Internet Files"

rd /s /q "default\AppData\Roaming\Mozilla\Firefox\Profiles\cvecyvyt.default\gmp-eme-adobe"
rd /s /q "default\AppData\Roaming\Mozilla\Firefox\Profiles\cvecyvyt.default\storage"
rd /s /q "default\AppData\Roaming\Mozilla\Firefox\Profiles\cvecyvyt.default\gmp-gmpopenh264"
rd /s /q "default\AppData\Roaming\Mozilla\Firefox\Crash Reports"
rd /s /q "default\AppData\Local\Mozilla\updates"
rd /s /q "default\AppData\Local\Mozilla\Firefox\Profiles\cvecyvyt.default\Cache.Trash15237"
rd /s /q "default\AppData\Local\Mozilla\Firefox\Profiles\cvecyvyt.default\cache2"
rd /s /q "default\AppData\Local\Mozilla\Firefox\Profiles\cvecyvyt.default\safebrowsing"
rd /s /q "default\AppData\Local\Mozilla\Firefox\Profiles\cvecyvyt.default\startupCache"
rd /s /q "default\AppData\Local\VMware"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\GPUCache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Cache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Extensions"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\GPUCache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Storage"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Web Applications"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Local Storage"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Application Cache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Session Storage"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\JumpListIcons"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\JumpListIconsOld"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\GPUCache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Cache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Extensions"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\GPUCache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Storage"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Web Applications"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Local Storage"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Application Cache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Session Storage"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\JumpListIcons"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\JumpListIconsOld"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Local Extension Settings"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\PepperFlash"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Media Cache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Service Worker"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\pnacl"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\Default\Code Cache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\ShaderCache"
rd /s /q "default\AppData\Local\Google\Chrome\User Data\BrowserMetrics"
rd /s /q "default\AppData\Roaming\Microsoft\Document Building Blocks"

del /f /q "default\AppData\Roaming\Mozilla\Firefox\Profiles\cvecyvyt.default\places.sqlite "
del /f /q "default\AppData\Roaming\Mozilla\Firefox\Profiles\cvecyvyt.default\healthreport.sqlite"
del /f /q "default\AppData\Roaming\Mozilla\Firefox\Profiles\cvecyvyt.default\cookies.sqlite"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing Bloom"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing Download"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing UwS List"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing Bloom Prefix Set"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing UwS List Prefix Set"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Safe Browsing Csd Whitelist"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\ChromeDWriteFontCache"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Google Profile.ico"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\Visited Links"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Profile 1\History"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Default\ChromeDWriteFontCache"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Default\Google Profile.ico"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Default\Visited Links"
del /f /q "default\AppData\Local\Google\Chrome\User Data\Default\History"
del /f /q "default\AppData\Roaming\XnViewMP\Thumb.db"
rd /s /q "default\AppData\Local\Far Manager\Profile"
del /f /q "default\AppData\Local\Google\Chrome\User Data\ru-RU-3-0.bdic"
attrib /d /s -h -s "default\IntelGraphicsProfiles"
attrib /d /s -h -s "default\IntelGraphicsProfiles\*"
rd /s /q  "default\IntelGraphicsProfiles"
rd /s /q "default\AppData\Local\Symantec"
rd /s /q "default\AppData\Local\Microsoft\Windows\INetCache"
rd /s /q "default\AppData\Local\Packages"
attrib /d /s -h -s "default\AppData\Local\Comms\UnistoreDB"
del /f /q "default\AppData\Local\Comms\UnistoreDB\*"
pause