#!/bin/bash

for i in {1..50};
do
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -C -i /usr/src/setup/restore.sql
    if [ $? -eq 0 ]
    then
        echo "setup completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done