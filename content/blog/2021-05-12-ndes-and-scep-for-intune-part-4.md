---
title: "NDES and SCEP for Intune Part 4"
slug: "/blog/ndes-and-scep-for-intune-part-4"
date: "Wed, 12 May 2021 18:42:22 +0000"
author: "stevew1015@gmail.com"
description: " Can you smell that?&nbsp; It’s the smell of almost being done deploying SCEP certificates to Windows 10 devices from Intune via the Intune SCEP connector and NDES server. In case you missed it, you can start from Part 1, here.Part 4: Adding the root, deploying SCEP and achieving"
---

Can you smell that?  It’s the smell of almost being done deploying SCEP certificates to Windows 10 devices from Intune via the Intune SCEP connector and NDES server.

_In case you missed it, you can start from Part 1,_ [_here_](https://www.getrubix.com/blog/ndes-and-scep-for-intune-part-1)_._

**Part 4: Adding the root, deploying SCEP and achieving victory**
-----------------------------------------------------------------

### **Export the Root Certificate (CA)**

Log into the CA and open an elevated CMD prompt.  Type the following:

```
certutil -ca.cert C:\root.cer
```

![Picture1.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844082586-IK38KPUSED1GWDIHAHL1/Picture1.png)

Obviously, feel free to use whatever path you’re comfortable with for the root certificate.

### **Deploy Trusted Root Certificate Profile (Intune)**

Log into Intune at [https://endpoint.microsoft.com](https://endpoint.microsoft.com) and navigate to **Devices -> Windows -> Configuration profiles** and click **+Create profile**. Choose **Windows 10** **\-> Templates -> Trusted certificate**.

![Picture2.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844124943-PIJ7DKFWOPCW2HFV5MR9/Picture2.png)

In the “Certificate file” field, navigate to your root.cer you exported in the last step and upload it.

In “Destination store”, select **Computer certificate store – Root**.

![Picture3.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844189456-D142NHAIMWHENXMPN2IV/Picture3.png)

Assign this profile to a device group.

### **Configure SCEP profile (Intune)**

Assuming you’re still logged into the Endpoint Manager, create another configuration profile.  Choose **Windows 10 –> Templates -> SCEP certificate**. 

![Picture4.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844200395-OE1DZ26TK9HC3B4S2JWK/Picture4.png)

Fill out the following fields in the SCEP certificate profile:

-   **Certificate type**: Device
    
-   **Subject name format**: CN={{AAD\_Device\_ID}}
    
-   **Certificate validity period**: 2 Years
    
-   **Key storage provider (KSP)**: Enroll to Trusted Platform Module (TPM) KSP if present, otherwise Software KSP
    
-   **Key usage**: Key encipherment, Digital signature
    
-   **Key size (bits)**: 2048
    
-   **Hash algorithm**: SHA-2
    
-   **Root Certificate**: <NAME OF ROOT CERT FROM PREVIOUS STEP>
    
-   **Extended key usage**: Client Authentication
    
-   **SCEP Server URLs**: https://<NAME OF YOUR EXTERNAL URL FROM AZURE APP PROXY>/certsrv/mscep/mscep.dll
    

![Picture5.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844323147-2ZCUWN7NQJJ3VQZDL8AH/Picture5.png)

Assign the SCEP profile to a device group, and watch it deploy.

**EPILOGUE: Troubleshooting**
-----------------------------

You should feel proud.  That was a convoluted and painful process, but you did it.  Now if for some reason the SCEP cert doesn’t deploy, there’s a few good steps you can take to troubleshoot.

### **Validate NDES PowerShell script**.

Microsoft offers a PowerShell script called “Validate-NDESConfiguration.ps1” that can be found [here.](https://github.com/microsoftgraph/powershell-intune-samples/blob/master/CertificationAuthority/Validate-NDESConfiguration.ps1) It’s a very useful script that you run on your NDES server to make sure all your ducks are in a row. It will very clearly point out if you missed a step or something isn’t configured correctly.

![Picture7.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844579892-FW45116LXL1UP7X2KE7C/Picture7.png)

### **Test the Azure App Proxy**

Before deploying anything, you should ensure the Azure App Proxy is doing it’s job.  To do that, just navigate to the external URL from any browser.  You should see the Windows IIS page coming from the NDES:

![Picture8.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844619513-K3Y3WWCBXXRNRRZJUWVV/Picture8.png)

Next, verify that the full MSCEP path works by navigating to the full path in your SCEP profile.  It should be [**https://<yourExternalURL>/certsrv/mscep/mscep.dll**](https://%3cyourExternalURL%3e/certsrv/mscep/mscep.dll).  While it looks scary, be happy if you see this:

![Picture9.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844646040-ULJHYIBKV79XQ0RBKEVG/Picture9.png)

That’s because this is a service and not a website to go browsing on. 

### **\*\*IF HYBRID JOINING**

If you’re using Autopilot to perform a Hybrid Azure AD join for Windows 10, and you plan to deploy a SCEP cert, you need to make one important change.

For Subject name format, use **CN={{FullyQualifiedDomainName}}**.

![Picture6.png](https://images.squarespace-cdn.com/content/v1/5dd365a31aa1fd743bc30b8e/1620844902326-UYI3BTDCUTA6WTGKEHMW/Picture6.png)

### **Re-trace your steps**

If things aren’t working the way they should, don’t worry.  There are a lot of steps in this process that will have you bouncing back and forth between AD servers, Azure sites and Intune.  Even if you don’t nail it on the first shot, don’t get down.  Just going through the whole process several times, you’ll feel more comfortable and have a better understanding of how the pieces work together. 

Reach out if you hit a snag at [steve@getrubix.com](mailto:steve@getrubix.com).

Thanks for hanging in there with me.