sudo -u postgres createdb -O postgres halan

psql -d halan -c 'CREATE TABLE ips ( ip            varchar(80));'

