function define(name, value) {
    Object.defineProperty(exports, name, {
        value:      value,
        enumerable: true
    });
}

define("FIREBASEURL", "tbc_firebase_url");
define("AUTHCODE", "tbc_firebase_authcode");
define("DECIDZURL", "tbc_decidz_app_root");
define("COOKIEDOMAIN", "tbc_cookie_domain_name");
define("DECIDZAPI", "tbc_decidz_apirooturl");
define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");
define("DCZIO_SHORTURLDOMAIN", "tbc_shorturldomain");
