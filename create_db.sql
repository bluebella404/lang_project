-- MySQL Script generated by MySQL Workbench
-- 01/23/17 01:00:49
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`word`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`word` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `part_of_speech` VARCHAR(45) NULL,
  `spelling` VARCHAR(45) NULL,
  `translation` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dictionary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dictionary` (
  `id` INT NOT NULL,
  `word_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dictionary_word1_idx` (`word_id` ASC),
  CONSTRAINT `fk_dictionary_word1`
    FOREIGN KEY (`word_id`)
    REFERENCES `mydb`.`word` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transaction` (
  `id` INT NOT NULL,
  `date` DATE NOT NULL,
  `sum` DECIMAL(6,4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`language` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`role` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL,
  `username` VARCHAR(30) NOT NULL,
  `email` VARCHAR(40) NULL,
  `password` CHAR(56) NOT NULL,
  `create_time`  NULL DEFAULT CURRENT_TIMESTAMP,
  `premium` TINYINT(1) NULL,
  `name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `telephone` VARCHAR(45) NULL,
  `dictionary_id` INT NOT NULL,
  `transaction_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_dictionary1_idx` (`dictionary_id` ASC),
  INDEX `fk_user_transaction1_idx` (`transaction_id` ASC),
  INDEX `fk_user_language1_idx` (`language_id` ASC),
  INDEX `fk_user_role1_idx` (`role_id` ASC),
  CONSTRAINT `fk_user_dictionary1`
    FOREIGN KEY (`dictionary_id`)
    REFERENCES `mydb`.`dictionary` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_transaction1`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `mydb`.`transaction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `mydb`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`synonym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`synonym` (
  `id` INT NOT NULL,
  `spelling` VARCHAR(45) NULL,
  `word_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_synonym_word1_idx` (`word_id` ASC),
  CONSTRAINT `fk_synonym_word1`
    FOREIGN KEY (`word_id`)
    REFERENCES `mydb`.`word` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`definition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`definition` (
  `id` INT NOT NULL,
  `definition` LONGTEXT NULL,
  `word_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_definition_word1_idx` (`word_id` ASC),
  CONSTRAINT `fk_definition_word1`
    FOREIGN KEY (`word_id`)
    REFERENCES `mydb`.`word` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`content` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  `free` TINYINT(1) NOT NULL,
  `price` DECIMAL(5,4) NULL,
  `discription` LONGTEXT NULL,
  `content_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_course_content1_idx` (`content_id` ASC),
  INDEX `fk_course_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_course_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_course` (
  `user_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `course_id`),
  INDEX `fk_user_course_course1_idx` (`course_id` ASC),
  CONSTRAINT `fk_user_course_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_course_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
