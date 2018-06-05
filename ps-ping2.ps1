param( $targetListFileName )

# pingを実行する間隔(ミリ秒)
$interval = 500

# 繰り返し数
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

        # 間隔をあけるためのsleep
        Start-Sleep -Milliseconds $interval

        try {
            if ($_.substring(0,1) -ne "#") {
                # ping実行
                $tc = Test-Connection $_ -count 1 -ErrorAction Stop
                #結果の格納
                $result = "○"
            }
        } catch [Exception] {
            # 失敗した場合
            $result = "×"
        }
        # 現在時刻
        $datetime = Get-Date -F "yyyy/MM/dd HH:mm:ss.fff"

        # CSV形式で結果情報を作成
        $row = $result + "," + $datetime  + "," + $tc.Address + "," + $tc.ResponseTime + "," + $tc.TimeToLive

        # CSVからオブジェクトを出力
        $row | ConvertFrom-Csv -Header @("Result","DateTime","Target","ResponseTime(ms)", "TTL")
    }

} | Out-GridView -Title "Ping Results" # グリッドビューを表示する
