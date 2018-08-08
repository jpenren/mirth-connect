#!/bin/sh

trap "echo Shutting down" SIGTERM

# From mirth.properties:
# options: derby, mysql, postgres, oracle, sqlserver
# database = derby
# examples:
#	Derby		jdbc:derby:\$\{dir.appdata\}/mirthdb;create=true
#	PostgreSQL	jdbc:postgresql://localhost:5432/mirthdb
# 	MySQL		jdbc:mysql://localhost:3306/mirthdb
#	Oracle		jdbc:oracle:thin:@localhost:1521:DB
#	SQLServer	jdbc:jtds:sqlserver://localhost:1433/mirthdb
# database.url = jdbc:derby:${dir.appdata}/mirthdb;create=true

sed -i 's/database =.*/database = '"${DATABASE_ENGINE:=derby}"'/g' conf/mirth.properties
sed -i 's#database.url =.*#database.url = '"${DATABASE_URL:=jdbc:derby:\$\{dir.appdata\}/mirthdb;create=true}"'#g' conf/mirth.properties
sed -i 's/database.username =.*/database.username = '"$DATABASE_USERNAME"'/g' conf/mirth.properties
sed -i 's/database.password =.*/database.password = '"$DATABASE_PASSWORD"'/g' conf/mirth.properties
sed -i 's/http.port =.*/http.port='"${HTTP_PORT:=8080}"'/g' conf/mirth.properties
sed -i 's/https.port =.*/https.port='"${HTTPS_PORT:=8443}"'/g' conf/mirth.properties

exec "$@"