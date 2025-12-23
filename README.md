# Basic Bot Traffic Identifier Template

## Overview

The **Basic Bot Traffic Identifier** is a Google Tag Manager custom variable template designed to help you classify traffic as either **potential_bot_traffic** or **potential_real_traffic**. Without any customization, this variable automatically checks if the traffic referrer matches any of the known system-defined bot referral patterns.

This template allows you to enhance your bot detection strategy while providing flexible options for customization to suit your specific needs.


---

## What’s New in Version 2

- ✅ **Automatic detection of legacy operating systems** (Windows, macOS, Linux, Android, iOS)
- ✅ Ability to **exclude specific legacy OS versions** you *do not* want treated as bot traffic
- ✅ Fully **restructured User Agent filtering logic** with a clear priority order

---

## Key Features

### Out-of-the-Box Detection
- **Automatic Referrer Matching**: Even without customization, the template checks referrer domains against a pre-defined list of known bot referrals.

### Customization Options
1. **Include Referral Patterns**: Add your own referral domains to classify as bot traffic.
2. **Exclude Referral Patterns**: Specify referral domains to exclude from bot traffic classification.
3. **Mark `.appspot.com` Domains as Bot Traffic**:
   - Includes specific handling for `gtm-msr.appspot.com` to identify Google App Engine traffic as bot traffic.
   - When enabled, classifies traffic with `.appspot.com` in the page's host domain as bot traffic.
4. **Navigator WebDriver Detection**:
   - Checks the `navigator.webdriver` property to detect automated visits.
   - `navigator.webdriver` defines a standard way for cooperating user agents to inform the document that it is controlled by WebDriver, making it a reliable method for detecting bots.
   - **How to Create a JavaScript Variable**:
     1. Go to **Variables** in Google Tag Manager.
     2. Add a new **Custom JavaScript Variable**.
     3. Use the global variable name: `navigator.webdriver`.
     4. Reference this variable in the **Bot Traffic Identifier** template.
5. **User-Agent Detection**:
   ## User Agent Filtering (Version 2)

User Agent filtering is now **clearly layered and predictable**. Each stage is evaluated in order.

### User Agent Processing Order

1. **Legacy Operating System Auto Detection**
2. **Legacy OS Exclusion Overrides**
3. **Manual OS Version Exclusion Table**
4. **Known Bot Signature Detection**
5. **Custom Include / Exclude Bot Overrides**

---

** Automatic Legacy OS Detection (New)**

Version 2 can automatically label traffic as bot traffic when it originates from **outdated operating systems**, which are commonly used by bots, crawlers, and spoofed agents.

Supported platforms include:
- Windows
- macOS
- Linux
- Android
- iOS

This detection works automatically once enabled—no manual input required.

---

**Legacy OS Exclusion Overrides (New)**

- You can **exclude specific legacy OS versions** from being labeled as bot traffic.
- Useful when:
  - Supporting old enterprise devices
  - Internal tools run on older systems
- Overrides **always win** over automatic legacy detection.

---

**Manual OS Version Filtering**

- Explicitly define **OS versions** you want treated as bot traffic.
- Takes effect regardless of legacy auto-detection.

---

**Known Bot Signature Detection**

- Automatically detects traffic based on known bots using the built-in list of well-known crawlers and bots user-agent strings. (updated the list using [Markus Baersch's](https://www.linkedin.com/in/markusbaersch/)
  list)
- Optionally:
  - **Add new bot signatures**
  - **Exclude specific bots**, even if they exist in the default list

---

## Supported Legacy Operating Systems

### Windows (Legacy)

| OS Version | Approx. Release Year |
|----------|---------------------|
| Windows NT 6.1 (Windows 7) | 2009 |
| Windows NT 6.0 (Vista) | 2007 |
| Windows NT 5.1 (XP) | 2001 |
| Windows NT 5.0 (2000) | 2000 |
| Windows NT 4.0 | 1996 |
| Windows 3.x / 2.x / 1.x | 1985–1992 |

---

### macOS (Legacy)

| macOS Version | Release Year |
|--------------|-------------|
| Mac OS X 10.0 – 10.4 | 2001–2005 |
| Mac OS X 10.5 (Leopard) | 2007 |
| Mac OS X 10.6 (Snow Leopard) | 2009 |
| Mac OS X 10.7 (Lion) | 2011 |
| Mac OS X 10.8 (Mountain Lion) | 2012 |
| Mac OS X 10.9 (Mavericks) | 2013 |

---

### Linux (Legacy Distributions – 2010 or Earlier)

| Distribution | Version | Release Year |
|-------------|--------|--------------|
| Ubuntu | 7.10 – 9.10 | 2007–2009 |
| Debian | 3.1 – 5.0 | 2005–2009 |
| Fedora | 9 – 12 | 2008–2009 |
| openSUSE | 11.1 – 11.2 | 2008–2009 |
| Linux Mint | 7 | 2009 |
| CentOS | 5.4 | 2009 |
| Slackware | 13.0 | 2009 |

---

### Android (Legacy)

| Android Version | Release Year |
|----------------|--------------|
| Android 1.x | 2008 |
| Android 2.x | 2009–2011 |
| Android 3.x | 2011 |
| Android 4.x | 2011–2013 |
| Android 5.x | 2014 |
| Android 6.x | 2015 |
| Android 7.x | 2016 |

---

### iOS (Legacy)

| iOS Version | Release Year |
|------------|--------------|
| iOS 1 – 3 | 2007–2009 |
| iOS 4 | 2010 |
| iOS 5 | 2011 |
| iOS 6 | 2012 |
| iOS 7 | 2013 |

---

   - Allows you to add your own user-agent patterns to include or exclude as bots.
   - **How to Create a JavaScript Variable**:
     1. Go to **Variables** in Google Tag Manager.
     2. Add a new **Custom JavaScript Variable**.
     3. Use the global variable name: `navigator.userAgent`.
     4. Reference this variable in the **Bot Traffic Identifier** template.

### Cookie Support
- A cookie is set only when traffic is labeled as `potential_bot_traffic`.
- Useful for cases where the bot's referral changes after landing on subsequent pages.
- Cookie properties:
  - Name: `gtm_var_temp_label`.
  - Duration: 30 minutes.
  - Secure by default.




---

## Author

Created by **Jude Nwachukwu Onyejekwe**.

This template is part of the [Dumbdata.co Measurement Resource Hub](https://dumbdata.co), which provides resources designed to simplify measurement strategies and implementations.

---

## How to Use
1. Download the `template.tpl` file from this repository.
2. Import the template into Google Tag Manager under the **Templates** section.
3. Customize the fields as needed to meet your bot detection requirements.
4. Publish your GTM container and start identifying bot traffic with ease.

For questions or support, reach out at [Dumbdata.co](https://dumbdata.co).

