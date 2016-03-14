/*jslint node: true */
'use strict';

function define(name, value) {
    Object.defineProperty(exports, name, {
        value:      value,
        enumerable: true
    });
}

define("DECIDZURL", "tbc_decidz_app_root");
define("DECIDZ_DOMAIN", "tbc_decidz_websiterooturl");
define("DECIDZ_API_DOMAIN", "tbc_decidz_apirooturl");
define("COOKIEDOMAIN", "tbc_cookie_domain_name");
define("PORT", "tbc_node_listen_port");

define("FIREBASEURL", "tbc_firebase_url");
define("AUTHCODE", "tbc_firebase_authcode");

define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");

