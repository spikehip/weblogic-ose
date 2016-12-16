#!/bin/bash

/opt/oracle/wlserver/server/bin/setWLSEnv.sh \
  && cd /opt/oracle/domain \ 
  && java weblogic.Server
