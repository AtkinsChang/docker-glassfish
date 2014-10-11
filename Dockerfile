# DOCKER-VERSION 1.0.1
FROM atkinschang/docker-base:ubuntu14-java8
MAINTAINER Atkins CHang "atkinschang@icloud.com"

RUN echo 'LANG="en_EN.UTF-8"' > /etc/default/locale
RUN apt-get update && apt-get dist-upgrade -y --auto-remove && \
	apt-get install -y wget unzip expect

RUN wget http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip && \
	unzip glassfish-4*zip && \
	mv /glassfish4 /glassfish && \
	rm glassfish-4*zip

RUN echo 'export GF_HOME=/glassfish; PATH=$GF_HOME/bin:$PATH;' >> ~/.bashrc
ENV PATH /glassfish/bin:$PATH

RUN asadmin start-domain && expect -c 'spawn asadmin --user admin change-admin-password;expect "password";send "\n";expect "password";send "password\n";expect "password";send "password\n";expect eof;spawn asadmin enable-secure-admin;expect "admin";send "admin\n";expect "password";send "password\n";expect eof;exit'
RUN apt-get purge -y --auto-remove wget unzip expect

EXPOSE 4848 8080 8181

CMD /glassfish/bin/asadmin start-domain -w
