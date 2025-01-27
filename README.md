# Basic Bot Traffic Identifier Template

## Overview

The **Basic Bot Traffic Identifier** is a Google Tag Manager custom variable template designed to help you classify traffic as either **potential_bot_traffic** or **potential_real_traffic**. Without any customization, this variable automatically checks if the traffic referrer matches any of the known system-defined bot referral patterns.

This template allows you to enhance your bot detection strategy while providing flexible options for customization to suit your specific needs.

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
   - Automatically detects traffic based on known bot and crawler user-agent strings.
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
