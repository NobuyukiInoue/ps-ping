param( $targetIP )

# �ݒ�
# ping�����s����Ԋu(�~���b)
$interval = 1000

# �J��Ԃ���
$repeat   = 3

if (-Not($targetIP)){
    Write-Host "Usage : ps-ping3.ps1 <IP Address>"
    exit
}

@(1..$repeat) | foreach {
    # �Ԋu�������邽�߂�sleep
    Start-Sleep -Milliseconds $interval
    
    try {
        # ping���s
        $tc = Test-Connection $targetIP -count 1 -ErrorAction Stop
        #���ʂ̊i�[
        $result = "��"
    } catch [Exception] {
        # ���s�����ꍇ
        $result = "�~"
    }
    
    # ���ݎ���
    $datetime = Get-Date -F "yyyy/MM/dd HH:mm:ss.fff"

    # CSV�`���Ō��ʏ����쐬
    $row = $result + "," + $datetime  + "," + $tc.Address + "," + $tc.ResponseTime 

    # CSV����I�u�W�F�N�g���o��
    $row | ConvertFrom-Csv -Header @("Result","DateTime","Target","ResponseTime(ms)")

} | Out-GridView -Title "Ping Results" # �O���b�h�r���[��\������
