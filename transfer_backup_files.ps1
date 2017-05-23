# Variables
$sourse  = Get-ChildItem 'D:\mssql\backup' -Recurse
$destination = '\\192.168.0.38\File Backup\1C'
$date = Get-Date -Format dd.MM.yyyy
$log = "D:\mssql\logs\transfer_log__$date.txt"
$user = "backup"
$password = Get-Content -Path C:\PS\key | ConvertTo-SecureString 
$Credental = New-Object System.Management.Automation.PSCredential $user,$password



# Run
'----------------------------------' | Out-File $log -Append

if(!$sourse){
    'Папка пуста' | Out-File $log -Append
    }

else {

    foreach($file in $sourse){

        Try{
            Start-BitsTransfer -Description 'Копирую...' -Priority Low -Source $file.FullName -Destination $destination -Credential $Credental  -Authentication Negotiate 

            $fileInNewPath = Get-ChildItem -Path $destination -Name $file
            if(!$fileInNewPath){
                "ВНИМАНИЕ! ФАЙЛ $file НЕ ПЕРЕМЕЩЕН!"  | Out-File $log -Append
                } 
            else {
                "$file : скопирован"  | Out-File $log -Append
                Write-Host "$file : скопирован" -ForegroundColor Green

                Remove-Item -Path $file.FullName
                }
            }

        Catch [system.exception] {
            Write-Host $_.Exception -ForegroundColor Red
            }
    }
}