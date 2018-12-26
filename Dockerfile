FROM anapsix/alpine-java
MAINTAINER kaakaa <stooner.hoe@gmail.com>

RUN apk update

RUN apk add wget unzip fontconfig libreoffice msttcorefonts-installer ttf-freefont
RUN update-ms-fonts
RUN fc-cache -fv

RUN wget -O jod-tomcat.zip 'http://sourceforge.net/projects/jodconverter/files/JODConverter/2.2.2/jodconverter-tomcat-2.2.2.zip/download'
RUN unzip jod-tomcat.zip -d /usr/local/src \
  && ln -s /usr/local/src/jodconverter-tomcat-2.2.2/bin/startup.sh /usr/bin/jod \
  && rm jod-tomcat.zip

ADD start /usr/bin/start-jod
ADD applicationContext.xml /usr/local/src/jodconverter-tomcat-2.2.2/webapps/converter/WEB-INF/applicationContext.xml

EXPOSE 8080

RUN chmod +x /usr/bin/start-jod

ENTRYPOINT ["/bin/sh", "-c", "/usr/bin/start-jod"]
