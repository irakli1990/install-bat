@echo off
runas /user:Administrator

REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.infolab.reader" /ve /t REG_SZ /d "c:\user\com.infolab.reader.json" /f




