## docker-tomcat7
This docker file is based on ubuntu:trusty, downloads tomcat directly from apache and uses oracle-java7 as JRE.

## Build kripp/docker-tomcat7

You might want to adjust some configurations in the conf folder. These are then placed under /tomcat7/con
Build the image by running the "build.sh"


## Running the container

### Tomcat User and Group
The container runs tomcat as user tomcat7 with uid 10500, group tomcat7 with gid 1600
Make sure this maps to a valid user/group on your host when doing a bind mount by using the -v switch e.g. for webapps or logs

### Example 

```
docker run -d --name MyTomcatContainer1 -v /myHostLogDir:/tomcat7/logs -v /myHostWebAppsDir:/tomcat7/webapps  -p 8080:8080 kripp/docker-tomcat7
```

## Mini cheat sheet

List running containers
```
docker ps
```
List all contianers
```
docker ps -a
```

Enter running container (Req. docker version > 1.3)
```
docker exec -it MyTomcatContainer1 /bin/bash
```