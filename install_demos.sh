#!/bin/bash
# todo make dynamic
DB_CONTAINER=dockerlizmappostgis_db_1

cp demo_data/qgis2015.qgs* projects/
docker cp demo_data/qgis2015.sql $DB_CONTAINER:/tmp/
docker cp demo_data/load_sql.sh $DB_CONTAINER:/tmp/
docker exec $DB_CONTAINER chmod +x /tmp/load_sql.sh
docker exec $DB_CONTAINER /tmp/load_sql.sh

# todo add repository
