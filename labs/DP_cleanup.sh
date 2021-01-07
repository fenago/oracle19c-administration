#!/bin/bash

#-- Cleanup after Practice 16

#-- remove *.log files
rm /home/oracle/labs/DP/*.log

#-- remove *.bad files
rm /home/oracle/labs/DP/*.bad
export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
sqlplus -s oe/oracle_4U@pdb1 << EOF
-- delete rows inserted by SQL*Loader
DELETE FROM OE.PRODUCT_DESCRIPTIONS WHERE product_id > 4000;
Commit;

Delete from OE.INVENTORIES 
  WHERE quantity_on_hand = 7  
  AND   WAREHOUSE_ID>500 ;

COMMIT;

EOF
