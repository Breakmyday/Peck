function Peck {
    param (
        [string]$Text,
        [int]$TypeDelay = 50,
        [int]$StartDelay = 3,
        [switch]$Loop,
        [switch]$EnterLine
    )

    # Replace &nbsp; with regular spaces
    $Text = $Text -replace " ", " "

 

    
    for ($StartDelay; $StartDelay -ge 1; $StartDelay--) {
        Write-Host $StartDelay -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
    Start-Sleep -Seconds $StartDelay

 

    $characters = $Text.ToCharArray()

 

    # Load the System.Windows.Forms and user32.dll assemblies
    Add-Type -AssemblyName System.Windows.Forms
    $user32 = Add-Type -Name User32 -Namespace Win32Functions -PassThru -MemberDefinition @"
        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern short GetAsyncKeyState(int virtualKeyCode);
"@

 

    while ($true) {
        foreach ($char in $characters) {
            # Check whether the interrupt key is pressed
            $interruptKeyState = $user32::GetAsyncKeyState([System.Windows.Forms.Keys]::'Escape')
            if ($interruptKeyState -lt 0) {
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

 

        if (-not $Loop) {
            break
        }
    }
}


