---
author: stevew1015@gmail.com
date: Mon, 11 Sep 2023 14:18:08 +0000
description: '"If you’re wondering why I haven’t been writing much on here, it’s because
  I’ve been busy over on the Getrubix YouTube channel. Here is a quick summary of
  each Intune tenant to tenant device migration video so you can easily jump to an
  area of interest.New videos"'
slug: /blog/intune-migration-watch-it-on-youtube
thumbnail: https://getrubixsitecms.blob.core.windows.net/public-assets/content/v1/logo512.png
title: Intune Migration watch it on YouTube
---

If you’re wondering why I haven’t been writing much on here, it’s because I’ve been busy over on the [Getrubix YouTube channel](https://www.youtube.com/@getrubix9986/featured). Here is a quick summary of each Intune tenant to tenant device migration video so you can easily jump to an area of interest.

New videos are being added almost daily, so I’ll continue to update this list as it grows.

Part 1: Live demo
-----------------

This is the first upload about our Intune migration process. I show a completely live the demo of the finished process and end-user experience.

Part 2: Starting to build
-------------------------

In Part 2, we start constructing the actual StartMigrate.ps1 PowerShell script together, which is the foundation for the solution.

Part 3: Migrate user data
-------------------------

Part 3 is arguably the most important (and definitely the longest). I break down the steps we use to migrate the user data between profiles.

Part 4: Cleaning up
-------------------

This was right after my trip from Hershey Park, hence the chocolate. Part 4 is about removing Tenant A MDM enrollment details from the PC.

Part 5: Leaving Tenant A
------------------------

Part 5 shows us how to un-join the PC from Tenant A, whether it’s Azure AD or Hybrid joined.

Part 6: The bulk primary refresh token
--------------------------------------

Part 6 is all about the building the provisioning package (PPKG) and how to obtain the bulk primary refresh token.

Part 7: Wrapping up the start
-----------------------------

In Part 7, we wrap up completing the StartMigrate.ps1 PowerShell script.

Part 8: Starting the post-migration tasks
-----------------------------------------

Part 8 starts our journey through the post-migration tasks and how we XML and PowerShell files to make it happen.

It’s beyond awesome how many of you are checking out (and hopefully trying) our migration solution. If you missed it, here is the beginning of the series:

[Tenant to Tenant Intune Device Migration: The Beginning of a Series](https://www.getrubix.com/blog/tenant-to-tenant-intune-device-migration-the-beginning-of-a-series)

And here is the link to the GitHub repo which contains all the files needed:

[GitHub: IntuneMigration](https://github.com/stevecapacity/IntuneMigration)