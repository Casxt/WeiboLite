START TRANSACTION;
CREATE TABLE `Weibo` (
	`ID` INT AUTO_INCREMENT NOT NULL,
	`UserID` INT NOT NULL,
	`Content` VARCHAR ( 512 ) NOT NULL,
    /*最多9张图片，记录格式 imghash1,imghash2,...,imghashN*/
	`Images` VARCHAR ( 584 ) DEFAULT "" NOT NULL,
	`ForwardType` enum("Weibo","Comment","NoForward") DEFAULT "NoForward" NOT NULL,
	`Forward` INT DEFAULT 0 NULL,
	`Time` datetime DEFAULT CURRENT_TIMESTAMP NOT NULL ,
    FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`),
    /*不知道能不能用上这个索引*/
    INDEX (`UserID`, `Time`),
	INDEX (`ForwardType`, `Forward`),
	PRIMARY KEY ( `ID` ) 
) ;
COMMIT;
/*
查询优化 ：
https://www.cnblogs.com/tangyanbo/p/6378741.html
*/