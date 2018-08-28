/*创建用户并赋予权限*/
CREATE ROLE "WeiboLite" LOGIN ENCRYPTED PASSWORD '9XqgEjaRsgp6F8k&g_.8';
/*创建表 */
CREATE DATABASE "WeiboLite" WITH OWNER = "WeiboLite" ENCODING = 'UTF8';
ALTER ROLE "WeiboLite" SUPERUSER;
GRANT "pg_monitor" TO "WeiboLite";

GRANT Connect, Create, Temporary ON DATABASE "WeiboLite" TO "WeiboLite";