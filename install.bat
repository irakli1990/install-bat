@echo off
runas /user:Administrator


@REM if not "%1"=="am_admin" (
@REM     powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
@REM     exit /b
@REM )

powershell Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
powershell -command "Start-BitsTransfer -Source https://github.com/irakli1990/install-bat/blob/master/native/com.infolab.reader.zip -Destination com.infolab.reader.zip"
powershell -command "Expand-Archive com.infolab.reader.zip ./extracted"
powershell Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy Restricted

@REM IF EXIST c:\aaaa (
@REM     echo download is in progress...
@REM     powershell -Command "Invoke-WebRequest https://images.dog.ceo/breeds/hound-walker/n02089867_953.jpg -Outfile c:/aaaa/dog.jpg"
@REM     echo done!
@REM ) ELSE (
@REM     echo No
@REM     mkdir C:\infolab
@REM     @echo off
@REM     REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.infolab.reader" /ve /t REG_SZ /d "c:/infolab/com.infolab.reader.json" /f
@REM )

