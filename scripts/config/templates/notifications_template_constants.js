function define(name, value) {
    Object.defineProperty(exports, name, {
        value:      value,
        enumerable: true
    });
}

define("FIREBASEURL", "tbc_firebase_url");
define("AUTHCODE", "tbc_firebase_authcode");
define("OSI_REST_KEY", "tbc_osi_rest_key");
define("OSI_APP_ID", "tbc_osi_app_id");
define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");
