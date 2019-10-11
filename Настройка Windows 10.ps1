# ---------------------------- БЛОК ИНФОРМАЦИИ -------------------------------
#
# "Автоматизированная настройка Windows 10"
# Версия: 0.1 beta
# Дата создания: 22-01-2018
# Дата последнего редактирования: 22-01-2018
#
# Проверено на Windows 10 Pro:
#       1703 (сборка 15063.0)
#
#
# ------------------------------- КОНЕЦ БЛОКА --------------------------------


# ------------------------------- БЛОК ФУНКЦИЙ -------------------------------

# Отключаем автоустановку игрушек Windows
function disable_game_autoinstall{
    try{
        
        Set-ItemProperty -Path  HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -name SilentInstalledAppsEnabled -value 0
        
        Write-Host "Автоустановка игр отключена!" -ForegroundColor Green
        
        }
    
    catch {
       
        Write-Host "Не удалось отключить автоустановку игр из магазина Windows" -ForegroundColor DarkRed
       
        }
   
}



# Удаляем встроенные приложения Windows
function remove_appx{

    $appxs = '*MinecraftUWP*','*Microsoft3DViewer*', '*MarchofEmpires*', '*MSPaint*', '*Getstarted*', '*StorePurchaseApp*', '*BubbleWitch3Saga*','*AutodeskSketchBook*', '*OneCalendar*', '*CandyCrushSodaSaga*','*XboxApp*','*XboxGameOverlay*','*XboxSpeechToTextOverlay*','*XboxGameCallableUI*','*XboxIdentityProvider*','*wallet*','*sticky*','*messagin*','*feedback*','*appinstaller*','*alarm*','*people*','*communicationsapps*', '*zunevideo*', '*zunemusic*','*3dbuilder*', '*skypeapp*','*solitaire*','*officehub*','*camera*', '*onenote*', '*bing*', '*soundrecorder*', '*windowsphone*'

    foreach ($appx in $appxs){

        try{

            Get-AppxPackage -allusers $appx | Remove-AppxPackage
            
            Write-Host "Приложение $appx удалено!" -ForegroundColor Green
            
            } 
        
        catch{
            
            Write-Host "Не удалось удалить пакет $appx" -ForegroundColor DarkRed
            
            }
    }
}
    
# Отключаем службу обновления Windows
function disable_windows_update{

    try{
        
        Set-Service -Name 'wuauserv' -StartupType Disabled
        Set-Service -Name 'wuauserv' -Status Stopped

        Write-Host "Служба обновления Windows отключена!" -ForegroundColor Green

        }

   catch{

        Write-Host "Не удалось отключить или остановить службу обновления Windows!" -ForegroundColor DarkRed
        
        }
        

}


# Включение компонентов:
# 1. NET Framework 3.5
# 2. клиент Telnet
# Отключение компонентов:
# 1. Службы XPS

function setup_windows_future{
    
    try{
        
        Disable-WindowsOptionalFeature -FeatureName 'Printing-XPSServices-Features' -Online
        
        Write-Host "Службы XPS отключены!" -ForegroundColor Green

        }

   catch{

        Write-Host "Не удалось отключить службы XPS!" -ForegroundColor DarkRed

        }
    
    
    try{
        
        Enable-WindowsOptionalFeature -FeatureName 'NetFx3' -Online
        
        Write-Host "NET Framework 3.5 включен!" -ForegroundColor Green

        }

   catch{

        Write-Host "Не удалось включить NET Framework 3.5!" -ForegroundColor DarkRed
       
        }



    try{
        
        Enable-WindowsOptionalFeature -FeatureName 'TelnetClient' -Online
        
        Write-Host "Клиент Telnet включен!" -ForegroundColor Green

        }

   catch{

        Write-Host "Не удалось включить клиента Telnet!" -ForegroundColor DarkRed

        }
    
}


# Настройка плиток в меню Пуск
function importStartpanelLayout{
    
     



    
    
}

# ------------------------------- КОНЕЦ БЛОКА -------------------------------


# ------------------------------- БЛОК ИНТЕРФЕЙСА ---------------------------

#Add-Type -assembly System.Windows.Forms

#$main_form = New-Object System.Windows.Forms.Form

# Заголовок формы
#$main_form.Text ='Настройка Windows 10'

# Ширина формы
#$main_form.Width = 800
#$main_form.Height = 600

# Форам будет растягиваться если ширина элементов больше
#$main_form.AutoSize = $true


## Метка
##$label = New-Object System.Windows.Forms.Label
#$label.Text = 'Настройки системы'
#$label.Location  = New-Object System.Drawing.Point(340,10)
#$label.AutoSize = $true
#$main_form.Controls.Add($label)


# Метка
#$label1 = New-Object System.Windows.Forms.Label
#$label1.Text = 'Автоматический режим'
#$label1.Location  = New-Object System.Drawing.Point(0,10)
#$label1.AutoSize = $true
#$main_form.Controls.Add($label1)





# Чекбоксы
#$CheckBox = New-Object System.Windows.Forms.CheckBox
#$CheckBox.Text = 'Отключить автоустановку игр Windows'
#$CheckBox.AutoSize = $true
#$CheckBox.Checked = $true
#$CheckBox.Location  = New-Object System.Drawing.Point(20,40)
#$main_form.Controls.Add($CheckBox)

# Кнопка запуска всего
#$startBtn = New-Object System.Windows.Forms.Button
#$startBtn.Text = 'Выполнить'
#$startBtn.Location = New-Object System.Drawing.Point(700,530)
#$main_form.Controls.Add($startBtn)

#$tab = New-Object System.Windows.Forms.TabControl
#$tab.TabPages.Add($tabPage1, $tabPage2)



# ------------------------------- КОНЕЦ БЛОКА -------------------------------


# ------------------------------- БЛОК ВЫПОЛНЕНИЯ ---------------------------

# Вывод формы на экран
# $main_form.ShowDialog()

setup_windows_future
remove_appx
disable_windows_update
disable_game_autoinstall

# ------------------------------- КОНЕЦ БЛОКА -------------------------------
