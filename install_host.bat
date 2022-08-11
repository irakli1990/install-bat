@REM @echo off
runas /user:Administrator


IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"



IF EXIST "C:\Users\%username%\infolab" (
    rmdir "C:\Users\%username%\infolab" /s /q 
    mkdir "C:\Users\%username%\infolab"
    xcopy "." "C:\Users\%username%\infolab\"
    REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.infolab.reader" /ve /t REG_SZ /d "C:\Users\%username%\infolab\com.infolab.reader.json" /f
    exit /B
)  else ( goto gotoCopy )


:gotoCopy
    rmdir "C:\Users\%username%\infolab" /s /q 
    mkdir "C:\Users\%username%\infolab"
    xcopy "." "C:\Users\%username%\infolab\"
    REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.infolab.reader" /ve /t REG_SZ /d "C:\Users\%username%\infolab\com.infolab.reader.json" /f
    exit /B






