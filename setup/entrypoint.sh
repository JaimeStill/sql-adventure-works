#!/bin/bash
set -m

/opt/mssql/bin/sqlservr &

/usr/src/setup/import-data.sh

fg %1