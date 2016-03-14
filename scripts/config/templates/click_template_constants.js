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
define("FIREBASELOGSURL", "https://decidzlogarchive.firebaseio.com/");
define("LOGSAUTHCODE", "7DGMu45TV5OMp3SgGsVRphSaF9eSW5ZC500fi1Zf");

define("SEGMENT_API_KEY", "tbc_segment_api_key");

define("ORIENT_HOST", "tbc_orient_host");
define("ORIENT_PORT", "tbc_orient_port");
define("ORIENT_USERNAME", "tbc_orient_username");
define("ORIENT_PASSWORD", "tbc_orient_password");
define("ORIENT_DB", "tbc_orient_db");

define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");

define('TWILIO_SID', 'tbc_twilio_sid');
define('TWILIO_TOKEN', 'tbc_twilio_token');

define('AUTH0_API_TOKEN', 'tbc_auth0_api_token');
define('AUTH0_API_URL', 'https://decidzint.auth0.com/api/v2');

define('MAILGUN_API_KEY', 'key-35e33a9b2f64a0ef3beef573bca3ea36');


