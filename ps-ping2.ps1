param( $targetListFileName )

# ping�����s����Ԋu(�~���b)
$interval = 500

# �J��Ԃ���
$repeat   = 100

if (-Not($targetListFileName)){
    Write-Host "Usage : ps-ping2.ps1 <targetListFileName>"
    exit
}

$f = (Get-Content $targetListFileName) -as [string[]]
$targetList = @(0..($f.Length - 1))

$i = 0
foreach ($currentLine in $f) {
    $targetList[$i]=$currentLine
    $i++
}

@(1..$repeat) | foreach {
    $targetList | foreach {

        # �Ԋu�������邽�߂�sleep
        Start-Sleep -Milliseconds $interval

        try {
            if ($_.substring(0,1) -ne "#") {
                # ping���s
                $tc = Test-Connection $_ -count 1 -ErrorAction Stop
                #���ʂ̊i�[
                $result = "��"
            }
        } catch [Exception] {
            # ���s�����ꍇ
            $result = "�~"
        }
        # ���ݎ���
        $datetime = Get-Date -F "yyyy/MM/dd HH:mm:ss.fff"

        # CSV�`���Ō��ʏ����쐬
        $row = $result + "," + $datetime  + "," + $tc.Address + "," + $tc.ResponseTime + "," + $tc.TimeToLive

        # CSV����I�u�W�F�N�g���o��
        $row | ConvertFrom-Csv -Header @("Result","DateTime","Target","ResponseTime(ms)", "TTL")
    }

} | Out-GridView -Title "Ping Results" # �O���b�h�r���[��\������
