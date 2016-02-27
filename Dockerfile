FROM centos

MAINTAINER kaakaa <stooner.hoe@gmail.com>

RUN yum -y update
RUN yum -y update && \
	yum -y install git java-1.7.0-openjdk libreoffice libreoffice-headless && \
	yum -y clean all
RUN curl -L http://sourceforge.net/projects/jodconverter/files/JODConverter/2.2.2/jodconverter-tomcat-2.2.2.zip/download \
                -o /opt/jodconverter-tomcat-2.2.2.zip
RUN unzip /opt/jodconverter-tomcat-2.2.2.zip -d /usr/local/src
RUN rm -f /opt/jodconverter-tomcat-2.2.2.zip

RUN ln -s /usr/local/src/jodconverter-tomcat-2.2.2/bin/startup.sh /usr/bin/jod
RUN cd /usr/local/src && echo '#!/bin/sh' >> start.sh
RUN cd /usr/local/src && echo 'jod' >> start.sh
RUN cd /usr/local/src && echo '/usr/bin/soffice --headless --accept="socket,port=8100;urp;"' >> start.sh
RUN cd /usr/local/src && chmod +x start.sh
EXPOSE 8080

ENTRYPOINT ["/usr/local/src/start.sh"]
