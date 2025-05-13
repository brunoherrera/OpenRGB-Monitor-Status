Set objShell = CreateObject("WScript.Shell")
strScriptDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
objShell.Run "powershell.exe -WindowStyle Hidden -File """ & strScriptDirectory & "\openRGBMonitorStatus.ps1""", 0, False
