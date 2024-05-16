# Import-Module posh-git
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme half-life
# Set-PoshPrompt -Theme zash
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/ys.omp.json" | Invoke-Expression
# CheckNetIsolation.exe loopbackexempt -a -p=8xx8rvfyw5nnt


# If ($PWD -eq "\nPath\n----\nC:\Users\Lps--\n") {
#    Set-Location ~\Desktop
# }

# -------------------------------------------------------------------------------------------------------------

# 设置Alias
$ShortName = @{
    'wgt' = 'winget'
    'grep' = 'findstr'
    'chksum' = 'Get-FileHash'
    'py' = 'python'
    'hbs' = 'hb-service'
    'getapp' = 'Get-Appxpackage'
    'omp' = 'oh-my-posh'
    'pg' = 'ping'
    'mcsrv' = 'bedrock_server'
    'svm' = 'Start-VM'
    'pvm' = 'Stop-VM'
    'mux' = 'musicfox'
#    'ip' = 'ipconfig'
}
$ShortName.Keys | ForEach-Object { Set-Alias $_ $ShortName.$_}

# -------------------------------------------------------------------------------------------------------------

<#
Get-Service "Touch Keyboard and Handwriting Panel Service" >> restrtsvc.txt
Start-Sleep -m 500
If (Get-Content C:\Users\admin\Desktop\restrtsvc.txt | ForEach-Object {$_ -match "Stopped"}) {
    restart-service "Touch Keyboard and Handwriting Panel Service"
    Write-Output "Restarting TabletInputService..." Succeeded!
}
else {
    Write-Output "Input service started!"
}
Start-Sleep -m 500
Remove-Item restrtsvc.txt

weather

Get-Service "QPcore Service"

Write-Output "fun with code!"
#>

# -----------------------------------------------------------------------------------------------------------------

# 密码生成器
function pwgen() {
    param (
        [int]$l             # 密码位数参数，非必须
    )

    # 设置取值范围：大小写字母、数字及符号
    $lettersMinor = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z";
    $lettersMajor = "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z";
    $symbols = "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", "~", "|", "}", "{", "[", "]", "?",  "/", "-", "=";
    $numbers = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9";
    
    # 初始化密码值
    $passcode = ""
    
    # 判断是否输入了参数，若无，则指定为10位
    if ($l -eq 0) {
        $l = 10
    }

    # 生成密码
    while ($i -lt $l) {
        $addon = $lettersMinor, $lettersMajor, $symbols, $numbers | Get-Random
        $passcode = $passcode + $addon
        $i += 1
    }

    # 复制新密码至剪贴板并回执
    $passwd = $passcode.Trim("`n")
    $passwd | clip.exe
    return $passwd
}

# -----------------------------------------------------------------------------------------------------------------

# 查看最近修改/创建的文件
function recent(){
    $a=$((Get-ChildItem|Where-Object {$_.Mode -like "*"}|Sort-Object LastWriteTime -Descending|Select-Object -first 1|Format-List Name|out-string).Split(":")[-1])
    return $a.Trim(" .-`t`n`r")
}

# -----------------------------------------------------------------------------------------------------------------

# 封装winget、sudo、ip
function wgts(){
    winget search $args[0]
}

function wgti(){
    winget install $args[0]
}

function wgtp(){
    winget uninstall $args[0]
}

function wgtu(){
    winget upgrade $args[0]
}

function sudo(){
    Start-Process -FilePath $args[0] -Verb RunAs
}

function adc(){
    $host = "10.0.0." + $args[0] + ":5555"
    adb connect $host
}

function ip(){
    Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true | Select-Object -ExpandProperty IPAddress
}
# -----------------------------------------------------------------------------------------------------------------

Clear-Host
