---
title: "Put App Patching on Your Radar"
slug: "5dd365a31aa1fd743bc30b8e:5e3c86c04983176cf11a0aa2:67c21fb1c5036825a6aba486"
date: "Fri, 28 Feb 2025 20:55:33 +0000"
author: "Steve Weiner"
description: "That title is funny. Shut up.Keeping third-party applications updated in Microsoft Intune has always been a challenge for IT administrators. Manually tracking app versions, deploying updates, and ensuring patch compliance can quickly become a tedious process. Enter Robopack Radar, the latest feature in Robopack designed to detect and patch"
---

That title is funny. Shut up.

Keeping third-party applications updated in Microsoft Intune has always been a challenge for IT administrators. Manually tracking app versions, deploying updates, and ensuring patch compliance can quickly become a tedious process. Enter **Robopack Radar**, the latest feature in Robopack designed to **detect and patch existing apps** in your Intune environment.

Radar simplifies patching by **scanning your Intune environment**, identifying applications already deployed, and providing an easy way to **assign them to patch groups** for automatic updates. Let’s take a closer look at how it works.  
  
If you want to watch Radar in action, you can watch it [**here**](https://youtu.be/nnIGS8z6yT4).

**Step 1: Access Radar in Robopack**
------------------------------------

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/f41c474d-ccb4-453a-b655-be76b3d913e7/robopack1.png?format=1000w)

After logging into Robopack, you’ll find **Radar** in the left-hand menu below “Instant Apps.” Clicking on **Radar** takes you to a dashboard where you can scan your Intune environment for existing applications.

**Step 2: Scan Your Intune Tenant**
-----------------------------------

![robopack2.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1740775550456-XRLP7VS4TTW1EE23VX3R/robopack2.png?format=1000w)  
![robopack3.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1740775550362-R6GEO8B3AL8D2MWRGDD4/robopack3.png?format=1000w)  

Once inside the Radar interface, you can **select an Intune tenant** from the dropdown list and then click **“Scan Intune with Radar.”** This process retrieves all applications currently managed or discovered within Intune.

After scanning, Radar presents a detailed list of apps **already deployed in Intune**. These applications are classified as either:

• **Discovered**: Apps installed on endpoints but not explicitly managed through Intune.

• **Intune Apps**: Applications already being managed within Intune.

**Step 3: Identify Apps Ready for Patching**
--------------------------------------------

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/b82900d8-2c0e-4060-a7de-f27ea0f0e7c7/robopack4.png?format=1000w)

Once the scan completes, you’ll see a list of **apps available for patching** along with their publisher, version, and type. The results can be **searched and filtered** to quickly locate specific applications.

Some apps may not be eligible for automatic patching—Radar conveniently categorizes these separately, prompting admins to manually specify or upload an installer if needed.

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/31fa7d6c-7b10-434f-9f48-3c148d77d064/robopack5.png?format=1000w)

**Step 4: Assign Apps to a Patch Group**
----------------------------------------

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/e81cc2e3-1958-4a09-8f11-bd004f7adb79/robopack6.png?format=1000w)

Radar allows you to select multiple apps and assign them to a **patch group** for streamlined updates. Patch groups define which devices receive updates first, ensuring a controlled rollout.

For example, you can create a **“Patch Group Zero”** to include critical applications like Docker Desktop, Git, and Microsoft .NET SDK.

**Step 5: Automate Patching with Patch Groups**
-----------------------------------------------

Once assigned, your selected apps will be **automatically updated** within Intune using Robopack’s patching system. Patch groups can be configured to **retain a set number of previous versions** to allow for rollbacks.

![](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/3a3e4435-bf12-4f09-8cc6-4c30eef28123/robopack7.png?format=1000w)

**Why Robopack Radar is a Game-Changer**
----------------------------------------

**✅ Eliminates Manual Tracking**

Instead of manually keeping track of app versions, Radar **automatically detects and presents** all installed applications.

**✅ Seamless Integration with Intune**

Radar works **natively with Intune**, making it easy to patch both managed and unmanaged apps in one place.

**✅ Efficient Patch Management**

Assigning apps to patch groups ensures a **structured update process**, allowing IT teams to test updates in phases before rolling them out to the entire organization.

**✅ Better Security & Compliance**

Keeping apps up to date is critical for **security and compliance**. Radar makes it effortless to **ensure apps remain patched** across all Intune-managed devices.