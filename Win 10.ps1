<#
.SYNOPSIS
	The PowerShell script is a set of tweaks for fine-tuning Windows 10 and automating the routine tasks.
.DESCRIPTION
	Supported Windows versions:
	Windows 10 18362/18363 (1903/1909) x64. Tested on Pro/Enterprise editions.

	Check whether file is encoded in UTF-8 with BOM.
	PowerShell must be run with elevated privileges;
	Set PowerShell execution policy: Set-ExecutionPolicy -ExecutionPolicy Bypass -Force to be able to run .ps1 files.

	Read the code you run carefully.
	Some functions are presented as an example only.
	You must be aware of the meaning of the functions in the code.
	If you're not sure what the script does, do not run it.
	Strongly recommended to run the script after fresh installation.
	Some of functions can be run also on LTSB/LTSC and on older versions of Windows and PowerShell (not recommended to run on the x86 systems).
.EXAMPLE
	PS C:\WINDOWS\system32> & '.\Win 10.ps1'
.NOTES
	Version: v4.0.25
	Date: 13.03.2020
	Written by: farag
	Thanks to all http://forum.ru-board.com members involved
	Ask a question on
	- http://forum.ru-board.com/topic.cgi?forum=62&topic=30617#15
	- https://habr.com/en/post/465365/
	- https://forums.mydigitallife.net/threads/powershell-script-setup-windows-10.80139/
	- https://www.reddit.com/r/Windows10/comments/ctg8jw/powershell_script_setup_windows_10/
	Copyright (c) 2020 farag
.LINK
	https://github.com/farag2/Windows-10-Setup-Script
#>

#Requires -RunAsAdministrator
#Requires -Version 5

#region Preparation
Clear-Host

# Get information about the current culture settings
# Получить сведения о параметрах текущей культуры
if ($PSUICulture -eq "ru-RU")
{
	$RU = $true
}
# Detect the OS bitness
# Определить разрядность ОС
if (-not ([Environment]::Is64BitOperatingSystem))
{
	if ($RU)
	{
		Write-Warning -Message "Скрипт поддерживает только Windows 10 x64"
	}
	else
	{
		Write-Warning -Message "The script supports Windows 10 x64 only"
	}
	break
}
# Detect the PowerShell bitness
# Определить разрядность PowerShell
if (-not ([IntPtr]::Size -eq 8))
{
	if ($RU)
	{
		Write-Warning -Message "Скрипт поддерживает только PowerShell x64"
	}
	else
	{
		Write-Warning -Message "The script supports PowerShell x64 only"
	}
	break
}
#endregion Preparation

