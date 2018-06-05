param( $targetIP )

# 設定
# pingを実行する間隔(ミリ秒)
$interval = 1000

# 繰り返し数
$repeat   = 3

if (-Not($targetIP)){
    Write-Host "Usage : ps-ping3.ps1 <IP Address>"
    exit
}

@(1..$repeat) | foreach {
    # 間隔をあけるためのsleep
    Start-Sleep -Milliseconds $interval
    
    try {
        # ping実行
        $tc = Test-Connection $targetIP -count 1 -ErrorAction Stop
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

} | Out-GridView -Title "Ping Results" # グリッドビューを表示する
