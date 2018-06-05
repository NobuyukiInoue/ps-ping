param( $targetListFileName )

##---------------------------------------------------------------------------##
## Main
##---------------------------------------------------------------------------##

if (-Not($targetListFileName)){
    Write-Host "Usage : ps-ping1.ps1 <targetListFileName>"
    exit
}

# APサーバ
#[String[]]$targetList = @('10.15.10.201', '10.15.10.247', '10.15.10.248', '10.15.10.254')

$f = (Get-Content $targetListFileName) -as [string[]]
#Write-Host `$f.Length : $f.Length

$targetList = @(0..($f.Length - 1))
#Write-Host `$lines.Length : $lines.Length

$i = 0
foreach ($currentLine in $f) {
    if ($currentLine.Substring(0,2) -eq ".\"){
        $currentLine = $currentLine.Substring(2)
    }

    $targetList[$i]=$currentLine
    $i++
}

# Pingを実行します。
$pingAlive = @(Test-Connection -ComputerName $targetList -Quiet)

# 実行結果を確認します。
for($i = 0; $i -lt $pingAlive.Count; $i++) {

   # Ping成功の場合のみ、処理を実行します。
   if ($pingAlive[$i] -eq $True) {
       Write-Host ($targetList[$i] + ' : Ping成功')
   } else {
       Write-Host ($targetList[$i] + ' : Ping失敗')
   }
}
