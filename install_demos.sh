#!/bin/bash
DB_CONTAINER=$(docker-compose ps -q db | head -1)
LIZMAP_CONTAINER=$(docker-compose ps -q lizmap | head -1)

cp demo_data/qgis2015.qgs* projects/
docker cp demo_data/qgis2015.sql $DB_CONTAINER:/tmp/
docker cp demo_data/load_sql.sh $DB_CONTAINER:/tmp/
docker exec $DB_CONTAINER chmod +x /tmp/load_sql.sh
docker exec $DB_CONTAINER /tmp/load_sql.sh

# todo add repository
