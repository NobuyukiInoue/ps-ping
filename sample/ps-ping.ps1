##-------------------------------------------------------------##
## PowerShellだけでExpingのような連続pingを実行する
## https://qiita.com/akira6592/items/236939ad62bd1f98371e
##-------------------------------------------------------------##

# pingを実行する宛先を指定する
$targets = @"
192.168.1.1
192.168.1.9
192.168.1.8
192.168.1.14
"@ -split "\r\n"

# 設定
# pingを実行する間隔(ミリ秒)
$interval = 500

# 繰り返し数
$repeat   = 100

@(1..$repeat) | foreach {
    $targets | foreach {
        # 間隔をあけるためのsleep
        Start-Sleep -Milliseconds $interval
        try {
            # ping実行
            $tc = Test-Connection $_ -count 1 -ErrorAction Stop

            #結果の格納
            $result = "○"
        } catch [Exception] {
            # 失敗した場合
            $result = "×"
        }
        # 現在時刻
        $datetime = Get-Date -F "yyyy/MM/dd HH:mm:ss.fff"

        # CSV形式で結果情報を作成
        $row = $result + "," + $datetime  + "," + $tc.Address + "," + $tc.ResponseTime 

        # CSVからオブジェクトを出力
        $row | ConvertFrom-Csv -Header @("Result","DateTime","Target","ResponseTime(ms)")
    }

} | Out-GridView -Title "Ping Results" # グリッドビューを表示する
