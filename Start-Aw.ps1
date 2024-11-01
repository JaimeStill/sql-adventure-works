docker run --rm -t --init `
      -p 1433:1433 `
      --name sql-server-aw `
      --hostname sql-server-aw `
      -e "ACCEPT_EULA=Y" `
      -e "MSSQL_SA_PASSWORD=Password1234" `
      sql-server-aw