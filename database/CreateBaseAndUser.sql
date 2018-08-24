START TRANSACTION;
/*创建表 */
CREATE DATABASE `WeiboLite` CHARACTER SET 'utf8mb4';
/*创建用户并赋予权限*/
CREATE USER `WeiboLite` @`%` IDENTIFIED BY 'XfwVT7k5t82L';
GRANT ALL PRIVILEGES ON `WeiboLite`.* TO `WeiboLite` @`%`;
COMMIT;