---
title: "Touching the Current User Registry Hive with Intune"
slug: "5dd365a31aa1fd743bc30b8e:5e3c86c04983176cf11a0aa2:674b657bd06e27543b023841"
date: "Sat, 30 Nov 2024 20:26:20 +0000"
author: "Steve Weiner"
description: "Let’s cut to the chase—this title doesn’t exactly scream excitement, but it does get straight to the point. If you’ve ever had to deploy registry changes to PCs using Intune, whether via remediations, platform scripts, or within a Win32 app, there are some critical nuances you need to grasp.Intune Context:"
---

Let’s cut to the chase—this title doesn’t exactly scream excitement, but it does get straight to the point. If you’ve ever had to deploy registry changes to PCs using Intune, whether via remediations, platform scripts, or within a Win32 app, there are some critical nuances you need to grasp.

### **Intune Context: User vs. System**

When deploying scripts in Intune, you’re faced with two choices: **system** or **user** context. Notice anything missing? That’s right—there’s no “Administrator” context. This creates an interesting challenge, especially when you need to modify the current user’s registry hive (HKEY\_CURRENT\_USER or HKCU). Typically, you could run a command as the user, targeting the HKCU hive directly.

But here’s the rub: modifying multiple registry keys or performing actions beyond a standard user’s privileges requires elevated rights. Without an Administrator context, your only option is **system**.

### **Why HKCU Alone Won’t Cut It**

Let’s prove the limitation. As a standard user, running the following command gives you access to your HKCU hive (left side):

```
Get-ChildItem -Path "HKCU:\Environment"
```

[View fullsize ![SCR-20241130-myeo.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1732995265733-ZSLYTZYCI82HSCGGDYIF/SCR-20241130-myeo.png?format=1000w)](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1732995265733-ZSLYTZYCI82HSCGGDYIF/SCR-20241130-myeo.png) [View fullsize ![SCR-20241130-myhg.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1732995265750-8P8DNVURB91N5ZDKE5ZS/SCR-20241130-myhg.png?format=1000w)](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1732995265750-8P8DNVURB91N5ZDKE5ZS/SCR-20241130-myhg.png) 

But try the same command in **system** context (right side), and the result is… nothing useful. The system context doesn’t inherently “see” HKCU for the logged-in user because it operates independently of user profiles. So, what’s the workaround? Enter the world of **SIDs**.

### **SID Sleuthing: The Key to Current User Hive Access**

The “HKCU” hive is really just a convenience shortcut. All user hives live under **HKEY\_USERS**, identified by their unique **security identifiers (SIDs)**. With the right SID in hand, you can modify any user’s registry keys—even from the system context.

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/281b6b25-75df-483c-aa31-ebca8bec3a98/SCR-20241130-mfig.png?format=1000w)

### **Testing Locally as SYSTEM**

Before diving into deployment, test your scripts locally in SYSTEM context. Use [Sysinternals](https://learn.microsoft.com/en-us/sysinternals/) to run `cmd.exe` as SYSTEM via **PsExec**. This handy tool lets you replicate the system’s behavior and troubleshoot before going live.

### **Wait—What About HKEY\_USERS?**

If you’ve poked around in PowerShell, you might notice a hiccup: PowerShell doesn’t natively expose the **HKEY\_USERS** root. No worries—you can map it manually with this command:

`New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS`

This creates a new PowerShell drive for the HKEY\_USERS hive, allowing you to run commands like:

`Get-ChildItem -Path "HKU:\<SID>\Software\Example"`

### **A Practical Example: Hiding the Task View Button**

Let’s say you want to hide the **Task View** button on the taskbar for the logged-in user. If running in user context, it’s a one-liner:

`reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f`

But in system context, here’s the process:

1.  **Get the Current User SID:**  
    Identify the logged-in user and translate their username into a SID:
    
    ```
    powershell
    ```
    
    Copy code
    
    `$user = (Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty Username) $sid = (New-Object System.Security.Principal.NTAccount($user)).Translate([System.Security.Principal.SecurityIdentifier]).Value`
    
2.  **Map the HKEY\_USERS Hive:**  
    Add the `HKU` drive in PowerShell:
    
    ```
    powershell
    ```
    
    Copy code
    
    `New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS`
    
3.  **Modify the Registry Key:**  
    Target the correct path in the `HKU` hive:
    
    ```
    powershell
    ```
    
    Copy code
    
    `Set-ItemProperty -Path "HKU:\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0`
    

### **Complete Script**

Here’s the full script to deploy via Intune:

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1cbf0e7e-cc5f-4a4d-bd72-e839e53e36ea/SCR-20241130-mrbu.png?format=1000w)

You can also find an enhanced version with additional Windows 11 settings on my [GitHub](https://github.com/stevecapacity/IntunePowershell/blob/main/Misc%20Intune/win11SettingsFix.ps1).

### **What’s Next?**

Armed with the ability to “context hop,” you’re ready to tackle registry changes and more complex tasks in the system context. This trick opens up possibilities for addressing scenarios that were once a headache in modern management. Go forth and script!