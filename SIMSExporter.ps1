$simsdir = "C:\Program Files (x86)\SIMS\SIMS .net\"
$ReportDumping = "C:\ScheduledCommandLineSIMSReports"
#Report Names
$ReportsToRun = "your","reports","here"


Start-Transcript -Path C:\SIMSPSScripts\Log.txt

net use S: \\server\sims

cd $simsdir -Verbose

#clean up from old run

Remove-Item -Path "$ReportDumping\*.csv" -verbose -ErrorAction SilentlyContinue

#Run SIMS Report
foreach ($report in $ReportsToRun) {
  .\commandreporter.exe /user:simsuser /password:mypassword /report:$report /OUTPUT:"$ReportDumping\$report.csv"
  Send-MailMessage -From simsreports@mydomain.com -Subject "SIMS Report - $Report" -To "person1@mydomain.com" -Cc "person2@mydomain.com" -Attachments "$ReportDumping\\$report.csv" -SMTPServer 127.0.0.1 -Port 25 -Verbose
}

Stop-Transcript