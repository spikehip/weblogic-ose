FROM oraclelinux:7

RUN yum -y install tar wget xterm libXtst libaio bc net-tools less telnet unzip
RUN wget --progress=dot:giga --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm -Ojdk.rpm
RUN rpm -ivh jdk.rpm && rm jdk.rpm

ADD downloader.jar /downloader.jar
ADD sources.txt /sources.txt
RUN printf "username=$USER\npassword=$PASS\n" >>/sources.txt
RUN mkdir -p /opt/oracle/domain 
RUN useradd oracle
RUN chown -R oracle /opt/oracle
RUN java -jar /downloader.jar sources.txt=weblogic.zip
RUN unzip weblogic.zip
USER oracle
RUN java -jar fmw_12.2.1.2.0_wls_quick.jar ORACLE_HOME=/opt/oracle

ADD entrypoint.sh /entrypoint.sh

VOLUME ["/opt/oracle"]
EXPOSE 7001

CMD ["/entrypoint.sh"]

