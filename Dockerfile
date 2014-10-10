# DOCKER-VERSION 1.0.1
FROM atkinschang/docker-base:ubuntu12-java8
MAINTAINER Atkins CHang "atkinschang@icloud.com"

RUN echo 'LANG="en_EN.UTF-8"' > /etc/default/locale
RUN apt-get update && apt-get dist-upgrade -y --auto-remove && \
	apt-get install -y wget unzip

RUN wget http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip && \
	unzip glassfish-4*zip && \
	mv /glassfish4 /glassfish && \
	rm glassfish-4*zip

RUN apt-get purge -y --auto-remove wget unzip

RUN echo "export GF_HOME=/glassfish4; PATH=$GF_HOME:$PATH;" >> ~/.bashrc

ENV PATH /glassfish4/bin:$PATH

EXPOSE 4848 8080 8181
CMD ["asadmin start-domain"]
