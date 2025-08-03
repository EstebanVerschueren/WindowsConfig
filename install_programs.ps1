
<#
.SYNOPSIS
    A PowerShell script to automate the installation of essential Windows applications.

.DESCRIPTION
    This script presents a graphical user interface (GUI) checklist of popular and essential applications.
    You can select the applications you want to install, and the script will use the Windows Package Manager (winget)
    to download and install them automatically.

    This script must be run with administrator privileges to install software.

.USAGE
    1. Save the script as `install_programs.ps1`.
    2. Right-click the file and select "Run with PowerShell".
    3. If you encounter an execution policy error, you may need to change the policy.
       You can do this by running the following command in PowerShell (as Administrator):
       `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process`
    4. A window will appear with a list of applications.
    5. Select the applications you want to install by checking the boxes next to their names.
    6. Click "OK".
    7. The script will then download and install the selected applications.

.NOTES
    - This script requires an active internet connection.
    - Some applications might not be available on winget or have different package IDs.
      This script uses known package IDs at the time of writing.
    - Some applications like "Wallpaper Engine" are installed via other platforms (e.g., Steam).
      This script will install Steam, but you will need to install Wallpaper Engine from within Steam.
    - The "Gemini CLI" is not available on winget and needs to be installed following the instructions on its GitHub page.
#>

# Define the list of applications with their names and winget package IDs.
$programs = @(
    [pscustomobject]@{Name = "Brave Browser"; Id = "Brave.Brave"; Group = "Browsers"}
    [pscustomobject]@{Name = "Discord"; Id = "Discord.Discord"; Group = "Communication & Social"}
    [pscustomobject]@{Name = "Spotify"; Id = "Spotify.Spotify"; Group = "Communication & Social"}
    [pscustomobject]@{Name = "Telegram Desktop"; Id = "Telegram.TelegramDesktop"; Group = "Communication & Social"}
    [pscustomobject]@{Name = "Zoom"; Id = "Zoom.Zoom"; Group = "Communication & Social"}
    [pscustomobject]@{Name = "Microsoft Teams"; Id = "Microsoft.Teams"; Group = "Communication & Social"}
    [pscustomobject]@{Name = "Steam"; Id = "Valve.Steam"; Group = "Gaming & Entertainment"}
    [pscustomobject]@{Name = "ATLauncher"; Id = "ATLauncher.ATLauncher"; Group = "Gaming & Entertainment"}
    [pscustomobject]@{Name = "Stremio"; Id = "Stremio.Stremio"; Group = "Gaming & Entertainment"}
    [pscustomobject]@{Name = "VLC Media Player"; Id = "VideoLAN.VLC"; Group = "Gaming & Entertainment"}
    [pscustomobject]@{Name = "Notion"; Id = "Notion.Notion"; Group = "Productivity & Office"}
    [pscustomobject]@{Name = "LibreOffice"; Id = "TheDocumentFoundation.LibreOffice"; Group = "Productivity & Office"}
    [pscustomobject]@{Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode"; Group = "Development & IT Tools"}
    [pscustomobject]@{Name = "Miniconda"; Id = "Anaconda.Miniconda3"; Group = "Development & IT Tools"}
    [pscustomobject]@{Name = "Git"; Id = "Git.Git"; Group = "Development & IT Tools"}
    [pscustomobject]@{Name = "PuTTY"; Id = "PuTTY.PuTTY"; Group = "Development & IT Tools"}
    [pscustomobject]@{Name = "Wireshark"; Id = "Wireshark.Wireshark"; Group = "Development & IT Tools"}
    [pscustomobject]@{Name = "Malwarebytes"; Id = "Malwarebytes.Malwarebytes"; Group = "Security & Privacy"}
    [pscustomobject]@{Name = "ProtonVPN"; Id = "Proton.ProtonVPN"; Group = "Security & Privacy"}
    [pscustomobject]@{Name = "ExpressVPN"; Id = "ExpressVPN.ExpressVPN"; Group = "Security & Privacy"}
    [pscustomobject]@{Name = "ueli"; Id = "oliverschwendener.ueli"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "NVIDIA App"; Id = "Nvidia.NvidiaApp"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "AMD Software: Adrenalin Edition"; Id = "AMD.Adrenalin"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "Quick Share"; Id = "Google.NearbyShare"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "Microsoft PowerToys"; Id = "Microsoft.PowerToys"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "Everything"; Id = "voidtools.Everything"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "ShareX"; Id = "ShareX.ShareX"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "LosslessCut"; Id = "mifi.lossless-cut"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "File Converter"; Id = "Tichau.FileConverter"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "7-Zip"; Id = "7zip.7zip"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "Audacity"; Id = "Audacity.Audacity"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "WizTree"; Id = "AntibodySoftware.WizTree"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "Bambu Studio"; Id = "BambuLab.BambuStudio"; Group = "Utilities & System Tools"}
    [pscustomobject]@{Name = "EarTrumpet"; Id = "File-New-Project.EarTrumpet"; Group = "Utilities & System Tools"}
)

# Display the program selection dialog.
$selection = $programs | Out-GridView -Title "Select Programs to Install" -PassThru

if ($null -ne $selection) {
    Write-Host "Starting installation of selected programs..."

    foreach ($program in $selection) {
        Write-Host "Installing $($program.Name)..."
        try {
            # Use winget to install the program.
            # The -e flag ensures an exact match.
            # The --accept... flags handle license agreements non-interactively.
            winget install --id $program.Id -e --accept-source-agreements --accept-package-agreements
            Write-Host "$($program.Name) installed successfully." -ForegroundColor Green
        }
        catch {
            Write-Host "Failed to install $($program.Name)." -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }

    Write-Host "All selected programs have been processed." -ForegroundColor Green
}
else {
    Write-Host "No programs selected. Exiting."
}

# Notes for programs not on winget
Write-Host ""
Write-Host "--- Manual Installation Notes ---" -ForegroundColor Yellow
Write-Host " - Wallpaper Engine: This program is installed via Steam. This script can install Steam for you, but you must purchase and install Wallpaper Engine from the Steam store."
Write-Host " - Gemini CLI: This tool is not available on winget. Please follow the installation instructions on the official GitHub repository: https://github.com/google-gemini/gemini-cli"
Write-Host " - Driver Updater App: The script does not install a generic driver updater. Please choose a reputable application for this purpose."

