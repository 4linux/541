    echo "CREATE DATABASE IF NOT EXISTS php CHARACTER SET utf8 COLLATE utf8_bin;" | mysql --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD

    echo "GRANT ALL PRIVILEGES ON php.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD

    echo "GRANT ALL PRIVILEGES ON php.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql --host=localhost --user=root --password=$MYSQL_ROOT_PASSWORD

    mysql --host=localhost --user=$MYSQL_USER --password=$MYSQL_PASSWORD < /dump/dump.sql
