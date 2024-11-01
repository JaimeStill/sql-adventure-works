FROM mcr.microsoft.com/mssql/server:2022-latest

USER root
WORKDIR /usr/src
COPY . .

RUN chmod +x ./setup/import-data.sh
RUN mkdir -p /var/opt/mssql/backups

RUN apt -y update && apt install -y curl
RUN curl -L -o /var/opt/mssql/backups/AdventureWorks.bak 'https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak'

USER mssql
ENTRYPOINT ["/bin/bash", "./setup/entrypoint.sh"]