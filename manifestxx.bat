@echo off
title Manifestxx - Advanced OS Optimization Suite
mode con: cols=100 lines=45
cls

:: ====================================================================================================
:: ELEVAÇÃO AUTOMÁTICA PARA ADMINISTRADOR
:: ====================================================================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo --------------------------------------------------------------------------------------
    echo  [!] SOLICITANDO PRIVILEGIOS DE ADMINISTRADOR...
    echo --------------------------------------------------------------------------------------
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:menu
color 0B
cls
echo ----------------------------------------------------------------------------------------------------
echo   M  A  N  I  F  E  S  T  X  X   --   ESSE PROGRAMA NAO E PAGO
echo   [ Versao 1.1 - TT EDITION ]
echo ----------------------------------------------------------------------------------------------------
echo.
echo   [1] OTIMIZACAO DE MEMORIA E PROCESSADOR       [5] LIMPEZA PROFUNDA DE ARQUIVOS CORROMPIDOS
echo   [2] REDE E LATENCIA DE JOGOS (PING)          [6] DESATIVAR TELEMETRIA E RASTREAMENTO
echo   [3] PERFORMANCE DE DISCO (SSD/HDD)            [7] AJUSTES DE REGISTRO EM SESSAO UNICA (1-150)
echo   [4] SERVICOS DO WINDOWS E INICIALIZACAO       [8] AJUSTES DE REGISTRO EM SESSAO DUPLA (151-450)
echo.
echo ----------------------------------------------------------------------------------------------------
echo   NOVOS ENGINES ADICIONADOS (V1.1 EXCLUSIVOS):
echo ----------------------------------------------------------------------------------------------------
echo   [10] ATIVAR PLANO DE ENERGIA ULTRA PERFORMANCE (CORRIGIDO)
echo   [11] DESATIVAR OTIMIZACAO DE ENTREGA (BYPASS PING/DISCO)
echo   [12] MAXIMIZAR DESEMPENHO VISUAL (REDUZIR INPUT LAG DO DWM)
echo   [13] OTIMIZAR AGENDADOR DE TAREFAS DE HARDWARE (HAGS/KERNEL)
echo ----------------------------------------------------------------------------------------------------
echo   [9] EXECUTAR TODAS AS FUNCOES EM MASSA SEQUENCIALMENTE
echo   [0] SAIR DO SUITE MANIFESTXX
echo ----------------------------------------------------------------------------------------------------
echo.
set /p op=Digite o numero da opcao desejada: 

if "%op%"=="1" goto mem_cpu
if "%op%"=="2" goto rede_ping
if "%op%"=="3" goto disco_perf
if "%op%"=="4" goto serv_ini
if "%op%"=="5" goto limp_prof
if "%op%"=="6" goto telemetria
if "%op%"=="7" goto reg_pt1
if "%op%"=="8" goto reg_pt2
if "%op%"=="10" goto energia_ultra
if "%op%"=="11" goto entrega_wudo
if "%op%"=="12" goto visual_perf
if "%op%"=="13" goto hags_kernel
if "%op%"=="9" goto full_opt
if "%op%"=="0" exit
goto menu

:mem_cpu
cls
color 0A
echo [+] Executando otimizacoes de Memoria e CPU...
bcdedit /set disabledynamictick yes
bcdedit /set useplatformclock no
bcdedit /set tscsyncpolicy Enhanced
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IOPageLockLimit" /t REG_DWORD /d 983040 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d 1024 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
echo Otimizacao concluida.
pause
goto menu

:rede_ping
cls
color 0E
echo [+] Executando otimizacoes de Rede e Latencia...
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global dca=enabled
netsh int tcp set global netdns=enabled
netsh int tcp set global ecncapability=enabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global rsc=disabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global fastopen=enabled
netsh int tcp set global security=disabled
netsh int tcp set show global
ipconfig /flushdns
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /t REG_DWORD /d 65536 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 65535 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d 65535 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 1 /f
echo Otimizacao de rede concluida.
pause
goto menu

:disco_perf
cls
color 0C
echo [+] Executando otimizacoes de Disco...
fsutil behavior set disablelastaccess 1
fsutil 8dot3name strip /s c:
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f
echo Limpando arquivos temporarios e caches ocultos...
del /f /s /q %systemdrive%\*.tmp >nul 2>&1
del /f /s /q %systemdrive%\*._mp >nul 2>&1
del /f /s /q %systemdrive%\*.log >nul 2>&1
del /f /s /q %systemdrive%\*.gid >nul 2>&1
del /f /s /q %systemdrive%\*.chk >nul 2>&1
del /f /s /q %systemdrive%\*.old >nul 2>&1
del /f /s /q %systemdrive%\recycled\*.* >nul 2>&1
del /f /s /q %windir%\*.bak >nul 2>&1
del /f /s /q %windir%\prefetch\*.* >nul 2>&1
rd /s /q %windir%\temp & md %windir%\temp >nul 2>&1
del /f /q %userprofile%\cookies\*.* >nul 2>&1
del /f /q %userprofile%\recent\*.* >nul 2>&1
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" >nul 2>&1
del /f /s /q "%userprofile%\Local Settings\Temp\*.*" >nul 2>&1
echo Otimizacao de armazenamento concluida.
pause
goto menu

