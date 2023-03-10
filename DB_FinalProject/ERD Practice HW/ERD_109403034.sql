-- MySQL Script generated by MySQL Workbench
-- Tue May 31 18:25:17 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_table` (
  `idUser_table` INT NOT NULL,
  `member_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `account_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  `gender` TINYINT NULL,
  `password` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `membership_level` VARCHAR(45) NULL,
  `create_at` DATE NOT NULL,
  `update_at` DATE NULL,
  PRIMARY KEY (`idUser_table`),
  UNIQUE INDEX `member_id_UNIQUE` (`member_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stock_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock_table` (
  `idStock_table` INT NOT NULL,
  `product_id` INT NOT NULL,
  `cost` INT NOT NULL,
  `buy_in_date` DATE NULL,
  `sold_out_date` DATE NULL,
  `total_quantity` INT NULL,
  `buy_in_quantity` INT NULL,
  `sold_out_quantity` INT NULL,
  PRIMARY KEY (`idStock_table`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`revenue_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`revenue_table` (
  `idrevenue_table` INT NOT NULL,
  `seller_id` INT NULL,
  `monthly_revenue` INT NULL,
  `quarterly_revenue` INT NULL,
  `annually_revenue` INT NULL,
  `updated_at` INT NULL,
  PRIMARY KEY (`idrevenue_table`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ShoppingHistory_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ShoppingHistory_table` (
  `idShoppingHistory_tabel` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `buyer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `total_price` INT NOT NULL,
  `sent_store` VARCHAR(45) NULL,
  `received_store` VARCHAR(45) NULL,
  `created_at` DATE NOT NULL,
  `updated_at` DATE NULL,
  `estabilished` TINYINT NULL,
  PRIMARY KEY (`idShoppingHistory_tabel`),
  INDEX `buyer_id_idx` (`buyer_id` ASC) VISIBLE,
  CONSTRAINT `buyer_id`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `mydb`.`User_table` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seller_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Seller_table` (
  `idSeller_table` INT NOT NULL,
  `account_name` VARCHAR(45) NOT NULL,
  `seller_id` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `product_no` INT NOT NULL,
  `created_at` DATE NOT NULL,
  `updated_at` DATE NULL,
  `Stock_table_idStock_table` INT NOT NULL,
  `revenue_table_idrevenue_table` INT NOT NULL,
  `ShoppingHistory_table_idShoppingHistory_tabel` INT NOT NULL,
  PRIMARY KEY (`idSeller_table`),
  UNIQUE INDEX `product_no_UNIQUE` (`product_no` ASC) VISIBLE,
  INDEX `fk_Seller_table_Stock_table1_idx` (`Stock_table_idStock_table` ASC) VISIBLE,
  INDEX `fk_Seller_table_revenue_table1_idx` (`revenue_table_idrevenue_table` ASC) VISIBLE,
  INDEX `fk_Seller_table_ShoppingHistory_table1_idx` (`ShoppingHistory_table_idShoppingHistory_tabel` ASC) VISIBLE,
  CONSTRAINT `fk_Seller_table_Stock_table1`
    FOREIGN KEY (`Stock_table_idStock_table`)
    REFERENCES `mydb`.`Stock_table` (`idStock_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seller_table_revenue_table1`
    FOREIGN KEY (`revenue_table_idrevenue_table`)
    REFERENCES `mydb`.`revenue_table` (`idrevenue_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seller_table_ShoppingHistory_table1`
    FOREIGN KEY (`ShoppingHistory_table_idShoppingHistory_tabel`)
    REFERENCES `mydb`.`ShoppingHistory_table` (`idShoppingHistory_tabel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_tabel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order_tabel` (
  `idOrder_tabel` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `buyer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `total_price` INT NOT NULL,
  `sent_store` VARCHAR(45) NULL,
  `received_store` VARCHAR(45) NULL,
  `created_at` DATE NOT NULL,
  `updated_at` DATE NULL,
  `estabilished` TINYINT NULL,
  `Seller_table_idSeller_table` INT NOT NULL,
  PRIMARY KEY (`idOrder_tabel`),
  INDEX `fk_Order_tabel_Seller_table1_idx` (`Seller_table_idSeller_table` ASC) VISIBLE,
  INDEX `buyer_id_idx` (`buyer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_tabel_Seller_table1`
    FOREIGN KEY (`Seller_table_idSeller_table`)
    REFERENCES `mydb`.`Seller_table` (`idSeller_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `buyer_id`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `mydb`.`User_table` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_table` (
  `idProduct_table` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `product_no` INT NOT NULL,
  `price` INT NOT NULL,
  `discribtion` VARCHAR(45) NULL,
  `created_at` DATE NOT NULL,
  `update_at` DATE NULL,
  `delete_at` DATE NULL,
  `Stock_table_idStock_table` INT NOT NULL,
  `ShoppingHistory_table_idShoppingHistory_tabel` INT NOT NULL,
  PRIMARY KEY (`idProduct_table`, `Stock_table_idStock_table`),
  UNIQUE INDEX `seller_id_UNIQUE` (`seller_id` ASC) VISIBLE,
  UNIQUE INDEX `product_no_UNIQUE` (`product_no` ASC) VISIBLE,
  INDEX `fk_Product_table_Stock_table1_idx` (`Stock_table_idStock_table` ASC) VISIBLE,
  INDEX `fk_Product_table_ShoppingHistory_table1_idx` (`ShoppingHistory_table_idShoppingHistory_tabel` ASC) VISIBLE,
  CONSTRAINT `fk_Product_table_Stock_table1`
    FOREIGN KEY (`Stock_table_idStock_table`)
    REFERENCES `mydb`.`Stock_table` (`idStock_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_table_ShoppingHistory_table1`
    FOREIGN KEY (`ShoppingHistory_table_idShoppingHistory_tabel`)
    REFERENCES `mydb`.`ShoppingHistory_table` (`idShoppingHistory_tabel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_tabel_has_Product_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order_tabel_has_Product_table` (
  `Order_tabel_idOrder_tabel` INT NOT NULL,
  `Product_table_idProduct_table` INT NOT NULL,
  PRIMARY KEY (`Order_tabel_idOrder_tabel`, `Product_table_idProduct_table`),
  INDEX `fk_Order_tabel_has_Product_table_Product_table1_idx` (`Product_table_idProduct_table` ASC) VISIBLE,
  INDEX `fk_Order_tabel_has_Product_table_Order_tabel1_idx` (`Order_tabel_idOrder_tabel` ASC) VISIBLE,
  CONSTRAINT `fk_Order_tabel_has_Product_table_Order_tabel1`
    FOREIGN KEY (`Order_tabel_idOrder_tabel`)
    REFERENCES `mydb`.`Order_tabel` (`idOrder_tabel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_tabel_has_Product_table_Product_table1`
    FOREIGN KEY (`Product_table_idProduct_table`)
    REFERENCES `mydb`.`Product_table` (`idProduct_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ShoppingCart_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ShoppingCart_table` (
  `idShoppingCart_table` INT NOT NULL,
  `user_id` INT NOT NULL,
  `seller_id` INT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `total_price` INT NULL,
  `create_at` DATE NOT NULL,
  PRIMARY KEY (`idShoppingCart_table`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`User_table` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WhishList_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`WhishList_table` (
  `idWhishList_table` INT NOT NULL,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `create_at` DATE NOT NULL,
  `update_at` DATE NULL,
  PRIMARY KEY (`idWhishList_table`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `member_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`User_table` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`Product_table` (`product_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ShoppingCart_table_has_Product_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ShoppingCart_table_has_Product_table` (
  `ShoppingCart_table_idShoppingCart_table` INT NOT NULL,
  `Product_table_idProduct_table` INT NOT NULL,
  `Product_table_Stock_table_idStock_table` INT NOT NULL,
  PRIMARY KEY (`ShoppingCart_table_idShoppingCart_table`, `Product_table_idProduct_table`, `Product_table_Stock_table_idStock_table`),
  INDEX `fk_ShoppingCart_table_has_Product_table_Product_table1_idx` (`Product_table_idProduct_table` ASC, `Product_table_Stock_table_idStock_table` ASC) VISIBLE,
  INDEX `fk_ShoppingCart_table_has_Product_table_ShoppingCart_table1_idx` (`ShoppingCart_table_idShoppingCart_table` ASC) VISIBLE,
  CONSTRAINT `fk_ShoppingCart_table_has_Product_table_ShoppingCart_table1`
    FOREIGN KEY (`ShoppingCart_table_idShoppingCart_table`)
    REFERENCES `mydb`.`ShoppingCart_table` (`idShoppingCart_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ShoppingCart_table_has_Product_table_Product_table1`
    FOREIGN KEY (`Product_table_idProduct_table` , `Product_table_Stock_table_idStock_table`)
    REFERENCES `mydb`.`Product_table` (`idProduct_table` , `Stock_table_idStock_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seller_table_has_Product_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Seller_table_has_Product_table` (
  `Seller_table_idSeller_table` INT NOT NULL,
  `Product_table_idProduct_table` INT NOT NULL,
  `Product_table_Stock_table_idStock_table` INT NOT NULL,
  PRIMARY KEY (`Seller_table_idSeller_table`, `Product_table_idProduct_table`, `Product_table_Stock_table_idStock_table`),
  INDEX `fk_Seller_table_has_Product_table_Product_table1_idx` (`Product_table_idProduct_table` ASC, `Product_table_Stock_table_idStock_table` ASC) VISIBLE,
  INDEX `fk_Seller_table_has_Product_table_Seller_table1_idx` (`Seller_table_idSeller_table` ASC) VISIBLE,
  CONSTRAINT `fk_Seller_table_has_Product_table_Seller_table1`
    FOREIGN KEY (`Seller_table_idSeller_table`)
    REFERENCES `mydb`.`Seller_table` (`idSeller_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seller_table_has_Product_table_Product_table1`
    FOREIGN KEY (`Product_table_idProduct_table` , `Product_table_Stock_table_idStock_table`)
    REFERENCES `mydb`.`Product_table` (`idProduct_table` , `Stock_table_idStock_table`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
