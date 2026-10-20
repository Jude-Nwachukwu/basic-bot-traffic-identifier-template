# Basic Bot Traffic Identifier Template

## Overview

The **Basic Bot Traffic Identifier** is a Google Tag Manager custom variable template that classifies each visit as either **potential_bot_traffic** or **potential_real_traffic**.

Out of the box, with no configuration at all, it checks the visit's referrer against a built-in list of known bot referral domains. From there you can layer on extra checks: user agent filtering, legacy operating system detection, `navigator.webdriver`, missing page information, and more.

Use the variable's output in triggers, exceptions, or tag settings to keep bot visits out of your analytics and ad platforms.

---

## What's New in Version 3

- **Missing page property checks.** Mark a visit as bot traffic when the hostname, the page title, or the page URL is missing.
- **Linux exclusion.** A new option that classifies desktop Linux visits as bot traffic. Android devices are not affected, even though their user agent also contains "Linux".

### Version 2 highlights

- Automatic detection of legacy operating systems (Windows, macOS, Linux, Android, iOS)
- Ability to exclude specific legacy OS versions from being treated as bot traffic
- Restructured user agent filtering with a clear order of priority

---

## Key Features

### Out-of-the-Box Detection

- **Automatic referrer matching.** Even without any customization, the template checks the referrer domain against a pre-defined list of known bot referrals.

### Customization Options

1. **Inclusion Referrals.** Add your own referral domains to classify as bot traffic.
2. **Exclusion Referrals.** Add referral domains that should never be labeled as bot traffic.
3. **Mark .appspot.com Visits As Bot Traffic.** Classifies visits where the page's hostname contains `.appspot.com` (for example `gtm-msr.appspot.com`, which is Google App Engine traffic) as bot traffic.
4. **Navigator.webdriver detection.** Flags visits controlled by automation tools. See the setup notes below.
5. **User agent detection.** Legacy OS filtering, manual OS filtering, Linux exclusion, and known bot signatures. See the dedicated section below.
6. **Missing page properties.** Flags visits where basic page information is empty. See the dedicated section below.
7. **Cookie support.** Keeps a bot label in place for the rest of the visit.

---

## Navigator.webdriver Detection

`navigator.webdriver` is a standard browser property that tells a page when the browser is being controlled by automation software. That makes it a reliable signal for catching automated visits.

To use it:

1. Go to **Variables** in Google Tag Manager.
2. Create a new **Custom JavaScript Variable** that returns `navigator.webdriver`.
3. Enable **Include navigator.webdriver Check in Bot Detection** in this template.
4. Select your new variable in the **Navigator.webdriver Variable (Optional)** field.

This check can occasionally flag real users who run browsers in automated or testing modes, so review your results after enabling it.

---

## Missing Page Properties (New)

Some bots load a page without a proper hostname, title, or URL. Real browsers almost always have all three. These options live in the **Exclude Bot Traffic Using Missing Page Properties** section of the template.

| Option | Marks the visit as bot traffic when... |
|---|---|
| **Mark Visits without Hostname/Domain as Bot Traffic** | The page hostname is empty, undefined, null, or "not set" |
| **Mark Visits without PageTitle as Bot Traffic** | The page title is empty, undefined, null, or "not set" |
| **Mark Visits without Page Url as Bot Traffic** | The page URL is empty, undefined, null, or "not set" |

Each option works independently, so you can enable only the ones you need.

**What counts as missing?** A value is treated as missing if it is empty, only spaces, `undefined`, `null`, `not set`, `(not set)`, or `(not provided)`. The comparison ignores upper and lower case.

**Things to keep in mind**

- These checks run early, before referral detection. A visit with a missing property is labeled as bot traffic even if its referrer is on your **Exclusion Referrals** list.
- Some real pages genuinely have no title, for example a bare redirect page or a file viewer. If your site has pages like that, think twice before enabling the title check, or you may label real visitors as bots.

---

## User Agent Filtering

User agent filtering works in a fixed order. Each stage is checked in turn, and the first stage that reaches a verdict decides the result.

To use it:

1. Go to **Variables** in Google Tag Manager.
2. Create a new **Custom JavaScript Variable** that returns `navigator.userAgent`.
3. Enable **Include User Agent in Bot Check** in this template.
4. Select your new variable in the **User Agent Variable (User Defined)** field.

### Processing Order

1. **Legacy operating system auto detection**
2. **Legacy OS exclusion overrides**
3. **Manual operating system version filtering**
4. **Exclude all Linux** (new)
5. **Known bot signature detection**
6. **Custom include and exclude bot overrides**

