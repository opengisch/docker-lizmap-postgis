#!/bin/bash
docker-compose rm --force;
git fetch;
git reset --hard origin/master;
sudo git clean -f -d;
docker-compose up -d;