function define(name, value) {
    Object.defineProperty(exports, name, {
        value:      value,
        enumerable: true
    });
}

define("FIREBASEURL", "tbc_firebase_url");
define("AUTHCODE", "tbc_firebase_authcode");

define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");

// Production
// define("OSI_REST_KEY", "Zjc2NzQ0MWUtNTZlNy0xMWU1LWFhZjMtNmJkODE5NTA1MWQy");
// define("OSI_APP_ID", "f7674388-56e7-11e5-aaf2-33cae765efd6");
