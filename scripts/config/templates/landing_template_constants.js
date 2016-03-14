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

define("MONGO_HOST", "tbc_mongo_host");
define("MONGO_PORT", "tbc_mongo_port");
define("MONGO_DATABASE", "tbc_mongo_db");
define("MONGO_COLLECTION", "tbc_mongo_tablename");

define("LOGGLYDOMAIN", "tbc_logglydomain");
define("LOGGLYTOKEN", "tbc_logglytoken");
define("LOGGLYENVIRONMENT", "tbc_logglyenvironment");
