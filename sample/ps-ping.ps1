##-------------------------------------------------------------##
## PowerShell������Exping�̂悤�ȘA��ping�����s����
## https://qiita.com/akira6592/items/236939ad62bd1f98371e
##-------------------------------------------------------------##

# ping�����s���鈶����w�肷��
$targets = @"
192.168.1.1
192.168.1.9
192.168.1.8
192.168.1.14
"@ -split "\r\n"

# �ݒ�
# ping�����s����Ԋu(�~���b)
$interval = 500

# �J��Ԃ���
$repeat   = 100

@(1..$repeat) | foreach {
    $targets | foreach {
        # �Ԋu�������邽�߂�sleep
        Start-Sleep -Milliseconds $interval
        try {
            # ping���s
            $tc = Test-Connection $_ -count 1 -ErrorAction Stop

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
    }

} | Out-GridView -Title "Ping Results" # �O���b�h�r���[��\������
