CREATE DATABASE IF NOT EXISTS blogg;

DROP TABLE IF EXISTS `blogg`.`kommentarer`;
DROP TABLE IF EXISTS `blogg`.`artiklar`;
DROP TABLE IF EXISTS `blogg`.`anvandare`;

CREATE TABLE `blogg`.`anvandare` (
  `anvandarnamn` VARCHAR(15) NOT NULL ,
  `fnamn` VARCHAR(100) NOT NULL ,
  `enamn` VARCHAR(100) NOT NULL ,
  `password` VARCHAR(40) NOT NULL COMMENT 'Saltad SHA1 hash' ,
  `is_admin` TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`anvandarnamn`) ,
  INDEX `password` USING BTREE (`password` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci
COMMENT = 'Författare av blogginlägg' ;

CREATE TABLE `blogg`.`artiklar` (
  `artiklarID` INT NOT NULL AUTO_INCREMENT ,
  `artiklar_rubrik` VARCHAR(100) NOT NULL ,
  `artiklar_text` VARCHAR(4000) NOT NULL ,
  `anvandarnamn` VARCHAR(15) NOT NULL ,
  `artiklar_pubtid` DATETIME NOT NULL ,
  PRIMARY KEY (`artiklarID`) ,
  INDEX `pubtid` (`artiklar_pubtid` ASC) ,
  INDEX `fk_forfattare` (`anvandarnamn` ASC) ,
  CONSTRAINT `fk_forfattare`
  FOREIGN KEY (`anvandarnamn` )
    REFERENCES `blogg`.`anvandare` (`anvandarnamn` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci
COMMENT = 'Blogginläggen' ;

CREATE TABLE `blogg`.`kommentarer` (
  `kommentarerID` INT NOT NULL AUTO_INCREMENT ,
  `artiklarID` INT NULL ,
  `kommentarer_rubrik` VARCHAR(100) NOT NULL ,
  `kommentarer_text` VARCHAR(1000) NOT NULL ,
  `mejl` VARCHAR(200) NOT NULL ,
  `kommemtarer_namn` VARCHAR(100) NULL ,
  `kommentarer_url` VARCHAR(150) NULL ,
  `kommentarer_tid` DATETIME NOT NULL ,
  PRIMARY KEY (`kommentarerID`) ,
  INDEX `fk_artiklar` (`artiklarID` ASC) ,
  CONSTRAINT `fk_artiklar`
    FOREIGN KEY (`artiklarID` )
    REFERENCES `blogg`.`artiklar` (`artiklarID` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;

INSERT INTO `blogg`.`anvandare` (`anvandarnamn`, `fnamn`, `enamn`, `password`, `is_admin`) VALUES ('pelle', 'Per', 'Svensson', '063b89b8b4687aa23c554f14779a8e6e09107186', 1);
INSERT INTO `blogg`.`anvandare` (`anvandarnamn`, `fnamn`, `enamn`, `password`, `is_admin`) VALUES ('stina', 'Stina', 'Persson', '063b89b8b4687aa23c554f14779a8e6e09107186', 0);

-- sha1("random" . "hardtoguess");
-- 063b89b8b4687aa23c554f14779a8e6e09107186

INSERT INTO `blogg`.`artiklar` (`artiklarID`, `artiklar_rubrik`, `artiklar_text`, `anvandarnamn`, `artiklar_pubtid`) VALUES
( NULL, 'Det första inlägget', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'pelle', '2011-10-25 13:37:00');  
INSERT INTO `blogg`.`artiklar` (`artiklarID`, `artiklar_rubrik`, `artiklar_text`, `anvandarnamn`, `artiklar_pubtid`) VALUES
( NULL, 'Det andra inlägget', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'stina', NOW());

INSERT INTO `blogg`.`kommentarer` (`artiklarID`, `kommentarer_rubrik`, `kommentarer_text`, `mejl`, `kommemtarer_namn`, `kommentarer_url`, `kommentarer_tid`) VALUES (1, 'Bra talat!', 'Det bästa jag läst på länge', 'some@body.se', 'Arne Andersson', 'http://example.com/', NOW());

-- Byt användarnamnet och lösenordet!
GRANT ALL ON `blogg`.* TO 'change_this'@'localhost' IDENTIFIED BY 'change_me';

-- http://dev.mysql.com/doc/workbench/en/wb-sakila-eer-png.html

