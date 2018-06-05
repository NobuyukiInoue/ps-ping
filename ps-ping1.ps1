param( $targetListFileName )

##---------------------------------------------------------------------------##
## Main
##---------------------------------------------------------------------------##

if (-Not($targetListFileName)){
    Write-Host "Usage : ps-ping1.ps1 <targetListFileName>"
    exit
}

# AP�T�[�o
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

# Ping�����s���܂��B
$pingAlive = @(Test-Connection -ComputerName $targetList -Quiet)

# ���s���ʂ��m�F���܂��B
for($i = 0; $i -lt $pingAlive.Count; $i++) {

   # Ping�����̏ꍇ�̂݁A���������s���܂��B
   if ($pingAlive[$i] -eq $True) {
       Write-Host ($targetList[$i] + ' : Ping����')
   } else {
       Write-Host ($targetList[$i] + ' : Ping���s')
   }
}
