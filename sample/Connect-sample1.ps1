##-----------------------------------------------------------------##
## powerShellでpingを打ってみた
## http://harikofu.blog.fc2.com/blog-entry-1.html
##-----------------------------------------------------------------##

# APサーバ
[String[]]$addressAp = @('10.15.10.201', '10.15.10.247', '10.15.10.248', '10.15.10.254')

# Pingを実行します。
$pingAlive = @(Test-Connection -ComputerName $addressAp -Quiet)

# 実行結果を確認します。
for($i = 0; $i -lt $pingAlive.Count; $i++) {

   # Ping成功の場合のみ、処理を実行します。
   if ($pingAlive[$i] -eq $True) {
       Write-Host ($addressAp[$i] + '=Ping成功')
   } else {
       Write-Host ($addressAp[$i] + '=Ping失敗')
   }
}
