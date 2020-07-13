param(
    [Parameter()]
    [Int32]$attempts = 3,

    [Parameter()]
    [Int32]$sleep = 10,

    [Parameter()]
    [bool]$keepAlive = $false
)

try {
    $Win32ShowWindowAsync = Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@ -name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru
} catch {}

Write-Output "Hiding GoXLR Windows...";

while (($attempts -gt 0) -or ($keepAlive -eq $true)) {
    # Get All GoXLR app processes and find one with a window handle
    (Get-Process -Name "GOXLR APP*").MainWindowHandle | ForEach-Object { 
        if($_ -eq 0) { return; } # We can ignore processes spun up that have no window

        Write-Output "Found a GoXLR Window... Closing it now.";

        # We'll Hide the window through its handle
        $Win32ShowWindowAsync::ShowWindowAsync($_, 0) | Out-Null
    }

    Write-Output "Attempts remaining: $attempts, sleeping for $sleep, keep alive: $keepAlive"
    if($keepAlive -eq $false) {
        $attempts--;
    }
    Start-Sleep -Seconds $sleep
}
