-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Янв 19 2022 г., 20:59
-- Версия сервера: 8.0.19
-- Версия PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `rust`
--

-- --------------------------------------------------------

--
-- Структура таблицы `codes`
--

CREATE TABLE `codes` (
  `id` int UNSIGNED NOT NULL COMMENT 'ID code',
  `code` varchar(4) DEFAULT NULL COMMENT 'code'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stored codes by Rust';

--
-- Дамп данных таблицы `codes`
--

INSERT INTO `codes` (`id`, `code`) VALUES
(1, '5885'),
(2, '8558');

-- --------------------------------------------------------

--
-- Структура таблицы `collected_codes`
--

CREATE TABLE `collected_codes` (
  `id` int NOT NULL,
  `code` int NOT NULL,
  `count` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Collected codes';

--
-- Дамп данных таблицы `collected_codes`
--

INSERT INTO `collected_codes` (`id`, `code`, `count`) VALUES
(1, 5886, 3),
(2, 5887, 2),
(3, 5881, 1),
(4, 5883, 12),
(5, 5888, 1),
(6, 5889, 2),
(7, 5882, 5),
(8, 9898, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `codes`
--
ALTER TABLE `codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Индексы таблицы `collected_codes`
--
ALTER TABLE `collected_codes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `codes`
--
ALTER TABLE `codes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID code', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `collected_codes`
--
ALTER TABLE `collected_codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
