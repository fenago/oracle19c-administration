load data 
infile 'part.tbl'
badfile 'part.bad'
discardfile 'part.disc'
append
into table  oe.part fields terminated by '|'
nullif = blanks
(
P_PARTKEY ,
P_NAME ,
P_MFGR ,
P_CATEGORY ,
P_BRAND1 ,
P_COLOR ,
P_TYPE ,
P_SIZE ,
P_CONTAINER 
)
