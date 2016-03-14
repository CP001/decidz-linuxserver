function define(name, value) {
    Object.defineProperty(exports, name, {
        value:      value,
        enumerable: true
    });
}

define("DECIDZURL", "tbc_decidz_app_root");
define("DECIDZ_DOMAIN", "tbc_decidz_websiterooturl");

define("FIREBASEURL", "tbc_firebase_url");
define("AUTHCODE", "tbc_firebase_authcode");

define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");

define("GOOGLEAPIKEY", "tbc_googleapikey");
