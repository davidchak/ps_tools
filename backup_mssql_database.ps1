# БЭКАПЕР MSSQL 
# Автор: Давид Чакирян
# Версия: 1.0

# TODO:
# 1. Копирование на сетевой диск
# 2. Проверка на сетевом диске директориии формата "месяц год"
# 3. Удаление старых копий



$database = 'buh', 'zup31', 'zup-old', 'ut'
# $database = 'pochko'
$date = Get-date -format '__dd_MM_yyyy'
$backup_path = 'D:\mssql\backup\'
$backup_servers = '192.168.0.95' 
$backup_remote_path = ''
$user = 'guest'
$pass = ''
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass

foreach ($base in $database){
    $backup_file = $backup_path + $base + $date + '.bak'
    Backup-SqlDatabase -BackupAction Database -CompressionOption On -Database $base -ServerInstance 'sql1c\sql14' -BackupFile $backup_file
    $test_file = Test-Path $backup_file
    if ($test_file) {
        Write-Host "File: $backup_file"
               
    } else {
        Write-Host 'Error'
    }
}


# Подключаем сетевой диск если его нет
try{
   Get-psdrive -Name "K" -ErrorAction Stop
}
catch{
   New-psdrive -Name "K" -Root "\\192.168.0.95\backup1c\" -PSProvider FileSystem -Credential $cred
}


# Копируем файлы
try{
    
    $backup_files = Get-ChildItem -Path $backup_path
    foreach($file in $backup_files){
        Write-Host $file.FullName
        Move-Item -Path $file.FullName -Destination 'K:\\2019' -Credential $cred
    } 
}

catch{
    write-host "Error!"
}
finally {
    Remove-PSDrive -Name 'K'
}



