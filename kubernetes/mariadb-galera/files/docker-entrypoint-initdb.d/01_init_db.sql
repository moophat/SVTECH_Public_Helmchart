CREATE DATABASE IF NOT EXISTS grafana;
CREATE DATABASE IF NOT EXISTS rundeck;
CREATE DATABASE IF NOT EXISTS icinga;
CREATE DATABASE IF NOT EXISTS directordb;
CREATE DATABASE IF NOT EXISTS icingadb;
CREATE DATABASE IF NOT EXISTS icingaweb2db;
CREATE DATABASE IF NOT EXISTS x509db;

GRANT RELOAD, FILE, SUPER, REPLICATION SLAVE, BINLOG MONITOR ON *.* TO maxscale_monitor@'%' IDENTIFIED BY 'maxscale@123';
GRANT SHOW DATABASES, REPLICATION SLAVE, BINLOG MONITOR ON *.* TO maxscale@'%' IDENTIFIED BY 'maxscale@123';
GRANT SELECT ON mysql.columns_priv TO maxscale@'%';
GRANT SELECT ON mysql.user TO maxscale@'%';
GRANT SELECT ON mysql.proxies_priv TO maxscale@'%';
GRANT SELECT ON mysql.db TO maxscale@'%';
GRANT SELECT ON mysql.procs_priv TO maxscale@'%';
GRANT SELECT ON mysql.roles_mapping TO maxscale@'%';
GRANT SELECT ON mysql.tables_priv TO maxscale@'%';

grant all privileges on grafana.* to grafana@'%' identified by 'juniper@123';
grant all privileges on grafana.* to grafana@'localhost' identified by 'juniper@123';
grant all privileges on grafana.* to grafana@'127.0.0.1' identified by 'juniper@123';

grant all privileges on rundeck.* to rundeck@'%' identified by 'juniper@123';
grant all privileges on rundeck.* to rundeck@'localhost' identified by 'juniper@123';
grant all privileges on rundeck.* to rundeck@'127.0.0.1' identified by 'juniper@123';

grant all privileges on icinga.* to icinga@'%' identified by 'juniper@123';
grant all privileges on icinga.* to icinga@'localhost' identified by 'juniper@123';
grant all privileges on icinga.* to icinga@'127.0.0.1' identified by 'juniper@123';

grant all privileges on junos_tableview.* to 'juniper'@'%' identified by 'juniper@123';
grant all privileges on junos_tableview.* to 'juniper'@'127.0.0.1' identified by 'juniper@123';
grant all privileges on junos_tableview.* to 'juniper'@'localhost' identified by 'juniper@123';

grant all privileges on audit_config.* to 'juniper'@'%' identified by 'juniper@123';
grant all privileges on audit_config.* to 'juniper'@'127.0.0.1' identified by 'juniper@123';
grant all privileges on audit_config.* to 'juniper'@'localhost' identified by 'juniper@123';

grant select on *.* to 'rundeck_option_api'@'%' identified by 'juniper@123';
grant select on *.* to 'rundeck_option_api'@'localhost' identified by 'juniper@123';
grant select on *.* to 'rundeck_option_api'@'127.0.0.1' identified by 'juniper@123';

grant all privileges on directordb.* to director@'%' identified by 'juniper@123';
grant all privileges on directordb.* to director@'localhost' identified by 'juniper@123';
grant all privileges on directordb.* to director@'127.0.0.1' identified by 'juniper@123';

grant all privileges on icingadb.* to icingadb@'%' identified by 'juniper@123';
grant all privileges on icingadb.* to icingadb@'localhost' identified by 'juniper@123';
grant all privileges on icingadb.* to icingadb@'127.0.0.1' identified by 'juniper@123';

grant all privileges on icingaweb2db.* to icingaweb2@'%' identified by 'juniper@123';
grant all privileges on icingaweb2db.* to icingaweb2@'localhost' identified by 'juniper@123';
grant all privileges on icingaweb2db.* to icingaweb2@'127.0.0.1' identified by 'juniper@123';

grant all privileges on x509db.* to x509@'%' identified by 'juniper@123';
grant all privileges on x509db.* to x509@'localhost' identified by 'juniper@123';
grant all privileges on x509db.* to x509@'127.0.0.1' identified by 'juniper@123';

-- create database for snmptt
CREATE DATABASE IF NOT EXISTS snmptt;
grant all privileges on snmptt.* to 'snmptt'@'%' identified by 'juniper@123';
grant all privileges on snmptt.* to 'snmptt'@'localhost' identified by 'juniper@123';
grant all privileges on snmptt.* to 'snmptt'@'127.0.0.1' identified by 'juniper@123';

USE snmptt;
DROP TABLE if exists snmptt;
CREATE TABLE snmptt (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
eventname VARCHAR(50),
eventid VARCHAR(50),
trapoid VARCHAR(100),
enterprise VARCHAR(100),
community VARCHAR(20),
hostname VARCHAR(100),
agentip  VARCHAR(16),
category VARCHAR(20),
severity VARCHAR(20),
uptime  VARCHAR(20),
traptime DATETIME,
formatline VARCHAR(255));
