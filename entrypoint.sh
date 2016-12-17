#!/bin/bash

cat >> /opt/oracle/create-adminserver.py <<EDN
#!/usr/bin/python
import os, sys
readTemplate('/opt/oracle/wlserver/common/templates/wls/wls.jar')
cd('/Security/base_domain/User/weblogic')
cmo.setPassword('welcome1')
cd('/Server/AdminServer')
cmo.setName('AdminServer')
cmo.setListenPort(7001)
cmo.setListenAddress('0.0.0.0')
writeDomain('/opt/oracle/domain/domain1')
closeTemplate()
exit()
EDN

/opt/oracle/oracle_common/common/bin/commEnv.sh
/opt/oracle/oracle_common/common/bin/wlst.sh /opt/oracle/create-adminserver.py

/opt/oracle/domain/domain1/bin/startWebLogic.sh