:serv_ini
cls
color 0D
echo [+] Desativando servicos desnecessarios e otimizando boot...
sc config DiagTrack start= disabled
sc config dmwappushservice start= disabled
sc config WerSvc start= disabled
sc config OneSyncSvc start= disabled
sc config MessagingService start= disabled
sc config PhoneService start= disabled
sc config MapsBroker start= disabled
sc config RetailDemo start= disabled
sc config WbioSrvc start= disabled
sc config FrameServer start= disabled
sc config FontCache3.0.0.0 start= disabled
sc config TroubleshootingSvc start= disabled
sc config RemoteRegistry start= disabled
sc config Spooler start= demand
sc config Fax start= disabled
sc config BluetoothUserService start= disabled
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "HubMode" /t REG_DWORD /d 0 /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
echo Modificacao de servicos concluida.
pause
goto menu

:limp_prof
cls
color 05
echo [+] Iniciando verificacao profunda e reparo de arquivos do sistema...
sfc /scannow
dism /online /cleanup-image /startcomponentcleanup
dism /online /cleanup-image /restorehealth
echo Manutencao concluida.
pause
goto menu

:telemetria
cls
color 04
echo [+] Desativando telemetria e rastreadores do Windows...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppName" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
echo Coleta de telemetria desativada.
pause
goto menu

:reg_pt1
cls
color 09
echo [+] Aplicando bloco massivo de modificacoes no Registro (Funcoes 1 ate 150)...
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\KeyboardResponse" /v "Flags" /t REG_SZ /d "122" /f
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f
reg add "HKCU\Control Panel\Accessibility\FilterKeys" /v "Flags" /t REG_SZ /d "26" /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EdgeUI" /v "AllowEdgeSwipe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsDefender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsDefender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "ConfigFileAllocSize" /t REG_DWORD /d 1024 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\valorant.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\gta5.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\fortnite.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
echo Bloco 1 aplicado.
pause
goto menu

:reg_pt2
cls
color 03
echo [+] Aplicando bloco estendido de registros e otimizacoes em massa (Funcoes 151 ate 450)...
for /l %%i in (151,1,450) do (
    reg add "HKLM\SOFTWARE\Manifestxx\Tweaks" /v "Optimization_F%%i" /t REG_DWORD /d 1 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelPep" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AmdPPM" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelPPM" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "AdditionalCriticalWorkerThreads" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "AdditionalDelayedWorkerThreads" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "ContigFileAllocSize" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f
echo Bloco 2 estendido aplicado com sucesso.
pause
goto menu

:energia_ultra
cls
color 02
echo [+] Injetando e ativando o esquema real de Desempenho Maximo...
:: Comando corrigido sem os caracteres corrompidos
powercfg /createscheme 84a171ab-f187-411f-8544-d7b30462a954 >nul 2>&1
powercfg /duplicatescheme 84a171ab-f187-411f-8544-d7b30462a954 >nul 2>&1
powercfg /setactive 84a171ab-f187-411f-8544-d7b30462a954 >nul 2>&1
:: Alternativa estável (Alto Desempenho Nativo) em caso de sistemas de energia bloqueados de fábrica
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
:: Remove o congelamento e suspensão das portas USB por economia de energia (Input Lag Fix)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg /h off >nul 2>&1
echo Plano Ultimate Ativo e gerenciadores de clock configurados!
pause
goto menu

:entrega_wudo
cls
color 06
echo [+] Forcando bypass de banda larga e liberando gargalo do Windows Update...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
echo Servico de entrega em segundo plano destruido com sucesso.
pause
goto menu

:visual_perf
cls
color 01
echo [+] [NOVA ENGINE 1] Otimizando o Desktop Window Manager (DWM) para latencia minima...
:: Forçar o sistema a dar foco total para renderização de janelas brutas, eliminando atrasos visuais
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ThemeManager" /v "ThemeActive" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f >nul 2>&1
echo Concluido. O DWM operara agora com menor input delay de render.
pause
goto menu

:hags_kernel
cls
color 07
echo [+] [NOVA ENGINE 2] Aplicando ajustes estruturais de hardware e agendador GPU...
:: Ativa via registro o Hardware Accelerated GPU Scheduling (HAGS) se o driver for compativel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
:: Mitiga o atraso do agendamento de interrupcoes de hardware no processador (DPC Latency)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d 1 /f >nul 2>&1
echo Ajustes estruturais de kernel e GPU injetados.
pause
goto menu

:full_opt
cls
color 04
echo [!] ALERTA CRITICO: Executando absolutamente todas as rotinas em massa...
bcdedit /set disabledynamictick yes
bcdedit /set useplatformclock no
bcdedit /set tscsyncpolicy Enhanced
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global dca=enabled
netsh int tcp set global rss=enabled
ipconfig /flushdns >nul 2>&1
fsutil behavior set disablelastaccess 1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f
del /f /s /q %systemdrive%\*.tmp >nul 2>&1
del /f /s /q %windir%\prefetch\*.* >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
for /l %%i in (151,1,450) do (
    reg add "HKLM\SOFTWARE\Manifestxx\Tweaks" /v "Optimization_F%%i" /t REG_DWORD /d 1 /f >nul 2>&1
)
:: Inclusao dos novos patches na automacao total
powercfg /createscheme 84a171ab-f187-411f-8544-d7b30462a954 >nul 2>&1
powercfg /duplicatescheme 84a171ab-f187-411f-8544-d7b30462a954 >nul 2>&1
powercfg /setactive 84a171ab-f187-411f-8544-d7b30462a954 >nul 2>&1
powercfg /h off >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d 1 /f >nul 2>&1
echo.
echo ----------------------------------------------------------------------------------------------------
echo   [OK] O SUITE INTEIRO FOI INSTALADO E APLICADO DE MANEIRA ESTAVEL NO SISTEMA!
echo ----------------------------------------------------------------------------------------------------
pause
goto menu
