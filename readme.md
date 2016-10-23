Docker composer for a full stack lizmap with qgis server and postgis server.
The postgis server host is named qgis-postgis and is only accessible from within this composer.

QGIS Projects
-------------
in your projects you should create a postgis connection with the following credentials:
* host: qgis-postgis
* db: gis
* user: docker
* password: docker

Network
-------
in your /etc/hosts file (or in your dns if you are in an intranet) you should create an entry that points qgis-postgis to the correct server where you replicate the postgis server that is running from the docker-compose. If you are on your own dev machine, this is probably 127.0.0.1 so your /etc/hosts file should have something like this:
```
127.0.0.1       localhost
127.0.0.1       qgis-postgis
```

If you want to directly access the postgis running in docker you need to expose its port 5432 to the host by uncommenting the `ports` line in the `docker-compose.yml` file


Install
-------
```
git clone https://github.com/opengisch/docker-lizmap-postgis.git
cd docker-lizmap-postgis
docker-compose up -d
```

Demo Project
------------
if you want to automatically add the demo project you can run the comand below. This is a one off comand and will probably fail if repeated. I suggest using it just after the first run of docker-compose. 
WARNING: the startup of postgis at the first run of docker-compose takes some 10 seconds, so allow some time between `docker-compose up -d` and `./install_demo.sh`
```
./install_demo.sh
```
Running
-------
Lizmap is exposed on port 9999
```
http://localhost:9999
http://localhost:9999/websig/lizmap/www/admin.php/admin/config/
```

