create database trabfdb2;
USE `trabfdb2`;

DROP TABLE IF EXISTS `Jogador`;
CREATE TABLE `Jogador`
(
    `jogador_api_id`  int,
    `nome`            varchar(50),
    `data_nascimento` datetime,
    `nacionalidade`   varchar(45),
    `altura`          decimal(5, 2),
    `peso`            int,
    PRIMARY KEY (`jogador_api_id`)
);

DROP TABLE IF EXISTS `Valor_Jogador`;
CREATE TABLE `Valor_Jogador`
(
    `jogador_api_id` int,
    `temporada_ini`  int,
    `temporada_fim`  int,
    `valor_euros`    long,
    primary key (`jogador_api_id`, `temporada_ini`),
    foreign key (`jogador_api_id`) references `Jogador` (`jogador_api_id`)
);

DROP TABLE IF EXISTS `Time`;
CREATE TABLE `Time`
(
    `id_time`    int,
    `time_nome`  varchar(50),
    `time_sigla` varchar(10),
    primary key (`id_time`)
);

CREATE TABLE `Liga`
(
    `idLiga`   INT         NOT NULL,
    `nomeLiga` VARCHAR(45) NOT NULL,
    `pais`     VARCHAR(45) NOT NULL,
    `divisao`  INT         NOT NULL,
    `numTimes` INT         NOT NULL,
    PRIMARY KEY (`idLiga`)
);

CREATE TABLE `Time_Liga` (
    `idLiga` int,
    `id_time` int,
    primary key (idLiga, id_time),
    foreign key (`id_time`) references `Time` (`id_time`),
    foreign key (`idLiga`) references `Liga` (`idLiga`)
);

drop table if exists `Participacao`;
create table `Participacao`
(
    `id_participacao` int auto_increment,
    `jogador_api_id`  int,
    `temporada_ini`   int,
    `temporada_fim`   int,
    `id_time`         int,
    primary key (`id_participacao`),
    foreign key (`jogador_api_id`) references `Jogador` (`jogador_api_id`),
    foreign key (`id_time`) references `Time` (`id_time`)
);

drop table if exists `Partida`;
create table `Partida`
(
    `time_da_casa_id`     int,
    `time_convidado_id`   int,
    `gois_time_da_casa`   int,
    `gois_time_convidado` int,
    `data`                datetime,
    `temporada`           int,
    primary key (`time_da_casa_id`, `time_convidado_id`, `data`),
    foreign key (`time_da_casa_id`) references `Time` (`id_time`),
    foreign key (`time_convidado_id`) references `Time` (`id_time`)
);

