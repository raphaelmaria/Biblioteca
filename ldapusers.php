<?php

function cmp($a, $b) {
    $a = strtolower($a['name']);
    $b = strtolower($b['name']);
    if ($a == $b) {
        return 0;
    }
    return ($a < $b) ? -1 : 1;
}


function html_table_row($a) {
    return "<tr><td>".$a['name']."</td><td>".$a['ldap']."</td></tr>";
}


$ldap_conn = ldap_connect("ldap://192.168.8.9");
if ($ldap_conn) {
    ldap_set_option($ldap_conn, LDAP_OPT_PROTOCOL_VERSION, 3);
    $bind_id = ldap_bind($ldap_conn);
    $group_search = @ldap_search($ldap_conn, "dc=o2pos,dc=com", "(ou=people)", array("cn"));
    if (FALSE === $group_search) {
        die('search error\n');
    }
    $group_entries = ldap_get_entries($ldap_conn, $group_search);
    $user_data = array();
    foreach ($group_entries as $group_info) {

        $user_search = @ldap_search($ldap_conn, $group_info['dn'], "(cn=*)", array("cn"));
        if (FALSE === $user_search) {
            continue;
        }
        $user_entries = ldap_get_entries($ldap_conn, $user_search);

        foreach ($user_entries as $user_info) {
            if($user_info['dn'] != '') {
                $user_data[] = array('name' => $user_info['cn'][0], 'ldap' => $user_info['dn']);
            }
        }
    }
    ldap_close($ldap_conn);

    uasort($user_data,'cmp');
    $table_data = array_map ( 'html_table_row' , $user_data);
    echo "<html>";
    echo "<table>";
    echo "<tr><th>Nome</th><th>ldap id</th></tr>";
    echo(join('',$table_data));
    echo "</table>";
}
else {
    die('cannot connect to ldap');
}
?>