START TRANSACTION;
CREATE TABLE `Comment` (
	`ID` INT AUTO_INCREMENT NOT NULL,
	`UserID` INT NOT NULL,
    `WeiboID` INT NOT NULL,
	`Comment` VARCHAR ( 128 ) NOT NULL,
	`Time` datetime DEFAULT CURRENT_TIMESTAMP NOT NULL ,
    FOREIGN KEY (`UserID`) REFERENCES `User` (`ID`),
    FOREIGN KEY (`WeiboID`) REFERENCES `Weibo` (`ID`),
    /*不知道能不能用上这个索引*/
    INDEX (`WeiboID`, `Time`),
	PRIMARY KEY ( `ID` ) 
) ;
COMMIT;
