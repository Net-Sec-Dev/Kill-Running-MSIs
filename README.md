# Force-Terminate Running MSI / Installer Processes

A simple, automated PowerShell script to detect and forcibly terminate running MSI-based and common installer processes. Designed for remediation and deployment workflows where stuck or conflicting installers must be cleared before continuing. Suitable for use with deployment tools like **Ansible** and **PDQ Deploy**.

## Overview

This script will:  
- Detect running **Windows Installer (`msiexec.exe`)** processes.  
- Identify other installer-related processes via command-line inspection (`.msi`, `setup.exe`, `installer`).  
- Forcibly terminate detected installer processes.  
- Output clear status and error messages for logging and automation visibility.  
- Exit cleanly to allow uninterrupted automated workflows.  

## Configuration

This script requires **no configuration**. <br />
No variables, paths, or parameters need to be modified prior to execution. <br />
The script must be run with sufficient privileges to terminate installer processes (Administrator recommended). <br />

## Exit Codes

0	Script completed successfully (installer processes terminated or none found).<br />

> **Note:**  
> The script always exits with `0` to avoid blocking deployment pipelines. Individual process termination failures are logged but do not change the exit code.

## How It Works
```text
Start
 │
 │ Enumerate running processes using Win32_Process
 │
 │ Filter for installer-related processes
 │       ├─> msiexec.exe
 │       ├─> Command line contains .msi
 │       ├─> setup.exe
 │       └─> installer
 │
 │ If matching processes are found
 │       └─> Iterate through each process
 │             ├─> Attempt forced termination
 │             └─> Log success or failure
 │
 │ If no matching processes are found
 │       └─> Log that no installer processes are running
 │
End ──> Exit 0 (Success)
