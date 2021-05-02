load data 
infile 'date.tbl'
badfile 'date_dim.bad'
discardfile 'date_dim.disc'
append
into table  oe.date_dim fields terminated by '|'
nullif = blanks
(
D_DATEKEY ,
D_DATE ,
D_DAYOFWEEK ,
D_MONTH ,
D_YEAR ,
D_YEARMONTHNUM ,
D_YEARMONTH ,
D_DAYNUMINWEEK ,
D_DAYNUMINMONTH ,
D_DAYNUMINYEAR ,
D_MONTHNUMINYEAR ,
D_WEEKNUMINYEAR ,
D_SELLINGSEASON ,
D_LASTDAYINWEEKFL ,
D_LASTDAYINMONTHFL ,
D_HOLIDAYFL ,
D_WEEKDAYFL 
)
