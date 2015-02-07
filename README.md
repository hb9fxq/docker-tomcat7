## docker-tomcat7
This docker file is based on ubuntu:trusty, downloads tomcat directly from apache and uses oracle-java7 as JRE.

## Build kripp/docker-tomcat7

You might want to adjust some configurations in the conf folder. These are then placed under /tomcat7/conf <br>
Build your image by simply running  '''build.sh'''

## Running the container

### Tomcat User and Group
The container runs tomcat as user tomcat7 with uid 10500, group tomcat7 with gid 1600<br>
Make sure this maps to a valid user/group on your host when doing a bind mount by using the -v switch e.g. for webapps or logs

### Example 

Bind to port 8080 on all interfaces
```
docker run -d --name MyTomcatContainer1 -v /myHostLogDir:/tomcat7/logs -v /myHostWebAppsDir:/tomcat7/webapps  -p 8080:8080 kripp/docker-tomcat7
```

Bind to port 8080 only to the localhost interface
```
docker run -d --name MyTomcatContainer1 -v /myHostLogDir:/tomcat7/logs -v /myHostWebAppsDir:/tomcat7/webapps  -p 127.0.0.1:8080:8080 kripp/docker-tomcat7
```


## Mini cheat sheet

List running containers
```
docker ps
```
Start container by name
```
docker start MyTomcatContainer1
```

Stop container by name
```
docker stop MyTomcatContainer1
```

Restart container by name
```
docker restart MyTomcatContainer1
```
List all contianers
```
docker ps -a
```

Enter running container (Req. docker version > 1.3)
```
docker exec -it MyTomcatContainer1 /bin/bash
```

Export Container (not an image) 

```
docker export MyTomcatContainer1 /myHostBackupDIr/MyTomcatContainer_bku.tar
```

Show the layers of all images
```
sudo docker images --tree
```

<br>.... anything else... https://docs.docker.com/reference/commandline/cli/ 