<?php
require_once('plugins/login-servers.php');
/** Set supported servers
        * @param array array($description => array("server" => , "driver" => "server|pgsql|sqlite|..."))
        */
return new AdminerLoginServers([
    "dev1" => ["server" => "192.168.1.10:5432", "driver" => "server"],
    "dev2" => ["server" => "192.168.1.20:5432", "driver" => "mysql"],
    "local" => ["server" => "defaultdb:3306", "driver" => "server"]                          
]);