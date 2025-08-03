# Windows Setup Script

This repository contains a PowerShell script to automate the setup of a new Windows installation. It includes steps to declutter the OS and install essential programs.

## How to Run the Script

1.  **Open PowerShell as Administrator:**
    *   Click the Start menu.
    *   Type "PowerShell".
    *   Right-click on "Windows PowerShell" and select "Run as administrator".

2.  **Navigate to the project directory:**
    ```powershell
    cd C:\projects\WindowsConfig
    ```

3.  **Set the Execution Policy (for the current process only):**
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
    ```

4.  **Run the script:**
    ```powershell
    .\install_programs.ps1
    ```

5.  A window will appear with a checklist of programs. Select the ones you want to install and click "OK".
