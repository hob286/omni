#!/bin/sh
# ���ű����ڴ��ļ��ж�ȡsql��������ִ��
# test
# MySQL�ͻ��˵�·��
MYSQLPATH='/home/rd/mysql5620-master/bin'
SER_IP='10.172.172.7'
SER_PORT=3206
SER_USER=rd
SER_PASSWD=rd123
DATABASE=CTDB
SQL_FILE='/home/rd/ctp-svn/server/trunk/ctp-sys/ct-server/dbscript/create_ctp_quot.sql'

echo "Begin to excute sql..."
PWDCNT=`echo $SER_PASSWD|wc -c`
if [ $PWDCNT -ne 1 ]
then
    PASSWD="-p$SER_PASSWD"
fi

echo $MYSQLPATH/mysql -u$SER_USER $PASSWD -h$SER_IP -P$SER_PORT 
eval "$MYSQLPATH/mysql -u$SER_USER $PASSWD -h$SER_IP -P$SER_PORT << EOF 
USE $DATABASE;
source $SQL_FILE
"
echo "Execute completed."

