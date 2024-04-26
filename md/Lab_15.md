# How to Grant All Privileges to a User in Oracle
**Summary**: In this lab, you will learn how to use the Oracle `GRANT ALL PRIVILEGES` statement to grant all privileges to a user.

Granting all privileges to a new user
-------------------------------------

First, create a new user called `super` with a password by using the following `CREATE USER` statement:

```
CREATE USER super IDENTIFIED BY abcd1234;
```


The `super` user created. Note that you should use a secure password instead of `abcd124`.

Second, use the `GRANT ALL PRIVILEGES` statement to grant all privileges to the `super` user:

```
GRANT ALL PRIVILEGES TO super;
```


Third, log in to the Oracle Database as the `super` user:

```
Enter user-name: super@fenagodb1
Enter password:
```


And query the `super` user’s privileges:

```
SELECT * FROM session_privs
ORDER BY privilege;

```


Here is the output in Oracle 19c:

```
PRIVILEGE                              
----------------------------------------
ADMINISTER ANY SQL TUNING SET           
ADMINISTER DATABASE TRIGGER             
ADMINISTER RESOURCE MANAGER             
ADMINISTER SQL MANAGEMENT OBJECT        
ADMINISTER SQL TUNING SET               
ADVISOR                                 
ALTER ANY ANALYTIC VIEW                 
ALTER ANY ASSEMBLY                      
ALTER ANY ATTRIBUTE DIMENSION           
ALTER ANY CLUSTER                       
ALTER ANY CUBE                          

PRIVILEGE                              
----------------------------------------
ALTER ANY CUBE BUILD PROCESS            
ALTER ANY CUBE DIMENSION                
ALTER ANY DIMENSION                     
ALTER ANY EDITION                       
ALTER ANY EVALUATION CONTEXT            
ALTER ANY HIERARCHY                     
ALTER ANY INDEX                         
ALTER ANY INDEXTYPE                     
ALTER ANY LIBRARY                       
ALTER ANY MATERIALIZED VIEW             
ALTER ANY MEASURE FOLDER                

PRIVILEGE                              
----------------------------------------
ALTER ANY MINING MODEL                  
ALTER ANY OPERATOR                      
ALTER ANY OUTLINE                       
ALTER ANY PROCEDURE                     
ALTER ANY ROLE                          
ALTER ANY RULE                          
ALTER ANY RULE SET                      
ALTER ANY SEQUENCE                      
ALTER ANY SQL PROFILE                   
ALTER ANY SQL TRANSLATION PROFILE       
ALTER ANY TABLE                         

PRIVILEGE                              
----------------------------------------
ALTER ANY TRIGGER                       
ALTER ANY TYPE                          
ALTER DATABASE                          
ALTER LOCKDOWN PROFILE                  
ALTER PROFILE                           
ALTER RESOURCE COST                     
ALTER ROLLBACK SEGMENT                  
ALTER SESSION                           
ALTER SYSTEM                            
ALTER TABLESPACE                        
ALTER USER                              

PRIVILEGE                              
----------------------------------------
ANALYZE ANY                             
AUDIT ANY                               
AUDIT SYSTEM                            
BACKUP ANY TABLE                        
BECOME USER                             
CHANGE NOTIFICATION                     
COMMENT ANY MINING MODEL                
COMMENT ANY TABLE                       
CREATE ANALYTIC VIEW                    
CREATE ANY ANALYTIC VIEW                
CREATE ANY ASSEMBLY                     

PRIVILEGE                              
----------------------------------------
CREATE ANY ATTRIBUTE DIMENSION          
CREATE ANY CLUSTER                      
CREATE ANY CONTEXT                      
CREATE ANY CREDENTIAL                   
CREATE ANY CUBE                         
CREATE ANY CUBE BUILD PROCESS           
CREATE ANY CUBE DIMENSION               
CREATE ANY DIMENSION                    
CREATE ANY DIRECTORY                    
CREATE ANY EDITION                      
CREATE ANY EVALUATION CONTEXT           

PRIVILEGE                              
----------------------------------------
CREATE ANY HIERARCHY                    
CREATE ANY INDEX                        
CREATE ANY INDEXTYPE                    
CREATE ANY JOB                          
CREATE ANY LIBRARY                      
CREATE ANY MATERIALIZED VIEW            
CREATE ANY MEASURE FOLDER               
CREATE ANY MINING MODEL                 
CREATE ANY OPERATOR                     
CREATE ANY OUTLINE                      
CREATE ANY PROCEDURE                    

PRIVILEGE                              
----------------------------------------
CREATE ANY RULE                         
CREATE ANY RULE SET                     
CREATE ANY SEQUENCE                     
CREATE ANY SQL PROFILE                  
CREATE ANY SQL TRANSLATION PROFILE      
CREATE ANY SYNONYM                      
CREATE ANY TABLE                        
CREATE ANY TRIGGER                      
CREATE ANY TYPE                         
CREATE ANY VIEW                         
CREATE ASSEMBLY                         

PRIVILEGE                              
----------------------------------------
CREATE ATTRIBUTE DIMENSION              
CREATE CLUSTER                          
CREATE CREDENTIAL                       
CREATE CUBE                             
CREATE CUBE BUILD PROCESS               
CREATE CUBE DIMENSION                   
CREATE DATABASE LINK                    
CREATE DIMENSION                        
CREATE EVALUATION CONTEXT               
CREATE EXTERNAL JOB                     
CREATE HIERARCHY                        

PRIVILEGE                              
----------------------------------------
CREATE INDEXTYPE                        
CREATE JOB                              
CREATE LIBRARY                          
CREATE LOCKDOWN PROFILE                 
CREATE MATERIALIZED VIEW                
CREATE MEASURE FOLDER                   
CREATE MINING MODEL                     
CREATE OPERATOR                         
CREATE PLUGGABLE DATABASE               
CREATE PROCEDURE                        
CREATE PROFILE                          

PRIVILEGE                              
----------------------------------------
CREATE PUBLIC DATABASE LINK             
CREATE PUBLIC SYNONYM                   
CREATE ROLE                             
CREATE ROLLBACK SEGMENT                 
CREATE RULE                             
CREATE RULE SET                         
CREATE SEQUENCE                         
CREATE SESSION                          
CREATE SQL TRANSLATION PROFILE          
CREATE SYNONYM                          
CREATE TABLE                            

PRIVILEGE                              
----------------------------------------
CREATE TABLESPACE                       
CREATE TRIGGER                          
CREATE TYPE                             
CREATE USER                             
CREATE VIEW                             
DEBUG ANY PROCEDURE                     
DEBUG CONNECT ANY                       
DEBUG CONNECT SESSION                   
DELETE ANY CUBE DIMENSION               
DELETE ANY MEASURE FOLDER               
DELETE ANY TABLE                        

PRIVILEGE                              
----------------------------------------
DEQUEUE ANY QUEUE                       
DROP ANY ANALYTIC VIEW                  
DROP ANY ASSEMBLY                       
DROP ANY ATTRIBUTE DIMENSION            
DROP ANY CLUSTER                        
DROP ANY CONTEXT                        
DROP ANY CUBE                           
DROP ANY CUBE BUILD PROCESS             
DROP ANY CUBE DIMENSION                 
DROP ANY DIMENSION                      
DROP ANY DIRECTORY                      

PRIVILEGE                              
----------------------------------------
DROP ANY EDITION                        
DROP ANY EVALUATION CONTEXT             
DROP ANY HIERARCHY                      
DROP ANY INDEX                          
DROP ANY INDEXTYPE                      
DROP ANY LIBRARY                        
DROP ANY MATERIALIZED VIEW              
DROP ANY MEASURE FOLDER                 
DROP ANY MINING MODEL                   
DROP ANY OPERATOR                       
DROP ANY OUTLINE                        

PRIVILEGE                              
----------------------------------------
DROP ANY PROCEDURE                      
DROP ANY ROLE                           
DROP ANY RULE                           
DROP ANY RULE SET                       
DROP ANY SEQUENCE                       
DROP ANY SQL PROFILE                    
DROP ANY SQL TRANSLATION PROFILE        
DROP ANY SYNONYM                        
DROP ANY TABLE                          
DROP ANY TRIGGER                        
DROP ANY TYPE                           

PRIVILEGE                              
----------------------------------------
DROP ANY VIEW                           
DROP LOCKDOWN PROFILE                   
DROP PROFILE                            
DROP PUBLIC DATABASE LINK               
DROP PUBLIC SYNONYM                     
DROP ROLLBACK SEGMENT                   
DROP TABLESPACE                         
DROP USER                               
EM EXPRESS CONNECT                      
ENQUEUE ANY QUEUE                       
EXECUTE ANY ASSEMBLY                    

PRIVILEGE                              
----------------------------------------
EXECUTE ANY CLASS                       
EXECUTE ANY EVALUATION CONTEXT          
EXECUTE ANY INDEXTYPE                   
EXECUTE ANY LIBRARY                     
EXECUTE ANY OPERATOR                    
EXECUTE ANY PROCEDURE                   
EXECUTE ANY PROGRAM                     
EXECUTE ANY RULE                        
EXECUTE ANY RULE SET                    
EXECUTE ANY TYPE                        
EXECUTE ASSEMBLY                        

PRIVILEGE                              
----------------------------------------
EXEMPT DDL REDACTION POLICY             
EXEMPT DML REDACTION POLICY             
EXPORT FULL DATABASE                    
FLASHBACK ANY TABLE                     
FLASHBACK ARCHIVE ADMINISTER            
FORCE ANY TRANSACTION                   
FORCE TRANSACTION                       
GLOBAL QUERY REWRITE                    
GRANT ANY OBJECT PRIVILEGE              
GRANT ANY PRIVILEGE                     
GRANT ANY ROLE                          

PRIVILEGE                              
----------------------------------------
IMPORT FULL DATABASE                    
INSERT ANY CUBE DIMENSION               
INSERT ANY MEASURE FOLDER               
INSERT ANY TABLE                        
LOCK ANY TABLE                          
LOGMINING                               
MANAGE ANY FILE GROUP                   
MANAGE ANY QUEUE                        
MANAGE FILE GROUP                       
MANAGE SCHEDULER                        
MANAGE TABLESPACE                       

PRIVILEGE                              
----------------------------------------
MERGE ANY VIEW                          
ON COMMIT REFRESH                       
QUERY REWRITE                           
READ ANY FILE GROUP                     
READ ANY TABLE                          
REDEFINE ANY TABLE                      
RESTRICTED SESSION                      
RESUMABLE                               
SELECT ANY CUBE                         
SELECT ANY CUBE BUILD PROCESS           
SELECT ANY CUBE DIMENSION               

PRIVILEGE                              
----------------------------------------
SELECT ANY MEASURE FOLDER               
SELECT ANY MINING MODEL                 
SELECT ANY SEQUENCE                     
SELECT ANY TABLE                        
SELECT ANY TRANSACTION                  
SET CONTAINER                           
UNDER ANY TABLE                         
UNDER ANY TYPE                          
UNDER ANY VIEW                          
UNLIMITED TABLESPACE                    
UPDATE ANY CUBE                         

PRIVILEGE                              
----------------------------------------
UPDATE ANY CUBE BUILD PROCESS          
UPDATE ANY CUBE DIMENSION               
UPDATE ANY TABLE                        
USE ANY JOB RESOURCE                    
USE ANY SQL TRANSLATION PROFILE     

```


Granting all privileges to an existing user
-------------------------------------------

To grant all privileges to an existing user, you just need to use the `GRANT ALL PRIVILEGES` statement. For example, the following statement grants all privileges to the user `alice`:

```
GRANT ALL PRIVILEGES to alice;
```


In this lab, you have learned how to use the Oracle `GRANT ALL PRIVILEGES` statement to grant all privileges to a user.
