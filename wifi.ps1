$output = @()
$listSSID = @()
#Listar todos los SSID guardados en el equipo
$output = netsh.exe wlan show profiles name = “*” | Select-String -Pattern ‘Nombre de SSID’

foreach ($i in $output){
try{$listSSID += ($i -split “:”)[1].Trim() -replace ‘”‘}catch{}
}

foreach ($SSID in $listSSID){
$output = netsh.exe wlan show profiles name =”$SSID” key=clear
try{
$PwSearchResult = $output | Select-String -Pattern ‘Contenido de la clave’
$PW = ($PwSearchResult -split “:”)[1].Trim()
}catch{}
[pscustomobject] @{
WifiProfileName = $SSID
Password = $PW
}
}