#region Begin
# Сlear $Error variable
# Очистка переменной $Error
$Error.Clear()
# Checking the file encoding if it runs locally
# Проверка кодировки файла, если он запускается локально
if ($PSCommandPath)
{
	[System.IO.FileInfo]$script = Get-Item -Path $PSCommandPath
	$SequenceBOM = New-Object System.Byte[] 3
	$reader = $script.OpenRead()
	$bytesRead = $reader.Read($SequenceBOM, 0, 3)
	$reader.Dispose()
	if ($bytesRead -eq 3 -and $SequenceBOM[0] -ne 239 -and $SequenceBOM[1] -ne 187 -and $SequenceBOM[2] -ne 191)
	{
		if ($RU)
		{
			Write-Warning -Message "Файл не был сохранен в кодировке `"UTF-8 с BOM`""
		}
		else
		{
			Write-Warning -Message "The file wasn't saved in `"UTF-8 with BOM`" encoding"
		}
		break
	}
}
# Set the encoding to UTF-8 without BOM for the PowerShell session
# Установить кодировку UTF-8 без BOM для текущей сессии PowerShell
if ($RU)
{
	ping.exe | Out-Null
	$OutputEncoding = [System.Console]::OutputEncoding = [System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
}
#endregion Begin

#region Privacy & Telemetry
# Turn off "Connected User Experiences and Telemetry" service
# Отключить службу "Функциональные возможности для подключенных пользователей и телеметрия"
Get-Service -Name DiagTrack | Stop-Service -Force
Get-Service -Name DiagTrack | Set-Service -StartupType Disabled
# Turn off per-user services
# Отключить пользовательские службы
$services = @(
	# Contact Data
	# Служба контактных данных
	"PimIndexMaintenanceSvc_*"
	# User Data Storage
	# Служба хранения данных пользователя
	"UnistoreSvc_*"
	# User Data Access
	# Служба доступа к данным пользователя
	"UserDataSvc_*"
)
Get-Service -Name $services | Stop-Service -Force
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\PimIndexMaintenanceSvc -Name Start -PropertyType DWord -Value 4 -Force
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\PimIndexMaintenanceSvc -Name UserServiceFlags -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\UnistoreSvc -Name Start -PropertyType DWord -Value 4 -Force
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\UnistoreSvc -Name UserServiceFlags -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\UserDataSvc -Name Start -PropertyType DWord -Value 4 -Force
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\UserDataSvc -Name UserServiceFlags -PropertyType DWord -Value 0 -Force
# Stop event trace sessions
# Остановить сеансы отслеживания событий
Get-EtwTraceSession -Name DiagLog -ErrorAction Ignore | Remove-EtwTraceSession
# Turn off the data collectors at the next computer restart
# Отключить сборщики данных при следующем запуске ПК
Update-AutologgerConfig -Name DiagLog, AutoLogger-Diagtrack-Listener -Start 0
# Set the operating system diagnostic data level
# Установить уровень отправляемых диагностических сведений
if ((Get-WindowsEdition -Online).Edition -eq "Enterprise" -or (Get-WindowsEdition -Online).Edition -eq "Education")
{
	# "Security"
	# "Безопасность"
	New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection -Name AllowTelemetry -PropertyType DWord -Value 0 -Force
}
else
{
	# "Basic"
	# "Базовый"
	New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection -Name AllowTelemetry -PropertyType DWord -Value 1 -Force
}
# Turn off Windows Error Reporting
# Отключить отчеты об ошибках Windows
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name Disabled -PropertyType DWord -Value 1 -Force
# Change Windows Feedback frequency to "Never"
# Изменить частоту формирования отзывов на "Никогда"
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Siuf\Rules))
{
	New-Item -Path HKCU:\Software\Microsoft\Siuf\Rules -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Siuf\Rules -Name NumberOfSIUFInPeriod -PropertyType DWord -Value 0 -Force
# Turn off diagnostics tracking scheduled tasks
# Отключить задачи диагностического отслеживания
$tasks = @(
	# Collects program telemetry information if opted-in to the Microsoft Customer Experience Improvement Program.
	# Собирает телеметрические данные программы при участии в Программе улучшения качества программного обеспечения Майкрософт
	"Microsoft Compatibility Appraiser"
	# Collects program telemetry information if opted-in to the Microsoft Customer Experience Improvement Program
	# Сбор телеметрических данных программы при участии в программе улучшения качества ПО
	"ProgramDataUpdater"
	# This task collects and uploads autochk SQM data if opted-in to the Microsoft Customer Experience Improvement Program
	# Эта задача собирает и загружает данные SQM при участии в программе улучшения качества программного обеспечения
	"Proxy"
	# If the user has consented to participate in the Windows Customer Experience Improvement Program, this job collects and sends usage data to Microsoft
	# Если пользователь изъявил желание участвовать в программе по улучшению качества программного обеспечения Windows, эта задача будет собирать и отправлять сведения о работе программного обеспечения в Майкрософт
	"Consolidator"
	# The USB CEIP (Customer Experience Improvement Program) task collects Universal Serial Bus related statistics and information about your machine
	# При выполнении задачи программы улучшения качества ПО шины USB (USB CEIP) осуществляется сбор статистических данных об использовании универсальной последовательной шины USB и сведений о компьютере
	"UsbCeip"
	# The Windows Disk Diagnostic reports general disk and system information to Microsoft for users participating in the Customer Experience Program
	# Для пользователей, участвующих в программе контроля качества программного обеспечения, служба диагностики дисков Windows предоставляет общие сведения о дисках и системе в корпорацию Майкрософт
	"Microsoft-Windows-DiskDiagnosticDataCollector"
	# Protects user files from accidental loss by copying them to a backup location when the system is unattended
	# Защищает файлы пользователя от случайной потери за счет их копирования в резервное расположение, когда система находится в автоматическом режиме
	"File History (maintenance mode)"
	# HelloFace
	"FODCleanupTask"
	# Measures a system's performance and capabilities
	# Измеряет быстродействие и возможности системы
	"WinSAT"
	# This task shows various Map related toasts
	# Эта задача показывает различные тосты (всплывающие уведомления) приложения "Карты"
	"MapsToastTask"
	# This task checks for updates to maps which you have downloaded for offline use
	# Эта задача проверяет наличие обновлений для карт, загруженных для автономного использования
	"MapsUpdateTask"
	# Initializes Family Safety monitoring and enforcement
	# Инициализация контроля и применения правил семейной безопасности
	"FamilySafetyMonitor"
	# Synchronizes the latest settings with the Microsoft family features service
	# Синхронизирует последние параметры со службой функций семьи учетных записей Майкрософт
	"FamilySafetyRefreshTask"
	# Windows Error Reporting task to process queued reports
	# Задача отчетов об ошибках обрабатывает очередь отчетов
	"QueueReporting"
	# XblGameSave Standby Task
	"XblGameSaveTask"
)
Get-ScheduledTask -TaskName $tasks | Disable-ScheduledTask
# Do not offer tailored experiences based on the diagnostic data setting
# Не предлагать персонализированные возможности, основанные на выбранном параметре диагностических данных
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy -Name TailoredExperiencesWithDiagnosticDataEnabled -PropertyType DWord -Value 0 -Force
# Do not let apps on other devices open and message apps on this device, and vice versa
# Не разрешать приложениям на других устройствах запускать приложения и отправлять сообщения на этом устройстве и наоборот
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP -Name RomeSdkChannelUserAuthzPolicy -PropertyType DWord -Value 0 -Force
# Do not allow apps to use advertising ID
# Не разрешать приложениям использовать идентификатор рекламы
New-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -PropertyType DWord -Value 0 -Force
# Do not use sign-in info to automatically finish setting up device after an update or restart
# Не использовать данные для входа для автоматического завершения настройки устройства после перезапуска или обновления
$sid = (Get-CimInstance -ClassName Win32_UserAccount | Where-Object -FilterScript {$_.Name -eq "$env:USERNAME"}).SID
if (-not (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$sid"))
{
	New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$sid" -Force
}
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$sid" -Name OptOut -PropertyType DWord -Value 1 -Force
# Do not let websites provide locally relevant content by accessing language list
# Не позволять веб-сайтам предоставлять местную информацию за счет доступа к списку языков
New-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name HttpAcceptLanguageOptOut -PropertyType DWord -Value 1 -Force
# Turn on tip, trick, and suggestions as you use Windows
# Показывать советы, подсказки и рекомендации при использованию Windows
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338389Enabled -PropertyType DWord -Value 1 -Force
# Do not show suggested content in the Settings
# Не показывать рекомендуемое содержание в "Параметрах"
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338393Enabled -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-353694Enabled -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-353696Enabled -PropertyType DWord -Value 0 -Force
# Turn off automatic installing suggested apps
# Отключить автоматическую установку рекомендованных приложений
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SilentInstalledAppsEnabled -PropertyType DWord -Value 0 -Force
#endregion Privacy & Telemetry

#region UI & Personalization
# Show "This PC" on Desktop
# Отобразить "Этот компьютер" на рабочем столе
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -PropertyType DWord -Value 0 -Force
# Set File Explorer to open to This PC by default
# Открывать "Этот компьютер" в Проводнике
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -PropertyType DWord -Value 1 -Force
# Show hidden files, folders, and drives
# Показывать скрытые файлы, папки и диски
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -PropertyType DWord -Value 1 -Force
# Turn off check boxes to select items
# Отключить флажки для выбора элементов
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name AutoCheckSelect -PropertyType DWord -Value 0 -Force
# Show file name extensions
# Показывать расширения для зарегистрированных типов файлов
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -PropertyType DWord -Value 0 -Force
# Show folder merge conflicts
# Не скрывать конфликт слияния папок
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideMergeConflicts -PropertyType DWord -Value 0 -Force
# Do not show all folders in the navigation pane
# Не отображать все папки в области навигации
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -PropertyType DWord -Value 0 -Force
# Do not show Cortana button on taskbar
# Не показывать кнопку Cortana на панели задач
IF (-not $RU)
{
	New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowCortanaButton -PropertyType DWord -Value 0 -Force
}
# Do not show Task View button on taskbar
# Не показывать кнопку Просмотра задач
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -PropertyType DWord -Value 0 -Force
# Do not show People button on the taskbar
# Не показывать панель "Люди" на панели задач
if (-not (Test-Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People))
{
	New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -Name PeopleBand -PropertyType DWord -Value 0 -Force
# Do not show when snapping a window, what can be attached next to it
# Не показывать при прикреплении окна, что можно прикрепить рядом с ним
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name SnapAssist -PropertyType DWord -Value 0 -Force
# Show more details in file transfer dialog
# Развернуть диалог переноса файлов
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager))
{
	New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Name EnthusiastMode -PropertyType DWord -Value 1 -Force
# Show the Ribbon expanded in File Explorer
# Отображать ленту проводника в развернутом виде
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon))
{
	New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon -Name MinimizedStateTabletModeOff -PropertyType DWord -Value 0 -Force
# Do not show "Frequent folders" in Quick access
# Не показывать недавно используемые папки на панели быстрого доступа
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -PropertyType DWord -Value 0 -Force
# Do not show "Recent files" in Quick access
# Не показывать недавно использовавшиеся файлы на панели быстрого доступа
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -PropertyType DWord -Value 0 -Force
# Hide search box or search icon on taskbar
# Скрыть поле или значок поиска на панели задач
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -PropertyType DWord -Value 0 -Force
# Do not show "Windows Ink Workspace" button in taskbar
# Не показывать кнопку Windows Ink Workspace на панели задач
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace -Name PenWorkspaceButtonDesiredVisibility -PropertyType DWord -Value 0 -Force
# Set the "Control Panel" view on "Small icons"
# Установить мелкие значки в Панели управления
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel))
{
	New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -Name AllItemsIconView -PropertyType DWord -Value 1 -Force
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel -Name StartupPage -PropertyType DWord -Value 1 -Force

# Do not show "New App Installed" notification
# Не показывать уведомление "Установлено новое приложение"
if (-not (Test-Path -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer))
{
	New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Force
}
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name NoNewAppAlert -PropertyType DWord -Value 1 -Force
# Do not show user first sign-in animation
# Не показывать анимацию при первом входе в систему
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableFirstLogonAnimation -PropertyType DWord -Value 0 -Force
# Turn off JPEG desktop wallpaper import quality reduction
# Отключить снижение качества фона рабочего стола в формате JPEG
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name JPEGImportQuality -PropertyType DWord -Value 100 -Force
# Show Task manager details
# Раскрыть окно Диспетчера задач
$taskmgr = Get-Process -Name Taskmgr -ErrorAction Ignore
if ($taskmgr)
{
	$taskmgr.CloseMainWindow()
}
Start-Process -FilePath Taskmgr.exe -WindowStyle Hidden -PassThru
do
{
	Start-Sleep -Milliseconds 100
	$preferences = Get-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager -Name Preferences -ErrorAction Ignore
}
until ($preferences)
Stop-Process -Name Taskmgr
$preferences.Preferences[28] = 0
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager -Name Preferences -PropertyType Binary -Value $preferences.Preferences -Force
# Remove Microsoft Edge shortcut from the Desktop
# Удалить ярлык Microsoft Edge с рабочего стола
$value = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name Desktop
Remove-Item -Path "$value\Microsoft Edge.lnk" -Force -ErrorAction Ignore
# Show accent color on the title bars and window borders
# Отображать цвет элементов в заголовках окон и границ окон
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\DWM -Name ColorPrevalence -PropertyType DWord -Value 1 -Force
# Turn off automatically hiding scroll bars
# Отключить автоматическое скрытие полос прокрутки в Windows
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name DynamicScrollbars -PropertyType DWord -Value 0 -Force
# Show more Windows Update restart notifications about restarting
# Показывать уведомление, когда компьютеру требуется перезагрузка для завершения обновления
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name RestartNotificationsAllowed2 -PropertyType DWord -Value 1 -Force
# Turn off the "- Shortcut" name extension for new shortcuts
# Нe дoбaвлять "- яpлык" для coздaвaeмыx яpлыкoв
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name link -PropertyType Binary -Value ([byte[]](00, 00, 00, 00)) -Force
# Use the PrtScn button to open screen snipping
# Использовать кнопку PRINT SCREEN, чтобы запустить функцию создания фрагмента экрана
New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name PrintScreenKeyForSnippingEnabled -PropertyType DWord -Value 1 -Force
# Automatically adjust active hours for me based on daily usage
# Автоматически изменять период активности для этого устройства на основе действий
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name SmartActiveHoursState -PropertyType DWord -Value 1 -Force
#endregion UI & Personalization

#region System
# Turn on Storage Sense
# Включить Память устройства
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 01 -PropertyType DWord -Value 1 -Force
# Run Storage Sense every month
# Запускать контроль памяти каждый месяц
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 2048 -PropertyType DWord -Value 30 -Force
# Delete temporary files that apps aren't using
# Удалять временные файлы, не используемые в приложениях
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 04 -PropertyType DWord -Value 1 -Force
# Delete files in recycle bin if they have been there for over 30 days
# Удалять файлы, которые находятся в корзине более 30 дней
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 256 -PropertyType DWord -Value 30 -Force
# Never delete files in "Downloads" folder
# Никогда не удалять файлы из папки "Загрузки"
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 512 -PropertyType DWord -Value 0 -Force
# Let Windows try to fix apps so they're not blurry
# Разрешить Windows исправлять размытость в приложениях
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name EnablePerProcessSystemDPI -PropertyType DWord -Value 1 -Force
# Turn off hibernate for devices, except laptops
# Включить режим гибернации
powercfg /hibernate on
# Turn off location access for this device
# Отключить доступ к сведениям о расположении для этого устройства
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location -Name Value -PropertyType String -Value Deny -Force
# Change $env:TEMP environment variable path to $env:SystemDrive\Temp
# Изменить путь переменной среды для временных файлов на $env:SystemDrive\Temp
if (-not (Test-Path -Path $env:SystemDrive\Temp))
{
	New-Item -Path $env:SystemDrive\Temp -ItemType Directory -Force
}
[Environment]::SetEnvironmentVariable("TMP", "d:\temp", "User")
New-ItemProperty -Path HKCU:\Environment -Name TMP -PropertyType ExpandString -Value d:\temp -Force
[Environment]::SetEnvironmentVariable("TEMP", "d:\temp", "User")
New-ItemProperty -Path HKCU:\Environment -Name TEMP -PropertyType ExpandString -Value d:\temp -Force
[Environment]::SetEnvironmentVariable("TMP", "d:\users\%USERNAME%\temp", "Machine")
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name TMP -PropertyType ExpandString -Value d:\users\%USERNAME%\temp -Force
[Environment]::SetEnvironmentVariable("TEMP", "d:\users\%USERNAME%\temp", "Machine")
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name TEMP -PropertyType ExpandString -Value d:\users\%USERNAME%\temp -Force
[Environment]::SetEnvironmentVariable("TMP", "d:\users\%USERNAME%\temp", "Process")
[Environment]::SetEnvironmentVariable("TEMP", "d:\users\%USERNAME%\temp", "Process")
Restart-Service -Name Spooler -Force
# Turn on Win32 long paths
# Включить длинные пути Win32
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name LongPathsEnabled -PropertyType DWord -Value 1 -Force
# Group svchost.exe processes
# Группировать процессы svchost.exe
$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control -Name SvcHostSplitThresholdInKB -PropertyType DWord -Value $ram -Force
# Display the Stop error information on the BSoD
# Отображать Stop-ошибку при появлении BSoD
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Control\CrashControl -Name DisplayParameters -PropertyType DWord -Value 1 -Force
# Do not preserve zone information
# Не хранить сведения о зоне происхождения вложенных файлов
if (-not (Test-Path -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments))
{
	New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments -Force
}
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments -Name SaveZoneInformation -PropertyType DWord -Value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments -Name SaveZoneInformation -PropertyType DWord -Value 1 -Force
# Turn on Admin Approval Mode for administrators
# Включить использование режима одобрения администратором для встроенной учетной записи администратора
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -PropertyType DWord -Value 2 -Force
# Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled
# Включить доступ к сетевым дискам при включенном режиме одобрения администратором при доступе из программ, запущенных с повышенными правами
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLinkedConnections -PropertyType DWord -Value 1 -Force
# Turn off Delivery Optimization
# Отключить оптимизацию доставки
Get-Service -Name DoSvc | Stop-Service -Force
Set-DODownloadMode -DownloadMode 0
Delete-DeliveryOptimizationCache -Force
# Do not let Windows manage default printer
# Не разрешать Windows управлять принтером, используемым по умолчанию
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Windows" -Name LegacyDefaultPrinterMode -PropertyType DWord -Value 1 -Force
# Turn off Windows features
# Отключить компоненты
$features = @(
	# Microsoft XPS Document Writer
	# Средство записи XPS-документов (Microsoft)
	"Printing-XPSServices-Features"
	# Work Folders Client
	# Клиент рабочих папок
	"WorkFolders-Client"
)
Disable-WindowsOptionalFeature -Online -FeatureName $features -NoRestart
# Remove Windows capabilities
# Удалить компоненты
$IncludedApps = @(
	# Windows Media Player
	# Проигрыватель Windows Media
	"Media.WindowsMediaPlayer*"
)
$OFS = "|"
Get-WindowsCapability -Online | Where-Object -FilterScript {$_.Name -cmatch $IncludedApps} | Remove-WindowsCapability -Online
$OFS = " "
# Set the default input method to the English language
# Установить метод ввода по умолчанию на английский язык
Set-WinDefaultInputMethodOverride "0409:00000409"
# Turn on Windows Sandbox
# Включить Windows Sandbox
if (Get-WindowsEdition -Online | Where-Object -FilterScript {$_.Edition -eq "Professional" -or $_.Edition -eq "Enterprise"})
{
	if ((Get-CimInstance -ClassName CIM_Processor).VirtualizationFirmwareEnabled -eq $true)
	{
		Enable-WindowsOptionalFeature –FeatureName Containers-DisposableClientVM -All -Online -NoRestart
	}
	else
	{
		try
		{
			if ((Get-CimInstance –ClassName CIM_ComputerSystem).HypervisorPresent -eq $true)
			{
				Enable-WindowsOptionalFeature –FeatureName Containers-DisposableClientVM -All -Online -NoRestart
			}
		}
		catch
		{
			Write-Error "Enable Virtualization in BIOS"
		}
	}
}

# Launch folder in a separate process
# Запускать окна с папками в отдельном процессе
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name SeparateProcess -PropertyType DWord -Value 1 -Force
# Turn off and delete reserved storage after the next update installation
# Отключить и удалить зарезервированное хранилище после следующей установки обновлений
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager -Name PassedPolicy -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager -Name ShippedWithReserves -PropertyType DWord -Value 0 -Force
# Turn on automatic backup the system registry to the $env:SystemRoot\System32\config\RegBack folder
# Включить автоматическое создание копии реестра в папку $env:SystemRoot\System32\config\RegBack
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" -Name EnablePeriodicBackup -PropertyType DWord -Value 1 -Force
# Turn off F1 Help key
# Отключить справку по нажатию F1
if (-not (Test-Path -Path "HKCU:\Software\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64"))
{
	New-Item -Path "HKCU:\Software\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" -Force
}
New-ItemProperty -Path "HKCU:\Software\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" -Name "(default)" -PropertyType String -Value "" -Force
# Turn on Num Lock at startup
# Включить Num Lock при загрузке
New-ItemProperty -Path "Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard" -Name InitialKeyboardIndicators -PropertyType String -Value 2147483650 -Force
# Turn off sticky Shift key after pressing 5 times
# Отключить залипание клавиши Shift после 5 нажатий
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name Flags -PropertyType String -Value 506 -Force
# Turn off AutoPlay for all media and devices
# Отключить автозапуск для всех носителей и устройств
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers -Name DisableAutoplay -PropertyType DWord -Value 1 -Force
# Turn on network discovery and file and printers sharing
# Включить сетевое обнаружение и общий доступ к файлам и принтерам
if ((Get-NetConnectionProfile).NetworkCategory -ne "DomainAuthenticated")
{
	Get-NetFirewallRule -Group "@FirewallAPI.dll,-32752", "@FirewallAPI.dll,-28502" | Set-NetFirewallRule -Profile Private -Enabled True
	Set-NetConnectionProfile -NetworkCategory Private
}
#endregion System

#region End
# Refresh desktop icons, environment variables and taskbar without restarting File Explorer
# Обновить иконки рабочего стола, переменные среды и панель задач без перезапуска "Проводника"
$UpdateEnvExplorerAPI = @{
	Namespace = "WinAPI"
	Name = "UpdateEnvExplorer"
	Language = "CSharp"
	MemberDefinition = @"
		private static readonly IntPtr HWND_BROADCAST = new IntPtr(0xffff);
		private const int WM_SETTINGCHANGE = 0x1a;
		private const int SMTO_ABORTIFHUNG = 0x0002;

		[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = false)]
		static extern bool SendNotifyMessage(IntPtr hWnd, uint Msg, IntPtr wParam, string lParam);
		[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = false)]
		private static extern IntPtr SendMessageTimeout(IntPtr hWnd, int Msg, IntPtr wParam, string lParam, int fuFlags, int uTimeout, IntPtr lpdwResult);
		[DllImport("shell32.dll", CharSet = CharSet.Auto, SetLastError = false)]
		private static extern int SHChangeNotify(int eventId, int flags, IntPtr item1, IntPtr item2);
		public static void Refresh()
		{
			// Update desktop icons
			// Обновить иконки рабочего стола
			SHChangeNotify(0x8000000, 0x1000, IntPtr.Zero, IntPtr.Zero);
			// Update environment variables
			// Обновить переменные среды
			SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, IntPtr.Zero, null, SMTO_ABORTIFHUNG, 100, IntPtr.Zero);
			// Update taskbar
			// Обновить панель задач
			SendNotifyMessage(HWND_BROADCAST, WM_SETTINGCHANGE, IntPtr.Zero, "TraySettings");
		}

		private static readonly IntPtr hWnd = new IntPtr(65535);
		private const int Msg = 273;
		// Virtual key ID of the F5 in Explorer
		// Виртуальный код клавиши F5 в Проводнике
		private static readonly UIntPtr UIntPtr = new UIntPtr(41504);

		[DllImport("user32.dll", SetLastError=true)]
		public static extern int PostMessageW(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam);
		public static void PostMessage()
		{
			// F5 pressing simulation to refresh the desktop
			// Симуляция нажатия F5 для обновления рабочего стола
			PostMessageW(hWnd, Msg, UIntPtr, IntPtr.Zero);
		}
"@
}
if (-not ("WinAPI.UpdateEnvExplorer" -as [type]))
{
	Add-Type @UpdateEnvExplorerAPI
}
[WinAPI.UpdateEnvExplorer]::Refresh()
[WinAPI.UpdateEnvExplorer]::PostMessage()

# Errors output
# Вывод ошибок
if ($Error)
{
	Write-Host "`nWarnings/Errors" -BackgroundColor Red
	($Error | ForEach-Object -Process {
		[PSCustomObject] @{
			Line = $_.InvocationInfo.ScriptLineNumber
			Error = $_.Exception.Message
		}
	} | Sort-Object -Property Line | Format-Table -AutoSize -Wrap | Out-String).Trim()
}
#endregion End
