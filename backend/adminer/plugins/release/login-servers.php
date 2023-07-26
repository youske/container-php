<?php
require_once('plugins/login-servers.php');
/** Set supported servers
        * @param array array($description => array("server" => , "driver" => "server|pgsql|sqlite|..."))
        */
return new AdminerLoginServers([
    "master-1" => ["server" => "db-master-1.meteo-prod.local:3306", "driver" => "mysql"],
    "user-1" => ["server" => "db-log-1.meteo-prod.local:3306", "driver" => "mysql"],
    "user-2" => ["server" => "db-user-1.meteo-prod.local:3306", "driver" => "server"],
    "log-1" => ["server" => "db-user-2.meteo-prod.local:3306", "driver" => "server"],
    "local" => ["server" => "defaultdb:3306", "driver" => "server"]
]);