---

### Automatic Legacy OS Detection

Bots, crawlers, and spoofed agents often present themselves as very old operating systems. With **Automatically Filter Legacy Operating System Versions** enabled, the template labels those visits as bot traffic. Supported platforms are Windows, macOS, Linux, Android, and iOS. See the tables at the end of this document for the exact versions.

### Legacy OS Exclusion Overrides

If you have real users on an older system, for example old enterprise devices or internal tools, enable **Enable Exclusion of Certain Legacy OS Versions as Bot Traffic** and list those versions in the table. Overrides always win over automatic legacy detection.

### Manual OS Version Filtering

Enable **Manually Filter Traffic by Specified Operating System Versions** to add your own operating system versions that should be treated as bot traffic. This applies regardless of the automatic legacy detection.

### Exclude All Linux (New)

Enable **Automatically Classify and Exclude All Linux as Bot Traffic** to label desktop Linux visits as bot traffic.

- Visits are only labeled when the user agent contains "Linux" and does **not** contain "Android". Android phones and tablets include "Linux" in their user agent, so they are left alone.
- Think carefully before using this. Plenty of real people use desktop Linux, and some smart TVs and embedded devices also report Linux. Turn it on only if your audience is unlikely to include Linux users, or if you've seen clear bot patterns coming from Linux.

### Known Bot Signature Detection

With **Automatically Filter Traffic Using a Known Signature List** enabled, the template detects well-known crawlers and bots using a built-in list of user agent signatures. The list is based on one maintained by [Markus Baersch](https://www.linkedin.com/in/markusbaersch/).

You can also enable **Include or Exclude Bot Traffic Using Bot Signatures** to:

- Add your own bot signatures with **Want To Add More Bots? (Comma-Separated)**
- Allow specific bots, even if they are on the default list, with **Want To Exclude Any Bots? (Comma-Separated)**

---

## Cookie Support

- A cookie is set only when a visit is labeled `potential_bot_traffic`.
- It is useful when a bot's referrer or page details change after landing, so later pages still carry the bot label.
- Cookie name: `gtm_var_temp_label`
- Duration: 30 minutes
- Secure by default

While testing in Preview mode, clear this cookie between tests, or an earlier bot label will carry over.

---

## How to Use

1. Download the `template.tpl` file from this repository.
2. Import it into Google Tag Manager under **Templates**.
3. Create a new variable from the template and configure the options you need.
4. Check the result in Preview mode, then publish your container.

---

## Testing Your Setup

1. Open GTM Preview mode and load your site.
2. In the Variables tab, check that your Bot Traffic Identifier variable shows `potential_real_traffic` for a normal visit.
3. Try a test that should trigger an option you enabled. For example, test a Linux browser with the Linux option on, or a page with no title with the title check on.
4. Clear the `gtm_var_temp_label` cookie between tests.

---

## Troubleshooting

**Every visit is labeled as bot traffic**
Most likely a cookie from an earlier bot label, or an option that is too broad (for example the title check on a site with untitled pages, or the Linux option with Linux users). Clear the cookie and disable options one by one.

**The page URL, hostname, or title check never fires**
The template may not have permission to read that information. Check the template's Permissions tab: URL reading should allow all components, and document title reading should be present.

**Android visits are being flagged after enabling the Linux option**
They shouldn't be, since Android is excluded from that check. Look at the legacy OS options instead, which cover older Android versions up to Android 7.

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

### Linux (Legacy Distributions, 2010 or Earlier)

| Distribution | Version | Release Year |
|-------------|--------|--------------|
| Ubuntu | 7.10 – 9.10 | 2007–2009 |
| Debian | 3.1 – 5.0 | 2005–2009 |
| Fedora | 9 – 12 | 2008–2009 |
| openSUSE | 11.1 – 11.2 | 2008–2009 |
| Linux Mint | 7 | 2009 |
| CentOS | 5.4 | 2009 |
| Slackware | 13.0 | 2009 |

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

### iOS (Legacy)

| iOS Version | Release Year |
|------------|--------------|
| iOS 1 – 3 | 2007–2009 |
| iOS 4 | 2010 |
| iOS 5 | 2011 |
| iOS 6 | 2012 |
| iOS 7 | 2013 |

---

## Author

Created by **Jude Nwachukwu Onyejekwe**.

This template is part of the [Dumbdata.co Measurement Resource Hub](https://dumbdata.co), which provides resources designed to simplify measurement strategies and implementations.

For questions or support, reach out at [Dumbdata.co](https://dumbdata.co).
