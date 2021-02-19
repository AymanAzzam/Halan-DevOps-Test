sudo -u postgres createdb -O postgres halan

sudo -u postgres psql -d halan -c 'CREATE TABLE ips ( ip            varchar(80));'

