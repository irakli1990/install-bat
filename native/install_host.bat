@echo off
runas /user:Administrator

REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.infolab.reader" /ve /t REG_SZ /d "C:\Users\%username%\AppData\Local\infolab\com.infolab.reader.json" /f
