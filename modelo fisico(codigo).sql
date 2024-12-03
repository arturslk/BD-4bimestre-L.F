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
-- Table `mydb`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venda` (
  `idproduto` INT NOT NULL,
  `data` DATE NOT NULL,
  `valor-total` DECIMAL NOT NULL,
  PRIMARY KEY (`idproduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mesa` (
  `idmesa` INT NOT NULL DEFAULT 7,
  PRIMARY KEY (`idmesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `id` INT NOT NULL,
  `mesa-id` INT NOT NULL,
  `data-pedido` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `total` DECIMAL(2) NOT NULL,
  `venda_idproduto` INT NOT NULL,
  `mesa_idmesa` INT NOT NULL,
  PRIMARY KEY (`id`, `venda_idproduto`),
  INDEX `fk_pedido_venda1_idx` (`venda_idproduto` ASC) VISIBLE,
  INDEX `fk_pedido_mesa1_idx` (`mesa_idmesa` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_venda1`
    FOREIGN KEY (`venda_idproduto`)
    REFERENCES `mydb`.`venda` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_mesa1`
    FOREIGN KEY (`mesa_idmesa`)
    REFERENCES `mydb`.`mesa` (`idmesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `idcategorias` INT NOT NULL,
  `descrição` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produto` (
  `id` INT NOT NULL,
  `descricao-produto` VARCHAR(45) NOT NULL,
  `preco` INT NOT NULL,
  `estoque` INT NOT NULL,
  `pedidos_id` INT NOT NULL,
  `categoria_idcategorias` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produtos_pedidos1_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_produto_categoria1_idx` (`categoria_idcategorias` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_pedidos1`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `mydb`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_categoria1`
    FOREIGN KEY (`categoria_idcategorias`)
    REFERENCES `mydb`.`categoria` (`idcategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
