---
title: "PowerShell Best Practices for Intune Dont fight the functions"
slug: "5dd365a31aa1fd743bc30b8e:5e3c86c04983176cf11a0aa2:67f932f95fca5378ac49d40a"
date: "Fri, 11 Apr 2025 15:38:06 +0000"
author: "Steve Weiner"
description: "PowerShell functions provide a structured way to organize reusable code. In the context of Microsoft Intune and system administration, they enhance script readability, reduce duplication, and improve long-term maintainability. And while I completely understand not wanting to take “structured” advice from me, it will definitely help you in the"
---

PowerShell functions provide a structured way to organize reusable code. In the context of Microsoft Intune and system administration, they enhance script readability, reduce duplication, and improve long-term maintainability. And while I completely understand not wanting to take “structured” advice from me, it will definitely help you in the long run.

This guide explains what functions are and why you need to start incorporating them in your PowerShell Intune journey.

_\*There isn’t a corresponding video for this piece yet, that will come out Tuesday the 15th._

What are PowerShell Functions?
------------------------------

A PowerShell function is a named block of code that performs a defined task. You declare it once and call it wherever needed in your script:

function Get-IntuneWelcome {

    Write-Output "Welcome to Intune. Please update your policies."

}

Get-IntuneWelcome

Functions can also take parameters, allowing for flexible and reusable logic:

function Get-IntuneWelcome {
    param(\[string\]$UserName)
    Write-Output "Hello $UserName, please ensure your device is compliant."
}

Get-IntuneWelcome -UserName "Steve"

Why Use Functions Instead of Inline Code?
-----------------------------------------

There are several reasons to define functions rather than writing inline code repeatedly:

-   **Avoid Duplication**: Reusing logic without copy-pasting improves maintainability.
    
-   **Improved Readability**: Named functions clarify the intent of each code block.
    
-   **Testing**: Functions can be tested independently.
    
-   **Error Isolation**: Errors can be managed more effectively when logic is encapsulated.
    

### Example Comparison: Inline Code vs. Function

This block of code manually checks the compliance status of two users, “Alice” and “Bob”, using Microsoft Intune cmdlets.

**Without a Function (Inline Repetition):**

$user = "Alice"
Write-Output "Checking compliance for $user"
$status = Get-IntuneManagedDevice -Filter "userPrincipalName eq '$user'"
Write-Output "Compliance Status: $($status.ComplianceState)"

$user = "Bob"
Write-Output "Checking compliance for $user"
$status = Get-IntuneManagedDevice -Filter "userPrincipalName eq '$user'"
Write-Output "Compliance Status: $($status.ComplianceState)"

Now here is the same code providing the same result but structured in a function:

function Check-UserCompliance {
    param(\[string\]$UserName)
    Write-Output "Checking compliance for $UserName"
    $status = Get-IntuneManagedDevice -Filter "userPrincipalName eq '$UserName'"
    Write-Output "Compliance Status: $($status.ComplianceState)"
}

Check-UserCompliance -UserName "Alice"
Check-UserCompliance -UserName "Bob"

The function version is more concise, avoids repetition, and improves readability.

Characteristics of Well-Written Functions
-----------------------------------------

While a function can literally be made up of whatever you want it to be, there are some general guidelines and best practices that will help structure your functions to be more useful.

An effective function in PowerShell should:

-   Use a descriptive name (e.g., `Get-ComplianceStatus`)
    
-   Accept parameters where appropriate
    
-   Return output in a consistent format
    
-   Include basic error handling
    

**Example:**

function Get-DeviceCompliance {
    param(\[string\]$DeviceID)
    try {
        $status = Get-IntuneManagedDevice -DeviceId $DeviceID
        return $status.ComplianceState
    } catch {
        Write-Warning "Device not found: $DeviceID"
    }
}

Start Small and User Your Imagination
-------------------------------------

The best way to get started with functions, is just like getting started with anything else; start doing it!

Do you find yourself copying and pasting the same lines of code over and over in a script? Make a function.

Are you running the same lines of code multiple times a day to achieve the same result? Put that thing in a function.

Start slow and try to solve problems that will make your life easier. In the future, we’ll go deeper into functions by introducing switches, custom output, pipelines, and more.