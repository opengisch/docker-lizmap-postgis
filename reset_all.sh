#!/bin/bash
docker-compose kill
docker-compose rm --force;
sudo rm -rf pg lizmap_* projects
git fetch;
git reset --hard origin/master;
sudo git clean -f -d;
docker-compose up -d;
