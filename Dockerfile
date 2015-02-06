FROM ubuntu:trusty
MAINTAINER Frank Werner-Krippendorf (wkf   (/a/t)  kripp (/d/o/t) ch)

##### add python-sofware-properties to install add-apt-repository
RUN apt-get update
RUN apt-get -y install software-properties-common curl


##### webupd8team reposiotry
# details:  http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
RUN add-apt-repository ppa:webupd8team/java

#####  update & upgrade
RUN apt-get update && apt-get -y upgrade

##### Install oracle Java

# http://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get -y install oracle-java7-installer

# set JAVA_HOME
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment

#### install tomcat7

EXPOSE 8080

ENV CATALINA_HOME /tomcat7
RUN addgroup --gid 1600 tomcat7
RUN adduser --disabled-password --home=/tomcat7 --gecos "" --uid 10500 tomcat7 --gid 1600

WORKDIR /tomcat7

# see https://github.com/docker-library/tomcat/blob/278a10ace50c5e7addd879fae5c5332e57b2fe37/7-jre7/Dockerfile 
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
	05AB33110949707C93A279E3D3EFE6B686867BA6 \
	07E48665A34DCAFAE522E5E6266191C37C037D42 \
	47309207D818FFD8DCD3F83F1931D684307A10A5 \
	541FBE7D8F78B25E055DDEE13C370389288584E7 \
	61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
	713DA88BE50911535FE716F5208B0AB1D63011C7 \
	79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
	9BA44C2621385CB966EBA586F72C284D731FABEE \
	A27677289986DB50844682F8ACB77FC2E86E29AC \
	A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
	DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
	F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
	F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23


ENV TOMCAT_MAJOR 7
ENV TOMCAT_VERSION 7.0.59
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN curl -SL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -SL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz*


add confs/catalina.policy /tomcat7/config/catalina.policy
add confs/catalina.properties /tomcat7/config/catalina.properties
add confs/context.xml /tomcat7/config/context.xml
add confs/logging.properties /tomcat7/config/logging.properties
add confs/server.xml /tomcat7/config/server.xml
add confs/tomcat-users.xml /tomcat7/config/tomcat-users.xml
add confs/web.xml /tomcat7/config/web.xml
add run.sh /tomcat7/run.sh

RUN chown -R tomcat7:tomcat7 /tomcat7
RUN chmod +x /tomcat7/bin/catalina.sh
RUN chmod +x /tomcat7/run.sh



CMD ["run.sh"]


USER tomcat7


