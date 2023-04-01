function Send-KeyPeck {
    param (
        [string]$Text,
        [int]$TypeDelay  = 50,
        [int]$StartDelay = 3,
        [switch]$Loop,
        [switch]$EnterLine
    )

    # Replace &nbsp; with regular spaces
    $Text = $Text.Replace(" ", " ")

    # Countdown before starting
    1..$StartDelay | ForEach-Object {
        Write-Host $_ -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }

    $characters = $Text.ToCharArray()

    # Load the System.Windows.Forms and user32.dll assemblies
    Add-Type -AssemblyName System.Windows.Forms
    $user32 = Add-Type -Name User32 -Namespace Win32Functions -PassThru -MemberDefinition @"
        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern short GetAsyncKeyState(int virtualKeyCode);
"@

    do {
        foreach ($char in $characters) {
            # Check whether the interrupt key is pressed
            if ($user32::GetAsyncKeyState([System.Windows.Forms.Keys]::'Escape') -lt 0) {
                Write-Verbose "Interrupt key Escape pressed. Stopping SendKeys operation." -Verbose
                return
            }
            [System.Windows.Forms.SendKeys]::SendWait($char)
            Start-Sleep -Milliseconds $TypeDelay
        }

        if ($EnterLine) {
            Write-Verbose "Pressing enter."
            [System.Windows.Forms.SendKeys]::SendWait("{Enter}")
            Start-Sleep -Milliseconds $TypeDelay
        }
    } while ($Loop)
}