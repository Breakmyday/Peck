# Send-KeyPeck

Send-KeyPeck is a PowerShell function that simulates human-like typing by sending keystrokes to the active window. You can use Send-KeyPeckto type text with a configurable typing speed, start delay, and choose whether to loop the text or press Enter after typing. It can be useful for automating tasks that require manual typing, demonstrating typing effects in presentations, or just having fun!

## Installation

1. Download the `Send-KeyPeck.ps1` file from this repository.
2. Place the file in your desired location on your computer.

## Usage

To use the Peck function, you should import the script as a module in your PowerShell session.

1. Open PowerShell.
2. Navigate to the directory where you saved the `Send-KeyPeck.ps1` file.
3. Import the script as a module with the following command:

`Import-Module .\Send-KeyPeck.ps1`

4. Use the Peck function with the following command:

`Send-KeyPeck -Text "your_text_here" -TypeDelay 50 -StartDelay 3 -Loop -EnterLine`

Replace `"your_text_here"` with the text you want to type. You can also customize the other parameters as needed:

* `-TypeDelay`: The time delay (in milliseconds) between each keystroke. Default is 50 milliseconds.
* `-StartDelay`: The time delay (in seconds) before typing starts. Default is 3 seconds.
* `-Loop`: A switch to loop the text. If not provided, the text will be typed once.
* `-EnterLine`: A switch to press Enter after typing the text. If not provided, Enter will not be pressed.

Make sure to click on the desired window where you want the text to be typed before the `StartDelay` time elapses.

To stop the typing process, press and hold the `Escape` key.

## Contributing

If you'd like to contribute to this project, please submit a pull request, issue, or suggestion on GitHub.
