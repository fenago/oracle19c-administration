load data 
infile 'customer.tbl'
badfile 'customer.bad'
discardfile 'customer.disc'
append
into table  odr.customer fields terminated by '|'
nullif = blanks
(
C_CUSTKEY ,
C_NAME ,
C_ADDRESS ,
C_CITY ,
C_NATION ,
C_REGION ,
C_PHONE ,
C_MKTSEGMENT 
)

