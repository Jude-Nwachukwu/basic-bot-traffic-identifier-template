___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_MQRMR",
  "version": 1,
  "displayName": "Basic Bot Traffic Identifier",
  "categories": [
    "UTILITY"
  ],
  "description": "Labels potential bot traffic as \u0027potential_bot_visitor\u0027 and non-bot traffic as \u0027real_website_visitor.\u0027 By default, bot traffic detection is enabled. You can customize this with your own rules.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "inclusionReferralPatterns",
    "displayName": "Inclusion Referrals (Comma-Separated)",
    "simpleValueType": true,
    "help": "Specify referral patterns to include as bot traffic. Use commas to separate multiple entries.",
    "valueHint": "Leave blank or xyz.com,abc.com"
  },
  {
    "type": "TEXT",
    "name": "exclusionReferralPatterns",
    "displayName": "Exclusion Referrals (Comma-Separated)",
    "simpleValueType": true,
    "help": "Specify referral patterns to exclude from being labeled as bot traffic. Use commas to separate multiple entries.",
    "valueHint": "Leave blank or xyz.com,ijk.com"
  },
  {
    "type": "CHECKBOX",
    "name": "useUserAgent",
    "checkboxText": "Include User Agent in Bot Check",
    "simpleValueType": true,
    "help": "Select this option to include the user agent in the bot detection."
  },
  {
    "type": "GROUP",
    "name": "userAgentConfig",
    "displayName": "User Agent Bot Filtering Configuration",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "userAgentVariable",
        "displayName": "User Agent Variable (User Defined)",
        "simpleValueType": true,
        "help": "This optional field allows you to improve bot detection by utilizing the user agent information of specific known bots.\n\u003cbr\u003e\u003cbr\u003e\nTo define a variable that stores user agent information, create a JavaScript variable and assign it \u003cstrong\u003enavigator.userAgent\u003c/strong\u003e",
        "valueHint": "Example: {{js - navigator.userAgent}}",
        "enablingConditions": [
          {
            "paramName": "useUserAgent",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "userAgentExcludeLegacyOSVersions",
        "checkboxText": "Automatically Filter Legacy Operating System Versions",
        "simpleValueType": true,
        "help": "Automatically filter and label website traffic originating from outdated operating system versions, such as Windows 7, Windows XP, Windows Vista, Android 1.6, etc, as bot traffic. \u003cstrong\u003e\u003ca href\u003d\"https://github.com/Jude-Nwachukwu/basic-bot-traffic-identifier-template?tab\u003dreadme-ov-file#supported-legacy-operating-systems\"\u003eSee list here\u003c/a\u003e\u003c/strong\u003e"
      },
      {
        "type": "CHECKBOX",
        "name": "UserAgentListLegacyOverride",
        "checkboxText": "Enable Exclusion of Certain Legacy OS Versions as Bot Traffic.",
        "simpleValueType": true,
        "help": "Check this box if you do not want specific operating systems, which may be included in our list of legacy OS versions, to be automatically labeled as bot traffic.  \u003cbr\u003e\u003cbr\u003eIt is recommended to review the \u003cstrong\u003e\u003ca href\u003d\"https://github.com/Jude-Nwachukwu/basic-bot-traffic-identifier-template?tab\u003dreadme-ov-file#supported-legacy-operating-systems\"\u003etable here for more details.\u003c/a\u003e\u003c/strong\u003e",
        "enablingConditions": [
          {
            "paramName": "userAgentExcludeLegacyOSVersions",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "UserAgentListLegacyOverrideValues",
        "displayName": "Manually Add Legacy OS Versions to Exclude from Legacy List",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Enter Legacy OS Version to Exclude",
            "name": "UserAgentListLegacyOverrideValuesColumn",
            "type": "TEXT",
            "isUnique": true,
            "valueHint": "Example Windows NT 6.1",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "help": "Click here to add a new entry for each legacy operating system (OS) version that should be excluded from the list of OS versions automatically labeled as bot traffic.",
        "enablingConditions": [
          {
            "paramName": "UserAgentListLegacyOverride",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "newRowButtonText": "Add New Legacy OS to Exclude"
      },
      {
        "type": "CHECKBOX",
        "name": "userAgentCustomOSVersionFilter",
        "checkboxText": "Manually Filter Traffic by Specified Operating System Versions",
        "simpleValueType": true,
        "help": "Enable this option if you want to label website traffic from specific operating system versions of your choice as bot traffic and exclude it from your website."
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "userAgentOSversionExcludeTable",
        "displayName": "Enter Each Operating Version In Each Row",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Operating System Version",
            "name": "userAgentOSVersionExcludeColumn",
            "type": "TEXT",
            "isUnique": true,
            "valueHint": "Example Windows 6.1",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "userAgentCustomOSVersionFilter",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "userAgentUseAutoSignatureList",
        "checkboxText": "Automatically Filter Traffic Using a Known Signature List",
        "simpleValueType": true,
        "help": "Enable this checkbox, and the template will automatically detect and filter known bots based on an existing bot signature list.  \u003cbr\u003e\u003cbr\u003eYou can then use the settings below to further customize and refine your bot traffic filtering configuration."
      },
      {
        "type": "LABEL",
        "name": "userAgentLabelInfo",
        "displayName": "🤖 With this setting enabled, the template now automatically identify and filter known bots using a pre-existing bot signature list.\n\nEnable the settings below to further customize and refine your bot traffic filtering configuration.\u003cbr\u003e\u003cbr\u003e",
        "enablingConditions": [
          {
            "paramName": "userAgentUseAutoSignatureList",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "userAgentIncludeExclude",
        "checkboxText": "Include or Exclude Bot Traffic Using Bot Signatures",
        "simpleValueType": true,
        "help": "Enable this option to configure which bot traffic you want to include or exclude based on known bot signatures. Please note that the system already identifies and filters known bots using an existing bot signature list that it checks automatically. Use this feature to add new bot signatures or to allow specific bots that you do not want to be filtered out, even if they appear on the existing list.",
        "enablingConditions": [
          {
            "paramName": "userAgentUseAutoSignatureList",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "inclusionUserAgentBot",
        "displayName": "Want To Add More Bots? (Comma-Separated)",
        "simpleValueType": true,
        "help": "Specify bots you want to include as bot traffic to the already list this template can identify. Use commas to separate multiple entries.",
        "valueHint": "Leave blank or abcbot,ybot",
        "enablingConditions": [
          {
            "paramName": "userAgentIncludeExclude",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "exclusionUserAgentBot",
        "displayName": "Want To Exclude Any Bots? (Comma-Separated)",
        "simpleValueType": true,
        "help": "Specify bots you want to exclude as bot traffic to the already list this template can identify. Use commas to separate multiple entries.",
        "valueHint": "Leave blank or abcbot,ybot",
        "enablingConditions": [
          {
            "paramName": "userAgentIncludeExclude",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "useUserAgent",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "useNavigatorWebDriver",
    "checkboxText": "Include navigator.webdriver Check in Bot Detection",
    "simpleValueType": true,
    "help": "Select this option to check the navigator.webdriver variable during bot detection.\n\u003cbr\u003e\u003cbr\u003e\n🛑 Note that it may also exclude non-bot traffic, as its purpose is to filter out automated visits to the website."
  },
  {
    "type": "TEXT",
    "name": "userNavigatorWebDriver",
    "displayName": "Navigator.webdriver Variable (Optional)",
    "simpleValueType": true,
    "help": "Optionally specify a navigator.webdriver variable to improve bot detection.",
    "valueHint": "Example: {{js - navigator.webdriver}}",
    "enablingConditions": [
      {
        "paramName": "useNavigatorWebDriver",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "excludeAppspotDomain",
    "checkboxText": "Mark .appspot.com Visits As Bot Traffic",
    "simpleValueType": true,
    "help": "Enable this option to classify visits originating from appspot.com domains (e.g., gtm-msr.appspot.com) as \"potential_bot_traffic\""
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const queryPermission = require('queryPermission');
const getReferrerUrl = require('getReferrerUrl');
const getUrl = require('getUrl');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const getType = require('getType');

function matchesDomain(ref, domains) {
    if (getType(ref) !== 'string') return false;
    return domains.some(function (domain) {
        return typeof domain === 'string' && ref.indexOf(domain) !== -1;
    });
}

function getDomainsFromString(input) {
    if (getType(input) !== 'string') return [];
    return input.split(',')
        .map(function (v) { return v.trim(); })
        .filter(function (v) { return v.length > 0; });
}

function getTableValues(table, key) {
    if (!table || !table.length) return [];
    return table
        .map(function (row) { return row[key]; })
        .filter(function (v) { return getType(v) === 'string' && v.length > 0; })
        .map(function (v) { return v.toLowerCase(); });
}

/* ------------------ Default Bot Domains ------------------ */
const defaultBotDomains = [
    'news.grets.store', 'info.seders.website', 'kar.razas.site', 'game.fertuk.site',
    'ofer.bartikus.site', 'garold.dertus.site', 'trast.mantero.online', 'static.seders.website',
    'a.steambeard.top', 'a.tronehammer.top', 'trast.manetero.online', 'rida.tokyo',
    'games.patlik.site', 'info.sederes.website', 'trafficpeak.io', 'blogtrafficeasily.shop',
    'erias.xyz', 'sestarblog.shop', 'hiwpro.xyz', 'jackonline.store', 'xtrafficpluss.xyz',
    'xtraffic.plus', 'traffic2money.com', 'floating-share-buttons.com', 'get-free-social-traffic.com',
    'site4.free-floating-buttons.com', '4webmasters.org', 'site10.free-floating-buttons.com',
    'free-social-buttons.com', 'site3.free-floating-buttons.com', 'www.event-tracking.com',
    'success-seo.com', 'seo-platform.com', 'site2.free-floating-buttons.com', 'chinese-amezon.com',
    'hongfanji.com', 'site8.free-floating-buttons.com', 'site9.free-floating-buttons.com',
    'video–production.com', 'www.get-free-traffic-now.com', 'buttons-for-website.com',
    'qualitymarketzone.com', 'site5.free-floating-buttons.co', 'videos-for-your-business.com',
    'how-to-earn-quick-money.com', 'forum.topic63020490.darodar.com', '7makemoneyonline.com',
    'acads.net', 'anal-acrobats.hol.es', 'gtm-msr.appspot.com'
];

/* ------------------ Cookie Setup ------------------ */
const cookieName = 'gtm_var_temp_label';
const cookieOptions = {
    domain: 'auto',
    path: '/',
    'max-age': 1800,
    secure: true
};

/* ------------------ Existing Cookie Check ------------------ */
if (queryPermission('get_cookies', cookieName)) {
    const cookieValues = getCookieValues(cookieName);
    if (cookieValues && cookieValues.indexOf('potential_bot_traffic') !== -1) {
        return 'potential_bot_traffic';
    }
}

/* ------------------ Appspot Domain ------------------ */
if (data.excludeAppspotDomain === true && queryPermission('get_url', 'host')) {
    const host = getUrl('host');
    if (getType(host) === 'string' && host.indexOf('.appspot.com') !== -1) {
        if (queryPermission('set_cookies', cookieName, cookieOptions)) {
            setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
        }
        return 'potential_bot_traffic';
    }
}

/* ------------------ Referral Detection ------------------ */
const inclusionPatterns = getDomainsFromString(data.inclusionReferralPatterns);
const exclusionPatterns = getDomainsFromString(data.exclusionReferralPatterns);

let referrer = '';
if (queryPermission('get_referrer', 'host')) {
    referrer = getReferrerUrl('host');
}

if (matchesDomain(referrer, exclusionPatterns)) {
    return 'potential_real_traffic';
}

if (
    matchesDomain(referrer, defaultBotDomains) ||
    matchesDomain(referrer, inclusionPatterns)
) {
    if (queryPermission('set_cookies', cookieName, cookieOptions)) {
        setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
    }
    return 'potential_bot_traffic';
}

/* ------------------ User Agent Logic ------------------ */
if (data.useUserAgent === true && getType(data.userAgentVariable) === 'string') {
    const userAgent = data.userAgentVariable.toLowerCase();

    /* -------- Legacy OS Auto Detection -------- */
    if (data.userAgentExcludeLegacyOSVersions === true) {

        const legacyOSSignatures = [
            // Windows
            'windows nt 6.1', 'windows nt 6.0', 'windows nt 5.2',
            'windows nt 5.1', 'windows nt 5.0', 'windows nt 4.0',
            'windows 3.', 'windows 2.', 'windows 1.',

            // Android
            'android 1.', 'android 2.', 'android 3.',
            'android 4.', 'android 5.', 'android 6.', 'android 7.',

            // Linux
            'ubuntu/9.10', 'ubuntu/8.10', 'ubuntu/8.04', 'ubuntu/7.10',
            'debian/5.0', 'debian/4.0', 'debian/3.1',
            'fedora/12', 'fedora/10', 'fedora/9',
            'opensuse/11.2', 'opensuse/11.1',
            'linux mint/7', 'centos/5.4', 'slackware/13.0'
        ];

        /* ---- iOS Legacy (Explicit Major Versions Only) ---- */
        const isLegacyIOS = (
            userAgent.indexOf('iphone os 1_') !== -1 ||
            userAgent.indexOf('iphone os 2_') !== -1 ||
            userAgent.indexOf('iphone os 3_') !== -1 ||
            userAgent.indexOf('iphone os 4_') !== -1 ||
            userAgent.indexOf('iphone os 5_') !== -1 ||
            userAgent.indexOf('iphone os 6_') !== -1 ||
            userAgent.indexOf('iphone os 7_') !== -1
        );


        const legacyOverrideList = (data.UserAgentListLegacyOverride === true)
            ? getTableValues(
                data.UserAgentListLegacyOverrideValues,
                'UserAgentListLegacyOverrideValuesColumn'
              )
            : [];

        const matchedLegacyOS =
            legacyOSSignatures.some(function (sig) {
                return userAgent.indexOf(sig) !== -1;
            }) ||
            isLegacyIOS;

        if (matchedLegacyOS === true) {

            /* ---- Legacy Override Wins ---- */
            if (legacyOverrideList.some(function (overrideOS) {
                return userAgent.indexOf(overrideOS) !== -1;
            })) {
                return 'potential_real_traffic';
            }

            if (queryPermission('set_cookies', cookieName, cookieOptions)) {
                setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
            }
            return 'potential_bot_traffic';
        }
    }

    /* -------- Custom OS Version Table -------- */
    if (data.userAgentCustomOSVersionFilter === true) {
        const customOSVersions = getTableValues(
            data.userAgentOSversionExcludeTable,
            'userAgentOSVersionExcludeColumn'
        );

        if (customOSVersions.some(function (v) {
            return userAgent.indexOf(v) !== -1;
        })) {
            if (queryPermission('set_cookies', cookieName, cookieOptions)) {
                setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
            }
            return 'potential_bot_traffic';
        }
    }

    /* -------- Bot Signature Auto Detection (Default) -------- */
    if (data.userAgentUseAutoSignatureList === true) {

        const predefinedBots = [
            'googlebot', 'adsbot-google', 'mediapartners-google', 'google search console',
            'chrome-lighthouse', 'duckduckbot', 'jobboersebot', 'woobot', 'pingdompagespeed',
            'pagepeeker', 'refindbot', 'hubspot', 'yandex', 'investment crawler', 'bingpreview',
            'bingbot', 'adidxbot', 'microsoftpreview', 'baiduspider', 'sogou', 'sistrix',
            'facebookexternalhit', 'site-shot', 'wkhtmltoimage', 'smtbot', 'petalbot', 'ahrefsbot',
            'avalex', 'rytebot', 'semrushbot', 'cookiebot', 'seekport crawler', 'cocolyzebot',
            'veoozbot', 'yisouspider', 'elisabot', 'ev-crawler', 'screeenly-bot', 'cincraw',
            'applebot', 'headline.com', 'seekportbot', 'bitsightbot', 'brightedge',
            'google-inspectiontool', 'pumoxbot', 'intl-ui-bot', 'slurp', 'yandexbot', 'majestic',
            'dotbot', 'gptbot'
        ];

        const inclusionBots = (data.userAgentIncludeExclude === true)
            ? getDomainsFromString(data.inclusionUserAgentBot)
            : [];

        const exclusionBots = (data.userAgentIncludeExclude === true)
            ? getDomainsFromString(data.exclusionUserAgentBot)
            : [];

        if (exclusionBots.some(function (bot) {
            return userAgent.indexOf(bot.toLowerCase()) !== -1;
        })) {
            return 'potential_real_traffic';
        }

        const allBots = predefinedBots
            .concat(inclusionBots)
            .map(function (b) { return b.toLowerCase(); });

        if (allBots.some(function (bot) {
            return userAgent.indexOf(bot) !== -1;
        })) {
            if (queryPermission('set_cookies', cookieName, cookieOptions)) {
                setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
            }
            return 'potential_bot_traffic';
        }
    }
}

/* ------------------ navigator.webdriver ------------------ */
if (data.useNavigatorWebDriver === true) {

    const webdriverValue = data.userNavigatorWebDriver;

    if (
        webdriverValue === true ||
        (getType(webdriverValue) === 'string' &&
         webdriverValue.toLowerCase() === 'true')
    ) {
        if (queryPermission('set_cookies', cookieName, cookieOptions)) {
            setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
        }
        return 'potential_bot_traffic';
    }
}

return 'potential_real_traffic';


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm_var_temp_label"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtm_var_temp_label"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "host",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 1/27/2025, 10:31:14 AM


