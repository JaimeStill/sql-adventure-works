# Notes

## Commands

Build Docker image

```sh
docker build -t {image-name} .
```

Run Docker container

```sh
docker run --rm -t \
      -p 1433:1433 \
      --name {container-name} \
      --hostname {container-name} \
      -e "ACCEPT_EULA=Y" \
      -e "MSSQL_SA_PASSWORD={sa-password}" \
      {image-name}
```

Execute command in Docker container

```sh
docker exec -it {container-name} {command}



# example
docker exec -it localsql mkdir /usr/src/setup
```

Copy file from host to Docker container

```sh
docker cp {file} {container-name}:{path}

# example
docker cp restore.sql localsql:/usr/src/setup
```

Connect to Docker container

```sh
docker exec -it {container-name} bash
```

Connect to Docker container as root

```sh
docker exec -it --user root {container-name} bash
```

Get file list from SQL backup

```sh
/opt/mssql-tools18/bin/sqlcmd \
    -S localhost \
    -U sa \
    -P $MSSQL_SA_PASSWORD \
    -C \
    -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backups/{file}.bak"'
```

Restore SQL database

> [!NOTE]
> Using the [AdventureWorks](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak) database as an example

```sh
/opt/mssql-tools18/bin/sqlcmd \
    -S localhost \
    -U sa \
    -P $MSSQL_SA_PASSWORD \
    -C \
    -Q 'RESTORE DATABASE AdventureWorks FROM DISK = "/var/opt/mssql/backups/AdventureWorks.bak" WITH MOVE "AdventureWorks2022" TO "/var/opt/mssql/data/AdventureWorks2022.mdf", MOVE "AdventureWorks2022_log" TO "/var/opt/mssql/data/AdventureWorks2022_log.ldf"'
```

For readability, **`-Q`** query above is:

```sql
RESTORE DATABASE AdventureWorks
FROM DISK = "/var/opt/mssql/backups/AdventureWorks.bak"
WITH
MOVE "AdventureWorks2022"
TO "/var/opt/mssql/data/AdventureWorks2022.mdf"
MOVE "AdventureWorks2022_log"
TO "/var/opt/mssql/data/AdventureWorks2022_log.ldf"
```

## Databases

* [Wide World Importers](https://github.com/microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak)
* [AdventureWorks](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak)

## References

* [Configure and Customize SQL Server Linux Containers](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-linux-ver16&vpivots=cs1-bash&pivots=cs1-bash)
* [MSSQL Node Docker Demo App](https://github.com/twright-msft/mssql-node-docker-demo-app)
* [Use sqlcmd](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-use-utility?view=sql-server-ver16)
* [Multi Service Container - Use Bash job controls](https://docs.docker.com/engine/containers/multi-service_container/#use-bash-job-controls)
* [How to Install SQL Server and the Stack Overflow Database on a Mac](https://www.brentozar.com/archive/2023/01/how-to-install-sql-server-and-the-stack-overflow-database-on-a-mac/)