#!/bin/bash
DB_CONTAINER=$(docker-compose ps -q db | head -1)
LIZMAP_CONTAINER=$(docker-compose ps -q lizmap | head -1)

cp demo_data/qgis2015.qgs* projects/
docker cp demo_data/qgis2015.sql $DB_CONTAINER:/tmp/
docker cp demo_data/load_sql.sh $DB_CONTAINER:/tmp/
docker exec $DB_CONTAINER chmod +x /tmp/load_sql.sh
docker exec $DB_CONTAINER /tmp/load_sql.sh

# todo add repository
LIZMAP_CONFIG=lizmap_var/config/lizmapConfig.ini.php
echo "[repository:demo]" | sudo tee -a $LIZMAP_CONFIG
echo "label=demo" | sudo tee -a $LIZMAP_CONFIG
echo "path="/home/"" | sudo tee -a $LIZMAP_CONFIG
echo "allowUserDefinedThemes=1" | sudo tee -a $LIZMAP_CONFIG


#docker exec -it $LIZMAP_CONTAINER bash -c "apt-get -y install sqlite3"
#BEGIN TRANSACTION;
#INSERT INTO `jacl2_rights` VALUES ('lizmap.repositories.view','__anonymous','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.repositories.view','admins','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.displayGetCapabilitiesLinks','__anonymous','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.displayGetCapabilitiesLinks','admins','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.edition.use','__anonymous','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.edition.use','admins','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.layer.export','__anonymous','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.layer.export','admins','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.loginFilteredLayers.override','__anonymous','demo',0);
#INSERT INTO `jacl2_rights` VALUES ('lizmap.tools.loginFilteredLayers.override','admins','demo',0);
#COMMIT;
