[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Set-ExecutionPolicy Bypass -Scope Process -Force
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$programs = 
@(
    "googlechrome",  
    "7zip",          
    "adobereader",
    "firefox",
    "javaruntime",
    "thunderbird",
    "vlc"
)

function Siema
{
    Write-Output " ________  ________  ___  ___  _________  ________  ________      "
    Write-Output "|\   ___ \|\   __  \|\  \|\  \|\___   ___\\   __  \|\   ___  \    "
    Write-Output "\ \  \_|\ \ \  \|\  \ \  \\\  \|___ \  \_\ \  \|\  \ \  \\ \  \   "
    Write-Output " \ \  \ \\ \ \   __  \ \  \\\  \   \ \  \ \ \  \\\  \ \  \\ \  \  "
    Write-Output "  \ \  \_\\ \ \  \ \  \ \  \\\  \   \ \  \ \ \  \\\  \ \  \\ \  \ "
    Write-Output "   \ \_______\ \__\ \__\ \_______\   \ \__\ \ \_______\ \__\\ \__\"
    Write-Output "    \|_______|\|__|\|__|\|_______|    \|__|  \|_______|\|__| \|__|"
    Write-Output "                                                                  "
    Write-Output "       *Skrypt co robi ze nowe komputery maja rzeczy i wogle*     "
    Write-Output "                                                                  "
}

function Check_Chocolatey 
{
    try 
    {
        choco -v > $null 2>&1
        if ($LASTEXITCODE -ne 0) 
        {
            Write-Output "Chocolatey nie zainstalowany. Instalowanie..."
            Install-Chocolatey
        } 
        else 
        {
            Write-Output "Chocolatey zainstalowany."
        }
    } 
    catch 
    {
        Write-Output "Bladd podczas sprawdzania Chocolatey: $_"
        Install-Chocolatey
    }
}

function Install-Chocolatey 
{
    try 
    {
        Write-Output "Instalowanie Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Write-Output "Chocolatey został pomyslnie zainstalowany."
    } 
    catch 
    {
        Write-Output "Blad podczas instalacji Chocolatey: $_"
        exit 1
    }
}

function Install-Program 
{
    param 
    (
        [string]$programName
    )
    try 
    {
        Write-Output "***************************************************************************************************************"
        Write-Output "Instalowanie $programName..."
        choco install $programName -y
        if ($LASTEXITCODE -eq 0) 
        {
            Write-Output "$programName zainstalowany."
            Write-Output "***************************************************************************************************************"
        } 
        else 
        {
            Write-Output "Bladd podczas instalacji $programName."
        }
    } 
    catch 
    {
        Write-Output "${programName}: $_"
    }
}

Siema
Check_Chocolatey

foreach ($program in $programs) 
{
    Install-Program -programName $program
}
Write-Output "Wszystkie programy zostaly zainstalowane."
Pause