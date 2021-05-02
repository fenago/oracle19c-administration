load data 
infile 'supplier.tbl'
badfile 'supplier.bad'
discardfile 'supplier.disc'
append
into table  odr.supplier fields terminated by '|'
nullif = blanks
(
S_SUPPKEY ,
S_NAME ,
S_ADDRESS ,
S_CITY ,
S_NATION ,
S_REGION ,
S_PHONE 
)
