START TRANSACTION;
/*创建表 */
CREATE DATABASE `WeiboLite` CHARACTER SET 'utf8mb4';
/*创建用户并赋予权限*/
CREATE USER `WeiboLite` @`%` IDENTIFIED BY '9XqgEjaRsgp6F8k&g_.8';
GRANT ALL PRIVILEGES ON `WeiboLite`.* TO `WeiboLite` @`%`;
COMMIT;