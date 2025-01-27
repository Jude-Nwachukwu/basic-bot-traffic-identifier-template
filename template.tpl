___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Basic Bot Traffic Identifier",
  "description": "Labels potential bot traffic as \u0027potential_bot_visitor\u0027 and non-bot traffic as \u0027real_website_visitor.\u0027 By default, bot traffic detection is enabled. You can customize this with your own rules.",
  "containerContexts": [
    "WEB"
  ]
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
    "type": "CHECKBOX",
    "name": "useNavigatorWebDriver",
    "checkboxText": "Include navigator.webdriver Check in Bot Detection",
    "simpleValueType": true,
    "help": "Select this option to check the navigator.webdriver variable during bot detection."
  },
  {
    "type": "TEXT",
    "name": "userAgentVariable",
    "displayName": "User Agent Variable (Optional)",
    "simpleValueType": true,
    "help": "This optional field allows you to improve bot detection by utilizing the user agent information of specific known bots.",
    "valueHint": "Example: {{js - navigator.userAgent}}",
    "enablingConditions": [
      {
        "paramName": "useUserAgent",
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
        "paramName": "useUserAgent",
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
        "paramName": "useUserAgent",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
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

function matchesDomain(ref, domains) {
    if (typeof ref !== 'string') {
        return false;
    }
    return domains.some(function (domain) {
        if (typeof domain === 'string') {
            return ref.indexOf(domain) !== -1;
        }
        return false;
    });
}

function getDomainsFromString(input) {
    if (typeof input !== 'string') {
        return [];
    }
    return input.split(',').map(function (domain) {
        return domain.trim();
    }).filter(function (domain) {
        return domain.length > 0;
    });
}

// Default bot domain list
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
    'video–production.com', 'www.Get-Free-Traffic-Now.com', 'buttons-for-website.com',
    'qualitymarketzone.com', 'site5.free-floating-buttons.co', 'videos-for-your-business.com',
    'how-to-earn-quick-money.com', 'forum.topic63020490.darodar.com', '7makemoneyonline.com',
    'acads.net', 'anal-acrobats.hol.es', 'gtm-msr.appspot.com'
];

// Cookie name and settings
const cookieName = 'gtm_var_temp_label';
const cookieOptions = {
    domain: 'auto',
    path: '/',
    'max-age': 1800, // 30 minutes
    secure: true
};

// Check if the cookie is already set to "potential_bot_traffic"
if (queryPermission('get_cookies', cookieName)) {
    const cookieValues = getCookieValues(cookieName);
    if (cookieValues && cookieValues.indexOf('potential_bot_traffic') !== -1) {
        return 'potential_bot_traffic';
    }
}

// Check for excludeAppspotDomain
if (data.excludeAppspotDomain === true && queryPermission('get_url', 'host')) {
    const pageHost = getUrl('host');
    if (typeof pageHost === 'string' && pageHost.indexOf('.appspot.com') !== -1) {
        if (queryPermission('set_cookies', cookieName, cookieOptions)) {
            setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
        }
        return 'potential_bot_traffic';
    }
}

// Read fields from the template
const inclusionPatterns = getDomainsFromString(data.inclusionReferralPatterns);
const exclusionPatterns = getDomainsFromString(data.exclusionReferralPatterns);
const customBotsExclusion = getDomainsFromString(data.exclusionUserAgentBot);

// Referral-based detection
let referrer = '';
if (queryPermission('get_referrer', 'host')) {
    referrer = getReferrerUrl('host');
}

if (matchesDomain(referrer, exclusionPatterns)) {
    return 'potential_real_traffic';
}

if (matchesDomain(referrer, defaultBotDomains) || matchesDomain(referrer, inclusionPatterns)) {
    if (queryPermission('set_cookies', cookieName, cookieOptions)) {
        setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
    }
    return 'potential_bot_traffic';
}

// User-Agent Bot detection
if (data.useUserAgent === true && typeof data.userAgentVariable === 'string') {
    const userAgent = data.userAgentVariable.toString().toLowerCase();
    const predefinedBots = [
        'googlebot', 'bingbot', 'slurp', 'duckduckbot', 'baiduspider',
        'yandexbot', 'applebot', 'petalbot', 'semrushbot', 'majestic',
        'dotbot', 'ahrefsbot'
    ];
    const customBotsInclusion = getDomainsFromString(data.inclusionUserAgentBot);
    const allBotsInclusion = predefinedBots.concat(customBotsInclusion).map(function (bot) {
        return bot.toLowerCase();
    });

    if (customBotsExclusion.some(function (bot) {
        return userAgent.indexOf(bot.toLowerCase()) !== -1;
    })) {
        return 'potential_real_traffic';
    }

    if (allBotsInclusion.some(function (bot) {
        return userAgent.indexOf(bot) !== -1;
    })) {
        if (queryPermission('set_cookies', cookieName, cookieOptions)) {
            setCookie(cookieName, 'potential_bot_traffic', cookieOptions);
        }
        return 'potential_bot_traffic';
    }
}

// Navigator.webdriver check
if (data.useNavigatorWebDriver === true && typeof data.userNavigatorWebDriver === 'string') {
    if (data.userNavigatorWebDriver.toLowerCase() === 'true') {
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


