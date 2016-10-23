#!/bin/bash

set -e
DB_CONTAINER=$(docker-compose ps -q db | head -1)
LIZMAP_CONTAINER=$(docker-compose ps -q lizmap | head -1)

cp demo_data/qgis2015.qgs* projects/
docker cp demo_data/qgis2015.sql $DB_CONTAINER:/tmp/
docker cp demo_data/load_sql.sh $DB_CONTAINER:/tmp/
docker exec $DB_CONTAINER chmod +x /tmp/load_sql.sh
docker exec $DB_CONTAINER /tmp/load_sql.sh

# Add repository
LIZMAP_CONFIG=lizmap_var/config/lizmapConfig.ini.php
echo "[repository:demo]" | sudo tee -a $LIZMAP_CONFIG
echo "label=demo" | sudo tee -a $LIZMAP_CONFIG
echo "path="/home/"" | sudo tee -a $LIZMAP_CONFIG
echo "allowUserDefinedThemes=1" | sudo tee -a $LIZMAP_CONFIG

docker cp demo_data/load_permissions.sql $LIZMAP_CONTAINER:/tmp/
# FIXME $LIZMAP_CONTAINER has no internet.
# docker cp demo_data/load_permissions.sql $DB_CONTAINER:/tmp/
#docker exec -it $LIZMAP_CONTAINER bash -c "apt-get -y install sqlite3"
#docker exec -it $LIZMAP_CONTAINER bash -c "cat /tmp/load_permissions.sql | sqlite3 /var/www/websig/lizmap/var/db/jauth.db"
# remove when above is fixed
sudo cat demo_data/load_permissions.sql | sudo sqlite3 lizmap_var/db/jauth.db
