##-----------------------------------------------------------------##
## powerShell��ping��ł��Ă݂�
## http://harikofu.blog.fc2.com/blog-entry-1.html
##-----------------------------------------------------------------##

# AP�T�[�o
[String[]]$addressAp = @('10.15.10.201', '10.15.10.247', '10.15.10.248', '10.15.10.254')

# Ping�����s���܂��B
$pingAlive = @(Test-Connection -ComputerName $addressAp -Quiet)

# ���s���ʂ��m�F���܂��B
for($i = 0; $i -lt $pingAlive.Count; $i++) {

   # Ping�����̏ꍇ�̂݁A���������s���܂��B
   if ($pingAlive[$i] -eq $True) {
       Write-Host ($addressAp[$i] + '=Ping����')
   } else {
       Write-Host ($addressAp[$i] + '=Ping���s')
   }
}
