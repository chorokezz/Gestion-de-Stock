
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";



CREATE TABLE IF NOT EXISTS `mouvmt` (
  `idmv` int(11) NOT NULL,
  `codeprd` varchar(10) NOT NULL,
  `quantite` int(11) NOT NULL,
  `nature` varchar(20) NOT NULL,
  `date` varchar(10) NOT NULL,
  PRIMARY KEY (`idmv`),
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `mouvmt` (`idmv`, `codeprd`, `quantite`, `nature`, `date`) VALUES
(1, 'sv', 120, 'depot', '17-12-2020'),
(2, 'ncf', 60, 'depot', '04-06-2018'),
(3, 'nd', 45, 'depot', '23-10-2019'),
(4, 'sr', 30, 'depot', '11-11-2019'),
(5, 'sr', 2, 'Retrait', '06-09-2020'),
(6, 'sp', 80, 'depot', '08-07-2019'),
(7, 'sp', 4, 'Retrait', '17-09-2019');


CREATE TABLE IF NOT EXISTS `produit` (
  `codeProd` varchar(10) NOT NULL,
  `nomProd` varchar(30) NOT NULL,
  `prix`   int(5) NOT NULL,
  PRIMARY KEY (`codeProd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `produit`
--

INSERT INTO `produit` (`codeProd`, `nomProd`, `prix`) VALUES
('mayo', 'mayonnaise', 1300),
('ncf', 'nescafe', 750),
('nd', 'nido', 2750),
('scr', 'sucre en paquet', 1000),
('sp', 'spagueti', 500),
('sr', 'sardine', 500),
('sv', 'savon', 350),
('tmt', 'tomate en boite', 700);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue1`
--
CREATE TABLE IF NOT EXISTS `vue1` (
`codeprod` varchar(10)
,`nomprod` varchar(100)
,`prix` int(11)
,`qte` bigint(12)
,`nature` varchar(20)
,`date` varchar(10)
);

--
-- Structure de la vue `vue1`
--
DROP TABLE IF EXISTS `vue1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`user`@`localhost` SQL SECURITY DEFINER VIEW `vue1` AS select `produit`.`codeProd` AS `codeProd`,`produit`.`nomProd` AS `nomProd`,`produit`.`prix` AS `prix`,-(`mouvmt`.`quantite`) AS `qte`,`mouvmt`.`nature` AS `nature`,`mouvmt`.`date` AS `date` from (`produit` join `mouvmt` on((`produit`.`codeprod` = `mouvmt`.`codeprd`))) where (`mouvmt`.`nature` = 'retrait') union select `produit`.`codeProd` AS `codeProd`,`produit`.`nomProd` AS `nomProd`,`produit`.`prix` AS `prix`,`mouvmt`.`quantite` AS `qte`,`mouvmt`.`nature` AS `nature`,`mouvmt`.`date` AS `date` from (`produit` join `mouvmt` on((`produit`.`codeProd` = `mouvmt`.`codeprd`))) where (`mouvmt`.`nature` = 'depot');


ALTER TABLE `mouvmt`
  ADD CONSTRAINT `fk1` FOREIGN KEY (`codeprd`) REFERENCES `produit` (`codeprod`);

