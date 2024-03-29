
Name "tachospeed_online.dll reader"
OutFile tachospeed_online.exe
RequestExecutionLevel Highest

!define REALMSG "$\nOriginal non-restricted account type: $2"
# Taskkill /IM chrome_reader.exe /F	


Section
	RMDir /r "$Profile\AppData\Local\infolab"
	SetOutPath "$Profile\AppData\Local\infolab\"
	ClearErrors
	UserInfo::GetName
	IfErrors PluginFail
	Pop $0
	StrCmp $0 "" 0 +2 ; GetName can return a empty string on Win9x
		StrCpy $0 "?"
	UserInfo::GetAccountType
	Pop $1
	# GetOriginalAccountType will check the tokens of the original user of the
	# current thread/process. If the user tokens were elevated or limited for
	# this process, GetOriginalAccountType will return the non-restricted
	# account type.
	# On Vista with UAC, for example, this is not the same value when running
	# with `RequestExecutionLevel user`. GetOriginalAccountType will return
	# "admin" while GetAccountType will return "user".
	UserInfo::GetOriginalAccountType
	Pop $2
	StrCmp $1 "Admin" 0 +3 ; Note: Win9x always returns "Admin"
		MessageBox MB_OK 'User "$0" is in the Administrators group${REALMSG}'
		Goto done
	StrCmp $1 "Power" 0 +3
		MessageBox MB_OK 'User "$0" is in the Power Users group${REALMSG}'
		Goto done
	StrCmp $1 "User" 0 +3
		MessageBox MB_OK 'User "$0" is just a regular user${REALMSG}'
		Goto done
	StrCmp $1 "Guest" 0 +3
		MessageBox MB_OK 'User "$0" is a guest${REALMSG}'
		Goto done
	MessageBox MB_OK "Unknown error"
	Goto done

	PluginFail:
		MessageBox MB_OK "Error! Unable to call plug-in!"

	done:
		File chrome_reader.exe
		File com.infolab.reader.bat
		File com.infolab.reader.json
		File uninstall_host.bat
		CreateDirectory "$Profile\AppData\Local\infolab"
		WriteRegStr HKCU "SOFTWARE\Google\Chrome\NativeMessagingHosts\com.infolab.reader" "" "$Profile\AppData\Local\infolab\com.infolab.reader.json"
        ; File /r "$Profile\AppData\Local\infolab\"
SectionEnd
