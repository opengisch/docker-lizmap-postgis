#!/bin/bash
su - postgres -c "psql -dgis -f /tmp/qgis2015.sql"
