# Variables
$sourse  = Get-ChildItem 'D:\sourse\path' -Recurse
$destination = '\\destination\path'
$date = Get-Date -Format dd.MM.yyyy
$log = "D:\log_path\transfer_log__$date.txt"
$user = "backup_username"
$password = Get-Content -Path 'C:\path_with_encrypted_password\key' | ConvertTo-SecureString 
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
