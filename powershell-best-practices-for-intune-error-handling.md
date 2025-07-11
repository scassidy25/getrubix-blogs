---
author: steve@getrubix.com
date: Fri, 04 Apr 2025 19:16:21 +0000
description: '"In the last part we looked at why logging is so importing with the
  scripts we push to Intune. However, the best logging in the world can’t help you
  if we have nothing to log.So today we’ll about error handling, ensuring scripts
  are resilient, readable, and easy"'
slug: powershell-best-practices-for-intune-error-handling
thumbnail: http://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1743794171034-BCXILX4E05CY5NG3P6A2/karate_steve.jpg
title: PowerShell Best Practices for Intune Error Handling
---

In the [last part](https://www.getrubix.com/blog/powershell-best-practices-for-intune-logging) we looked at why logging is so importing with the scripts we push to Intune. However, the best logging in the world can’t help you if we have nothing to log.

So today we’ll about error handling, ensuring scripts are resilient, readable, and easy to debug.  
  
Watch the YouTube video here:

Why Error Handling Matters
--------------------------

When scripts execute operations such as file manipulation or process management, unexpected failures can occur. Without proper error handling, these failures can go unnoticed, making troubleshooting difficult. Proper error handling:

-   Enhances script robustness
    
-   Provides useful debugging information
    
-   Prevents scripts from terminating unexpectedly
    

Using `Try-Catch` Blocks
------------------------

A foundational practice in PowerShell error handling is the use of `try-catch` blocks. These allow developers to attempt an operation and gracefully handle any issues that arise:

```
try {
    Get-Content -Path "C:\nonexistentfile.txt"
} catch {
    Write-Output "Something went wrong: $_"
}
```

To make this effective, the `ErrorAction` should be set to `Stop` to ensure non-terminating errors are caught:

```
Get-Content -Path "C:\nonexistentfile.txt" -ErrorAction Stop
```

Logging and `$_.Exception.Message`
----------------------------------

Effective logs are invaluable. Combining your custom messages with PowerShell’s detailed error messages provides clarity:

```
catch {
    Write-Output "Caught error: $($_.Exception.Message)"
}
```

This approach helps pinpoint what failed and why.

Boolean Checks with `$?` and Numeric Checks with `$LastExitCode`
----------------------------------------------------------------

Use `$?` to determine the success of the last command. It returns `True` if the command succeeded, and `False` otherwise:

```
if ($?) {
    Write-Output "Operation succeeded."
} else {
    Write-Output "Operation failed."
}
```

For more nuanced status checks, `$LastExitCode` reflects the exit code from the last native application executed:

```
ping 127.0.0.1
Write-Output $LastExitCode  # Should return 0

ping 256.256.256.256
Write-Output $LastExitCode  # Should return 1
```

Global Error Action with `$ErrorActionPreference`
-------------------------------------------------

Setting `$ErrorActionPreference = 'SilentlyContinue'` globally ensures that all commands suppress noisy error messages, making logs cleaner:

```
$ErrorActionPreference = 'SilentlyContinue'
```

Use this with caution, as it can hide critical errors.

Final Thoughts
--------------

Error handling should not be an afterthought. By proactively managing errors, you can ensure your PowerShell scripts for Intune are reliable and maintainable. Make use of structured `try-catch` blocks, informative logs, and clear exit code handling to elevate your scripting practice.