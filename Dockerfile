FROM oraclelinux:7

ARG USER
ARG PASS
ARG WEBLOGICSRC

RUN yum -y install tar wget xterm libXtst libaio bc net-tools less telnet unzip
RUN wget --progress=dot:giga --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm -Ojdk.rpm
RUN rpm -ivh jdk.rpm && rm jdk.rpm
RUN useradd oracle
RUN mkdir -p /opt/oracle ; chown -R oracle /opt/oracle

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

RUN mkdir /tmp/install
ADD downloader.jar /tmp/install/downloader.jar
ADD sources.txt /tmp/install/sources.txt
RUN chown -R oracle /tmp/install

USER oracle
WORKDIR /tmp/install

#RUN printf "username=$USER\npassword=$PASS\n" >>/tmp/install/sources.txt ; cat /tmp/install/sources.txt
#RUN java -jar /tmp/install/downloader.jar sources.txt=weblogic.zip
#RUN unzip weblogic.zip
RUN wget $WEBLOGICSRC
#RUN chown oracle /tmp/install/fmw_12.2.1.2.0_wls_quick.jar ; chown oracle /tmp/install/fmw_12212_readme.htm ; chmod 644 /tmp/install/fmw_12.2.1.2.0_wls_quick.jar ; chmod 644 /tmp/install/fmw_12212_readme.htm

#RUN chown oracle /tmp/install/fmw_12.2.1.2.0_wls_quick.jar ; chmod 644 /tmp/install/fmw_12.2.1.2.0_wls_quick.jar 

RUN java -jar /tmp/install/fmw_12.2.1.2.0_wls_quick.jar ORACLE_HOME=/opt/oracle

WORKDIR /opt/oracle

RUN rm -rf /tmp/install
RUN mkdir -p /opt/oracle/domain

VOLUME ["/opt/oracle"]
EXPOSE 7001

CMD ["/entrypoint.sh"]

