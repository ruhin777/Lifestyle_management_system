-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 07, 2025 at 05:19 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE `lifestyle_management`;
USE `lifestyle_management`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lifestyle_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `affects`
--

CREATE TABLE `affects` (
  `id` int(10) UNSIGNED NOT NULL,
  `food_restriction_id` varchar(100) NOT NULL,
  `food_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `affects`
--

INSERT INTO `affects` (`id`, `food_restriction_id`, `food_id`) VALUES
(1, 'FR001', 'F002'),
(2, 'FR001', 'F007'),
(3, 'FR002', 'F010'),
(4, 'FR003', 'F006'),
(5, 'FR004', 'F009'),
(6, 'FR005', 'F011'),
(7, 'FR006', 'F015'),
(8, 'FR007', 'F020'),
(9, 'FR008', 'F018'),
(10, 'FR009', 'F029'),
(11, 'FR010', 'F025'),
(12, 'FR011', 'F028'),
(13, 'FR012', 'F023'),
(14, 'FR013', 'F027'),
(15, 'FR014', 'F030'),
(16, 'FR015', 'F021'),
(17, 'FR016', 'F025'),
(18, 'FR017', 'F028'),
(19, 'FR018', 'F030'),
(20, 'FR019', 'F031'),
(21, 'FR020', 'F031');

-- --------------------------------------------------------

--
-- Table structure for table `applies_to`
--

CREATE TABLE `applies_to` (
  `id` int(10) UNSIGNED NOT NULL,
  `exercise_restriction_id` varchar(100) NOT NULL,
  `exercise_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applies_to`
--

INSERT INTO `applies_to` (`id`, `exercise_restriction_id`, `exercise_id`) VALUES
(1, 'ER001', 'E001'),
(2, 'ER001', 'E006'),
(3, 'ER002', 'E004'),
(4, 'ER003', 'E001'),
(5, 'ER004', 'E003'),
(6, 'ER005', 'E011'),
(7, 'ER006', 'E008'),
(8, 'ER007', 'E012'),
(9, 'ER008', 'E007'),
(10, 'ER009', 'E014'),
(11, 'ER010', 'E020'),
(12, 'ER011', 'E016'),
(13, 'ER012', 'E018'),
(14, 'ER013', 'E015'),
(15, 'ER014', 'E022'),
(16, 'ER015', 'E017'),
(17, 'ER016', 'E013'),
(18, 'ER017', 'E021'),
(19, 'ER018', 'E019');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add habit', 7, 'add_habit'),
(26, 'Can change habit', 7, 'change_habit'),
(27, 'Can delete habit', 7, 'delete_habit'),
(28, 'Can view habit', 7, 'view_habit'),
(29, 'Can add affects', 8, 'add_affects'),
(30, 'Can change affects', 8, 'change_affects'),
(31, 'Can delete affects', 8, 'delete_affects'),
(32, 'Can view affects', 8, 'view_affects'),
(33, 'Can add applies to', 9, 'add_appliesto'),
(34, 'Can change applies to', 9, 'change_appliesto'),
(35, 'Can delete applies to', 9, 'delete_appliesto'),
(36, 'Can view applies to', 9, 'view_appliesto'),
(37, 'Can add dietplan', 10, 'add_dietplan'),
(38, 'Can change dietplan', 10, 'change_dietplan'),
(39, 'Can delete dietplan', 10, 'delete_dietplan'),
(40, 'Can view dietplan', 10, 'view_dietplan'),
(41, 'Can add exercise', 11, 'add_exercise'),
(42, 'Can change exercise', 11, 'change_exercise'),
(43, 'Can delete exercise', 11, 'delete_exercise'),
(44, 'Can view exercise', 11, 'view_exercise'),
(45, 'Can add exercise restriction', 12, 'add_exerciserestriction'),
(46, 'Can change exercise restriction', 12, 'change_exerciserestriction'),
(47, 'Can delete exercise restriction', 12, 'delete_exerciserestriction'),
(48, 'Can view exercise restriction', 12, 'view_exerciserestriction'),
(49, 'Can add food nutrition', 13, 'add_foodnutrition'),
(50, 'Can change food nutrition', 13, 'change_foodnutrition'),
(51, 'Can delete food nutrition', 13, 'delete_foodnutrition'),
(52, 'Can view food nutrition', 13, 'view_foodnutrition'),
(53, 'Can add food restriction', 14, 'add_foodrestriction'),
(54, 'Can change food restriction', 14, 'change_foodrestriction'),
(55, 'Can delete food restriction', 14, 'delete_foodrestriction'),
(56, 'Can view food restriction', 14, 'view_foodrestriction'),
(57, 'Can add health problem', 15, 'add_healthproblem'),
(58, 'Can change health problem', 15, 'change_healthproblem'),
(59, 'Can delete health problem', 15, 'delete_healthproblem'),
(60, 'Can view health problem', 15, 'view_healthproblem'),
(61, 'Can add includes', 16, 'add_includes'),
(62, 'Can change includes', 16, 'change_includes'),
(63, 'Can delete includes', 16, 'delete_includes'),
(64, 'Can view includes', 16, 'view_includes'),
(65, 'Can add suffers from', 17, 'add_suffersfrom'),
(66, 'Can change suffers from', 17, 'change_suffersfrom'),
(67, 'Can delete suffers from', 17, 'delete_suffersfrom'),
(68, 'Can view suffers from', 17, 'view_suffersfrom'),
(69, 'Can add user', 18, 'add_user'),
(70, 'Can change user', 18, 'change_user'),
(71, 'Can delete user', 18, 'delete_user'),
(72, 'Can view user', 18, 'view_user'),
(73, 'Can add custom profile', 19, 'add_customprofile'),
(74, 'Can change custom profile', 19, 'change_customprofile'),
(75, 'Can delete custom profile', 19, 'delete_customprofile'),
(76, 'Can view custom profile', 19, 'view_customprofile'),
(77, 'Can add food preference', 20, 'add_foodpreference'),
(78, 'Can change food preference', 20, 'change_foodpreference'),
(79, 'Can delete food preference', 20, 'delete_foodpreference'),
(80, 'Can view food preference', 20, 'view_foodpreference'),
(81, 'Can add exercise preference', 21, 'add_exercisepreference'),
(82, 'Can change exercise preference', 21, 'change_exercisepreference'),
(83, 'Can delete exercise preference', 21, 'delete_exercisepreference'),
(84, 'Can view exercise preference', 21, 'view_exercisepreference');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$XiG7FpB9zfhr6AIjjJ25oa$5mZ6KXf3oTlwui2SImKV6DgMtJOoyLBbUMSM28GU1Wo=', '2025-08-31 02:18:46.009693', 1, 'lifestyle', '', '', 'ruhinproject@gmail.com', 1, 1, '2025-08-27 13:57:29.403044');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dietplan`
--

CREATE TABLE `dietplan` (
  `diet_plan_id` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `meal` char(10) NOT NULL,
  `total_calories` double NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dietplan`
--

INSERT INTO `dietplan` (`diet_plan_id`, `date`, `meal`, `total_calories`, `user_id`, `created_at`) VALUES
('D001', '2025-08-28', 'Breakfast', 420, 'U001', NULL),
('D002', '2025-08-28', 'Lunch', 650, 'U001', NULL),
('D003', '2025-08-28', 'Dinner', 700, 'U002', NULL),
('D004', '2025-08-28', 'Breakfast', 350, 'U003', NULL),
('D005', '2025-08-28', 'Lunch', 520, 'U003', NULL),
('D006', '2025-08-28', 'Dinner', 600, 'U004', NULL),
('DP001', '2025-09-05', 'Breakfast', 118, 'U001', '2025-09-05 12:18:33'),
('DP002', '2025-09-05', 'Breakfast', 222, 'U001', '2025-09-05 12:18:33'),
('DP003', '2025-09-05', 'Breakfast', 134.4, 'U001', '2025-09-05 12:18:33'),
('DP004', '2025-09-05', 'Lunch', 416, 'U001', '2025-09-05 12:18:33'),
('DP005', '2025-09-05', 'Dinner', 330, 'U001', '2025-09-05 12:18:33'),
('DP006', '2025-09-05', 'Snack', 46, 'U001', '2025-09-05 12:18:33'),
('DP007', '2025-09-05', 'Breakfast', 260, 'U004', '2025-09-05 16:24:04'),
('DP008', '2025-09-05', 'Breakfast', 222, 'U004', '2025-09-05 16:24:04'),
('DP009', '2025-09-05', 'Breakfast', 178, 'U004', '2025-09-05 16:24:04'),
('DP010', '2025-09-05', 'Breakfast', 29.5, 'U004', '2025-09-05 16:24:04'),
('DP011', '2025-09-05', 'Lunch', 330, 'U004', '2025-09-05 16:24:04'),
('DP012', '2025-09-05', 'Dinner', 416, 'U004', '2025-09-05 16:24:04'),
('DP013', '2025-09-05', 'Snack', 46, 'U004', '2025-09-05 16:24:04'),
('DP014', '2025-09-05', 'Snack', 84, 'U004', '2025-09-05 16:24:04'),
('DP032', '2025-09-06', 'Breakfast', 130, 'U004', '2025-09-06 10:49:31'),
('DP033', '2025-09-06', 'Breakfast', 19.8, 'U004', '2025-09-06 10:49:31'),
('DP034', '2025-09-06', 'Breakfast', 130.83, 'U004', '2025-09-06 10:49:31'),
('DP035', '2025-09-06', 'Breakfast', 83.19, 'U004', '2025-09-06 10:49:31'),
('DP036', '2025-09-06', 'Lunch', 603, 'U004', '2025-09-06 10:49:31'),
('DP037', '2025-09-06', 'Lunch', 128.4, 'U004', '2025-09-06 10:49:31'),
('DP038', '2025-09-06', 'Lunch', 165.6, 'U004', '2025-09-06 10:49:31'),
('DP039', '2025-09-06', 'Dinner', 164.28, 'U004', '2025-09-06 10:49:31'),
('DP040', '2025-09-06', 'Dinner', 399, 'U004', '2025-09-06 10:49:31'),
('DP041', '2025-09-06', 'Dinner', 146.85, 'U004', '2025-09-06 10:49:31'),
('DP042', '2025-09-06', 'Dinner', 31.2, 'U004', '2025-09-06 10:49:31'),
('DP043', '2025-09-06', 'Snack', 78.88, 'U004', '2025-09-06 10:49:31'),
('DP044', '2025-09-06', 'Breakfast', 156, 'U008', '2025-09-06 13:57:40'),
('DP045', '2025-09-06', 'Breakfast', 138.04, 'U008', '2025-09-06 13:57:40'),
('DP046', '2025-09-06', 'Breakfast', 100.57, 'U008', '2025-09-06 13:57:40'),
('DP047', '2025-09-06', 'Breakfast', 61.95, 'U008', '2025-09-06 13:57:40'),
('DP048', '2025-09-06', 'Lunch', 172.8, 'U008', '2025-09-06 13:57:40'),
('DP049', '2025-09-06', 'Lunch', 126.54, 'U008', '2025-09-06 13:57:40'),
('DP050', '2025-09-06', 'Lunch', 161.7, 'U008', '2025-09-06 13:57:40'),
('DP051', '2025-09-06', 'Lunch', 29.9, 'U008', '2025-09-06 13:57:40'),
('DP052', '2025-09-06', 'Dinner', 140.4, 'U008', '2025-09-06 13:57:40'),
('DP053', '2025-09-06', 'Dinner', 220.48, 'U008', '2025-09-06 13:57:40'),
('DP054', '2025-09-06', 'Dinner', 60.06, 'U008', '2025-09-06 13:57:40'),
('DP055', '2025-09-06', 'Snack', 135.85, 'U008', '2025-09-06 13:57:40'),
('DP056', '2025-09-06', 'Breakfast', 222, 'U001', '2025-09-06 16:13:16'),
('DP057', '2025-09-06', 'Breakfast', 75.73, 'U001', '2025-09-06 16:13:16'),
('DP058', '2025-09-06', 'Breakfast', 95, 'U001', '2025-09-06 16:13:16'),
('DP059', '2025-09-06', 'Breakfast', 59, 'U001', '2025-09-06 16:13:16'),
('DP060', '2025-09-06', 'Lunch', 240, 'U001', '2025-09-06 16:13:16'),
('DP061', '2025-09-06', 'Lunch', 148.48, 'U001', '2025-09-06 16:13:16'),
('DP062', '2025-09-06', 'Lunch', 57.5, 'U001', '2025-09-06 16:13:16'),
('DP063', '2025-09-06', 'Lunch', 151.82, 'U001', '2025-09-06 16:13:16'),
('DP064', '2025-09-06', 'Dinner', 321.6, 'U001', '2025-09-06 16:13:16'),
('DP065', '2025-09-06', 'Dinner', 124.8, 'U001', '2025-09-06 16:13:16'),
('DP066', '2025-09-06', 'Dinner', 39, 'U001', '2025-09-06 16:13:16'),
('DP067', '2025-09-06', 'Dinner', 70, 'U001', '2025-09-06 16:13:16'),
('DP068', '2025-09-06', 'Snack', 100, 'U001', '2025-09-06 16:13:16'),
('DP069', '2025-09-06', 'Snack', 70.8, 'U001', '2025-09-06 16:13:16'),
('DP070', '2025-09-06', 'Snack', 30, 'U001', '2025-09-06 16:13:16'),
('DP071', '2025-09-06', 'Breakfast', 209.41, 'U005', '2025-09-06 16:26:23'),
('DP072', '2025-09-06', 'Breakfast', 69.6, 'U005', '2025-09-06 16:26:23'),
('DP073', '2025-09-06', 'Breakfast', 89, 'U005', '2025-09-06 16:26:23'),
('DP074', '2025-09-06', 'Breakfast', 59, 'U005', '2025-09-06 16:26:23'),
('DP075', '2025-09-06', 'Lunch', 205.22, 'U005', '2025-09-06 16:26:23'),
('DP076', '2025-09-06', 'Lunch', 152.45, 'U005', '2025-09-06 16:26:23'),
('DP077', '2025-09-06', 'Lunch', 99, 'U005', '2025-09-06 16:26:23'),
('DP078', '2025-09-06', 'Lunch', 32.42, 'U005', '2025-09-06 16:26:23'),
('DP079', '2025-09-06', 'Lunch', 38.62, 'U005', '2025-09-06 16:26:23'),
('DP080', '2025-09-06', 'Dinner', 175.9, 'U005', '2025-09-06 16:26:23'),
('DP081', '2025-09-06', 'Dinner', 130.67, 'U005', '2025-09-06 16:26:23'),
('DP082', '2025-09-06', 'Dinner', 49, 'U005', '2025-09-06 16:26:23'),
('DP083', '2025-09-06', 'Dinner', 96.74, 'U005', '2025-09-06 16:26:23'),
('DP084', '2025-09-06', 'Dinner', 30, 'U005', '2025-09-06 16:26:23'),
('DP085', '2025-09-06', 'Snack', 117.27, 'U005', '2025-09-06 16:26:23'),
('DP086', '2025-09-06', 'Snack', 80.4, 'U005', '2025-09-06 16:26:23'),
('DP087', '2025-09-06', 'Breakfast', 95, 'U009', '2025-09-06 17:03:58'),
('DP088', '2025-09-06', 'Breakfast', 156.84, 'U009', '2025-09-06 17:03:58'),
('DP089', '2025-09-06', 'Breakfast', 69.6, 'U009', '2025-09-06 17:03:58'),
('DP090', '2025-09-06', 'Breakfast', 89, 'U009', '2025-09-06 17:03:58'),
('DP091', '2025-09-06', 'Lunch', 105, 'U009', '2025-09-06 17:03:58'),
('DP092', '2025-09-06', 'Lunch', 186.87, 'U009', '2025-09-06 17:03:58'),
('DP093', '2025-09-06', 'Lunch', 99, 'U009', '2025-09-06 17:03:58'),
('DP094', '2025-09-06', 'Lunch', 45.32, 'U009', '2025-09-06 17:03:58'),
('DP095', '2025-09-06', 'Lunch', 78.76, 'U009', '2025-09-06 17:03:58'),
('DP096', '2025-09-06', 'Lunch', 30, 'U009', '2025-09-06 17:03:58'),
('DP097', '2025-09-06', 'Dinner', 171.65, 'U009', '2025-09-06 17:03:58'),
('DP098', '2025-09-06', 'Dinner', 127.51, 'U009', '2025-09-06 17:03:58'),
('DP099', '2025-09-06', 'Dinner', 47.82, 'U009', '2025-09-06 17:03:58'),
('DP100', '2025-09-06', 'Dinner', 94.41, 'U009', '2025-09-06 17:03:58'),
('DP101', '2025-09-06', 'Snack', 100, 'U009', '2025-09-06 17:03:58'),
('DP102', '2025-09-06', 'Snack', 59, 'U009', '2025-09-06 17:03:58'),
('DP103', '2025-09-07', 'Breakfast', 222, 'U001', '2025-09-07 02:21:50'),
('DP104', '2025-09-07', 'Breakfast', 75.73, 'U001', '2025-09-07 02:21:50'),
('DP105', '2025-09-07', 'Breakfast', 95, 'U001', '2025-09-07 02:21:50'),
('DP106', '2025-09-07', 'Breakfast', 59, 'U001', '2025-09-07 02:21:50'),
('DP107', '2025-09-07', 'Lunch', 232.48, 'U001', '2025-09-07 02:21:50'),
('DP108', '2025-09-07', 'Lunch', 172.7, 'U001', '2025-09-07 02:21:50'),
('DP109', '2025-09-07', 'Lunch', 99, 'U001', '2025-09-07 02:21:50'),
('DP110', '2025-09-07', 'Lunch', 40.01, 'U001', '2025-09-07 02:21:50'),
('DP111', '2025-09-07', 'Lunch', 80.4, 'U001', '2025-09-07 02:21:50'),
('DP112', '2025-09-07', 'Dinner', 321.6, 'U001', '2025-09-07 02:21:50'),
('DP113', '2025-09-07', 'Dinner', 124.8, 'U001', '2025-09-07 02:21:50'),
('DP114', '2025-09-07', 'Dinner', 39, 'U001', '2025-09-07 02:21:50'),
('DP115', '2025-09-07', 'Dinner', 70, 'U001', '2025-09-07 02:21:50'),
('DP116', '2025-09-07', 'Snack', 100, 'U001', '2025-09-07 02:21:50'),
('DP117', '2025-09-07', 'Snack', 70.8, 'U001', '2025-09-07 02:21:50'),
('DP118', '2025-09-07', 'Snack', 30, 'U001', '2025-09-07 02:21:50');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(8, 'lifestyle', 'affects'),
(9, 'lifestyle', 'appliesto'),
(19, 'lifestyle', 'customprofile'),
(10, 'lifestyle', 'dietplan'),
(11, 'lifestyle', 'exercise'),
(21, 'lifestyle', 'exercisepreference'),
(12, 'lifestyle', 'exerciserestriction'),
(13, 'lifestyle', 'foodnutrition'),
(20, 'lifestyle', 'foodpreference'),
(14, 'lifestyle', 'foodrestriction'),
(7, 'lifestyle', 'habit'),
(15, 'lifestyle', 'healthproblem'),
(16, 'lifestyle', 'includes'),
(17, 'lifestyle', 'suffersfrom'),
(18, 'lifestyle', 'user'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-08-27 13:53:31.005537'),
(2, 'auth', '0001_initial', '2025-08-27 13:53:32.026922'),
(3, 'admin', '0001_initial', '2025-08-27 13:53:32.240776'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-08-27 13:53:32.262108'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-08-27 13:53:32.284798'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-08-27 13:53:32.389869'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-08-27 13:53:32.525957'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-08-27 13:53:32.570156'),
(9, 'auth', '0004_alter_user_username_opts', '2025-08-27 13:53:32.612841'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-08-27 13:53:32.737363'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-08-27 13:53:32.752509'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-08-27 13:53:32.784748'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-08-27 13:53:32.823910'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-08-27 13:53:32.865417'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-08-27 13:53:32.907605'),
(16, 'auth', '0011_update_proxy_permissions', '2025-08-27 13:53:32.941007'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-08-27 13:53:32.983149'),
(18, 'sessions', '0001_initial', '2025-08-27 13:53:33.068392'),
(19, 'lifestyle', '0001_initial', '2025-08-27 14:33:16.996025'),
(20, 'lifestyle', '0002_customprofile', '2025-09-01 18:45:34.552254'),
(21, 'lifestyle', '0003_delete_customprofile', '2025-09-01 19:48:39.792487'),
(22, 'lifestyle', '0004_foodpreference_exercisepreference', '2025-09-04 17:52:04.402248'),
(23, 'lifestyle', '0005_alter_suffersfrom_options', '2025-09-04 19:27:26.955938'),
(24, 'lifestyle', '0006_alter_suffersfrom_options', '2025-09-04 19:32:23.835861');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('astgzsmgxpd6tw3mr7yxd3865j7pyanu', '.eJxVjMEOwiAQRP-FsyHQIu169O43kF3YlaqBpLQn47_bJj3oaZJ5b-atAq5LDmvjOUxJXZRVp9-OMD657CA9sNyrjrUs80R6V_RBm77VxK_r4f4dZGx5WzM6pjH1YBmpA58GA-wFII2GwDhmK0aIzRYerRN2NBjpI_EZOy_q8wUIDTjy:1us0Tq:nqqCWX6uPrflkxtKEhak7mi_3xIskhpnOzW7e6CpQ94', '2025-09-12 14:53:30.611420'),
('ucfr9apwqli8efblnb0476gm3z7trt7l', '.eJxVjsEOwiAQRP-FsyFLi7R49O7RM9mFRaoGktKejP8uTZqop0lm3kzmJRyuS3Jr5dlNQZyEEodfj9A_OG9BuGO-FelLXuaJ5IbIPa3yUgI_zzv7N5CwptZm1Exj6K1ipM6aMIBlE60NI5AFzawiRGJoYlDpyJoGiL0nPmJnYhv9frwCKPH-APwKPbE:1uv5ma:Ykj4e9OFzqOUYszHknLFEMbEXFDDFbd5zXnCC6Up3J4', '2025-09-21 03:09:36.740855'),
('vlz8hdi18o5mvmznjjuii0mz6d4q1bwm', '.eJxVjsEOwiAQRP-FsyFLi7R49O7RM9mFRaoGktKejP8uTZqop0lm3kzmJRyuS3Jr5dlNQZyEEodfj9A_OG9BuGO-FelLXuaJ5IbIPa3yUgI_zzv7N5CwptZm1Exj6K1ipM6aMIBlE60NI5AFzawiRGJoYlDpyJoGiL0nPmJnYhv9frwCKPH-APwKPbE:1uuaHS:Y2QaVZOTZuLyt915k0fXvyhPvScQ49O-F96TLtGENsY', '2025-09-19 17:31:22.293813');

-- --------------------------------------------------------

--
-- Table structure for table `exercise`
--

CREATE TABLE `exercise` (
  `exercise_id` varchar(100) NOT NULL,
  `exercise_name` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `calories_burned_per_hour` double NOT NULL,
  `benefits` varchar(200) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `min_bmi` float DEFAULT 0,
  `max_bmi` float DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise`
--

INSERT INTO `exercise` (`exercise_id`, `exercise_name`, `type`, `calories_burned_per_hour`, `benefits`, `user_id`, `min_bmi`, `max_bmi`) VALUES
('E001', 'Running', 'Cardio', 600, 'Improves cardiovascular fitness', 'U001', 18.5, 24.9),
('E002', 'Cycling', 'Cardio', 550, 'Low-impact endurance', 'U001', 18.5, 24.9),
('E003', 'Swimming', 'Cardio', 500, 'Full-body, joint-friendly', 'U002', 18.5, 24.9),
('E004', 'Squats', 'Strength', 400, 'Builds leg and core strength', 'U003', 25, 29.9),
('E005', 'Yoga', 'Flexibility', 180, 'Mobility and stress reduction', 'U004', 18.5, 29.9),
('E006', 'Jumping Jacks', 'Cardio', 650, 'High-intensity, warms up quickly', 'U004', 18.5, 24.9),
('E007', 'Brisk Walking', 'Cardio', 280, 'Improves stamina, safe for joints', 'U001', 18.5, 29.9),
('E008', 'Light Jogging', 'Cardio', 400, 'Boosts endurance, weight control', 'U002', 18.5, 24.9),
('E009', 'Stretching', 'Flexibility', 120, 'Improves mobility, reduces stiffness', 'U003', 18.5, 100),
('E010', 'Meditation & Breathing', 'Mind-Body', 50, 'Relaxes lungs, reduces stress', 'U004', 18.5, 100),
('E011', 'Resistance Band Training', 'Strength', 250, 'Muscle tone without joint strain', 'U002', 18.5, 29.9),
('E012', 'Walking Upstairs', 'Cardio', 350, 'Boosts heart health, strengthens legs', 'U003', 18.5, 29.9),
('E013', 'Morning Walk', 'Cardio', 200, 'Good for seniors, improves heart health', 'U001', 18.5, 100),
('E014', 'Light Cycling Indoors', 'Cardio', 220, 'Safe alternative during heat stroke risk', 'U002', 18.5, 29.9),
('E015', 'Chair Yoga', 'Flexibility', 80, 'Gentle movements for joint pain', 'U003', 18.5, 100),
('E016', 'Eye Relaxation Exercises', 'Mind-Body', 30, 'Reduces eye strain from screens', 'U004', 18.5, 100),
('E017', 'Slow Dance', 'Cardio', 150, 'Light enjoyable exercise, reduces stress', 'U001', 18.5, 29.9),
('E018', 'Hydration Break Stretching', 'Flexibility', 50, 'Reminds to hydrate and loosen muscles', 'U002', 18.5, 100),
('E019', 'Mindful Breathing', 'Mind-Body', 40, 'Reduces anxiety and improves sleep', 'U003', 18.5, 100),
('E020', 'Wall Pushups', 'Strength', 100, 'Beginner-friendly upper body strength', 'U004', 18.5, 29.9),
('E021', 'Step Touch Aerobics', 'Cardio', 250, 'Simple indoor cardio, burns calories', 'U001', 18.5, 29.9),
('E022', 'Gentle Stretch Before Bed', 'Flexibility', 40, 'Promotes relaxation and sleep', 'U002', 18.5, 100);

-- --------------------------------------------------------

--
-- Table structure for table `exercise_preference`
--

CREATE TABLE `exercise_preference` (
  `id` int(11) NOT NULL,
  `allowed` tinyint(1) NOT NULL,
  `exercise_id` varchar(100) NOT NULL,
  `user_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise_preference`
--

INSERT INTO `exercise_preference` (`id`, `allowed`, `exercise_id`, `user_id`) VALUES
(6, 1, 'E003', 'U004'),
(7, 1, 'E007', 'U005'),
(8, 1, 'E003', 'U009'),
(10, 1, 'E008', 'U001');

-- --------------------------------------------------------

--
-- Table structure for table `exercise_restriction`
--

CREATE TABLE `exercise_restriction` (
  `exercise_restriction_id` varchar(100) NOT NULL,
  `e_reason` varchar(100) NOT NULL,
  `e_severity` varchar(30) NOT NULL,
  `health_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise_restriction`
--

INSERT INTO `exercise_restriction` (`exercise_restriction_id`, `e_reason`, `e_severity`, `health_id`) VALUES
('ER001', 'High-impact activities', 'High', 'H004'),
('ER002', 'Deep knee flexion under load', 'Medium', 'H004'),
('ER003', 'Very high-intensity cardio spikes BP', 'Low', 'H002'),
('ER004', 'Cold-water swim during flare', 'Low', 'H004'),
('ER005', 'Avoid heavy lifting in anemia', 'Medium', 'H007'),
('ER006', 'Avoid outdoor running in asthma triggers', 'High', 'H006'),
('ER007', 'Avoid prolonged standing in obesity', 'Low', 'H005'),
('ER008', 'Avoid high-impact jumping in gout', 'High', 'H008'),
('ER009', 'Avoid running in heat stroke conditions', 'High', 'H010'),
('ER010', 'Avoid weight training in low blood pressure', 'Medium', 'H012'),
('ER011', 'Avoid long screen workouts in eye strain', 'Low', 'H016'),
('ER012', 'Avoid dehydration during outdoor activities', 'High', 'H009'),
('ER013', 'Avoid high-impact exercises for joint pain', 'High', 'H011'),
('ER014', 'Avoid late-night workouts for sleep disorder', 'Medium', 'H017'),
('ER015', 'Avoid oily environment activities in skin allergy', 'Medium', 'H015'),
('ER016', 'Avoid heavy cardio in gallstone patients', 'High', 'H018'),
('ER017', 'Avoid calorie deficit exercise in malnutrition', 'High', 'H014'),
('ER018', 'Avoid extreme dieting workouts in B12 deficiency', 'Low', 'H013');

-- --------------------------------------------------------

--
-- Table structure for table `food_nutrition`
--

CREATE TABLE `food_nutrition` (
  `food_id` varchar(100) NOT NULL,
  `food_name` varchar(100) NOT NULL,
  `calories_100g` double NOT NULL,
  `protein_100g` double NOT NULL,
  `fat_100g` double NOT NULL,
  `carbs_100g` double NOT NULL,
  `health_benefits` varchar(200) NOT NULL,
  `user_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_nutrition`
--

INSERT INTO `food_nutrition` (`food_id`, `food_name`, `calories_100g`, `protein_100g`, `fat_100g`, `carbs_100g`, `health_benefits`, `user_id`) VALUES
('F001', 'Brown Rice', 111, 2.6, 0.9, 23, 'High fiber; steadier glucose', 'U001'),
('F002', 'White Rice', 130, 2.4, 0.3, 28, 'Energy source; easy to digest', 'U001'),
('F003', 'Chicken Breast (skinless)', 165, 31, 3.6, 0, 'Lean protein for repair', 'U002'),
('F004', 'Salmon', 208, 20, 13, 0, 'Omega-3s for heart health', 'U002'),
('F005', 'Lentils (boiled)', 116, 9, 0.4, 20, 'Plant protein + fiber', 'U003'),
('F006', 'Greek Yogurt (plain)', 59, 10, 0.4, 3.6, 'Probiotics for gut health', 'U003'),
('F007', 'Banana', 89, 1.1, 0.3, 23, 'Potassium for muscles', 'U004'),
('F008', 'Spinach (raw)', 23, 2.9, 0.4, 3.6, 'Iron, folate, antioxidants', 'U004'),
('F009', 'Cola (soft drink)', 42, 0, 0, 11, 'Sugary beverage; minimal benefit', 'U002'),
('F010', 'Canned Soup', 80, 3, 2, 12, 'Convenient; often high sodium', 'U003'),
('F011', 'Hilsa Fish', 310, 25, 22, 0, 'Rich in omega-3, heart health', 'U002'),
('F012', 'Rohu Fish', 97, 17, 2, 0, 'Lean protein, low fat', 'U003'),
('F013', 'Egg Curry', 150, 11, 10, 3, 'Protein and essential fats', 'U004'),
('F014', 'Flatbread (Roti)', 120, 3, 1, 25, 'Whole wheat energy source', 'U001'),
('F015', 'Beef Curry', 250, 26, 15, 2, 'Iron and protein source', 'U002'),
('F016', 'Green Papaya', 39, 0.6, 0.1, 10, 'Aids digestion, high fiber', 'U003'),
('F017', 'Bottle Gourd (Lau)', 14, 0.6, 0.1, 3.4, 'Cooling vegetable, low calories', 'U004'),
('F018', 'Jackfruit (ripe)', 95, 1.7, 0.6, 23, 'Rich in vitamins A & C', 'U001'),
('F019', 'Mustard Oil', 884, 0, 100, 0, 'Used in cooking, omega-3 rich', 'U002'),
('F020', 'Puffed Rice (Muri)', 402, 7, 0.6, 90, 'Light snack, quick energy', 'U003'),
('F021', 'Chickpeas (Chola)', 164, 9, 3, 27, 'Protein and fiber rich, good for weight control', 'U001'),
('F022', 'Mustard Greens (Shorshe Shak)', 26, 2.7, 0.2, 4.7, 'Vitamin K rich, supports bone health', 'U002'),
('F023', 'Radish Curry (Mulo)', 18, 0.8, 0.1, 4, 'Low calorie, good for digestion', 'U003'),
('F024', 'Tilapia Fish', 96, 20, 2, 0, 'Lean protein, affordable fish choice', 'U004'),
('F025', 'Pineapple', 50, 0.5, 0.1, 13, 'Vitamin C and digestive enzymes', 'U001'),
('F026', 'Guava', 68, 2.6, 1, 14, 'High vitamin C, boosts immunity', 'U002'),
('F027', 'Cabbage Curry', 25, 1.3, 0.1, 6, 'Rich in antioxidants, aids digestion', 'U003'),
('F028', 'Duck Curry', 240, 19, 17, 1, 'Iron and protein source', 'U004'),
('F029', 'Green Chili', 40, 2, 0.2, 9, 'Boosts metabolism, vitamin C rich', 'U001'),
('F030', 'Rice Flakes (Chira)', 350, 7, 1, 78, 'Quick energy breakfast food', 'U002'),
('F031', 'Chicken Curry', 180, 18, 10, 5, 'High protein, good source of iron and energy', 'U001');

-- --------------------------------------------------------

--
-- Table structure for table `food_preference`
--

CREATE TABLE `food_preference` (
  `id` int(11) NOT NULL,
  `allowed` tinyint(1) NOT NULL,
  `food_id` varchar(100) NOT NULL,
  `user_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_preference`
--

INSERT INTO `food_preference` (`id`, `allowed`, `food_id`, `user_id`) VALUES
(4, 1, 'F001', 'U004'),
(5, 1, 'F031', 'U005'),
(6, 0, 'F030', 'U005'),
(7, 1, 'F031', 'U008'),
(8, 1, 'F002', 'U008'),
(9, 1, 'F009', 'U009'),
(10, 1, 'F018', 'U009'),
(11, 1, 'F031', 'U001');

-- --------------------------------------------------------

--
-- Table structure for table `food_restriction`
--

CREATE TABLE `food_restriction` (
  `food_restriction_id` varchar(100) NOT NULL,
  `f_reason` varchar(100) NOT NULL,
  `f_severity` varchar(30) NOT NULL,
  `health_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_restriction`
--

INSERT INTO `food_restriction` (`food_restriction_id`, `f_reason`, `f_severity`, `health_id`) VALUES
('FR001', 'High glycemic foods', 'High', 'H001'),
('FR002', 'High sodium foods', 'Medium', 'H002'),
('FR003', 'Lactose-containing dairy', 'High', 'H003'),
('FR004', 'High added-sugar drinks', 'High', 'H001'),
('FR005', 'Avoid oily fish during asthma flare', 'Medium', 'H006'),
('FR006', 'Limit red meat for gout patients', 'High', 'H008'),
('FR007', 'Limit fried snacks for obesity', 'High', 'H005'),
('FR008', 'Avoid tea with meals for anemia', 'Medium', 'H007'),
('FR009', 'Avoid spicy foods during skin allergy', 'Medium', 'H015'),
('FR010', 'Limit caffeine for sleep disorder', 'High', 'H017'),
('FR011', 'Avoid fatty foods in gallstones', 'High', 'H018'),
('FR012', 'Avoid oily curries in malnutrition recovery', 'Low', 'H014'),
('FR013', 'Limit pickles in dehydration risk', 'Medium', 'H009'),
('FR014', 'Avoid prolonged fasting in low blood pressure', 'High', 'H012'),
('FR015', 'Avoid fried snacks in vitamin B12 deficiency', 'Low', 'H013'),
('FR016', 'Avoid outdoor fried foods in heat stroke season', 'High', 'H010'),
('FR017', 'Reduce red meat intake in joint pain', 'Medium', 'H011'),
('FR018', 'Avoid too much rice flakes for obesity risk', 'Medium', 'H005'),
('FR019', 'Avoid fried chicken curry in high cholesterol', 'High', 'H019'),
('FR020', 'Avoid spicy foods like chicken curry in acid reflux', 'Medium', 'H020');

-- --------------------------------------------------------

--
-- Table structure for table `health_problem`
--

CREATE TABLE `health_problem` (
  `health_id` varchar(100) NOT NULL,
  `problem_name` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `health_problem`
--

INSERT INTO `health_problem` (`health_id`, `problem_name`, `description`) VALUES
('H001', 'Type 2 Diabetes', 'Metabolic disorder characterized by high blood sugar.'),
('H002', 'Hypertension', 'High blood pressure; manage sodium and intensity.'),
('H003', 'Lactose Intolerance', 'Difficulty digesting lactose in dairy products.'),
('H004', 'Knee Injury', 'Patellofemoral pain; avoid high-impact activities.'),
('H005', 'Obesity', 'Excess body fat increasing risk of chronic diseases.'),
('H006', 'Asthma', 'Chronic airway inflammation, triggered by exertion.'),
('H007', 'Anemia', 'Low red blood cells, common in South Asia due to iron deficiency.'),
('H008', 'Gout', 'Joint inflammation from uric acid crystals, worsened by red meat.'),
('H009', 'Dehydration', 'Lack of water intake causing fatigue and dizziness.'),
('H010', 'Heat Stroke', 'Overheating of body in hot climate conditions.'),
('H011', 'Joint Pain', 'Arthritis and age-related joint stiffness.'),
('H012', 'Low Blood Pressure', 'Hypotension causing dizziness and fainting.'),
('H013', 'Vitamin B12 Deficiency', 'Low B12 leading to weakness and anemia.'),
('H014', 'Malnutrition', 'Lack of essential nutrients in daily diet.'),
('H015', 'Skin Allergy', 'Irritation caused by spicy food or dust exposure.'),
('H016', 'Eye Strain', 'Vision problems from long screen usage.'),
('H017', 'Sleep Disorder', 'Insomnia or poor sleep quality.'),
('H018', 'Gallstones', 'Digestive issues due to gallbladder stones.'),
('H019', 'High Cholesterol', 'Excess cholesterol in the blood increasing risk of heart disease.'),
('H020', 'Acid Reflux', 'Digestive disorder causing heartburn and discomfort after meals.');

-- --------------------------------------------------------

--
-- Table structure for table `includes`
--

CREATE TABLE `includes` (
  `id` int(10) UNSIGNED NOT NULL,
  `diet_plan_id` varchar(100) NOT NULL,
  `food_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `includes`
--

INSERT INTO `includes` (`id`, `diet_plan_id`, `food_id`) VALUES
(1, 'D001', 'F001'),
(2, 'D001', 'F005'),
(5, 'D003', 'F001'),
(6, 'D003', 'F004'),
(7, 'D004', 'F007'),
(8, 'D004', 'F008'),
(9, 'D005', 'F005'),
(10, 'D006', 'F003'),
(17, 'DP001', 'F006'),
(18, 'DP002', 'F001'),
(19, 'DP003', 'F005'),
(20, 'DP004', 'F004'),
(22, 'DP006', 'F008'),
(31, 'DP007', 'F002'),
(32, 'DP008', 'F001'),
(33, 'DP009', 'F007'),
(34, 'DP010', 'F006'),
(35, 'DP011', 'F003'),
(36, 'DP012', 'F004'),
(37, 'DP013', 'F008'),
(38, 'DP014', 'F009'),
(114, 'DP032', 'F002'),
(115, 'DP033', 'F023'),
(116, 'DP034', 'F007'),
(117, 'DP035', 'F006'),
(118, 'DP036', 'F020'),
(119, 'DP037', 'F014'),
(120, 'DP038', 'F031'),
(121, 'DP039', 'F001'),
(122, 'DP040', 'F030'),
(123, 'DP041', 'F003'),
(124, 'DP042', 'F022'),
(125, 'DP043', 'F026'),
(193, 'DP044', 'F002'),
(194, 'DP045', 'F005'),
(195, 'DP046', 'F007'),
(196, 'DP047', 'F006'),
(197, 'DP048', 'F031'),
(198, 'DP049', 'F001'),
(199, 'DP050', 'F003'),
(200, 'DP051', 'F008'),
(201, 'DP052', 'F014'),
(202, 'DP053', 'F004'),
(203, 'DP054', 'F009'),
(204, 'DP055', 'F018'),
(220, 'DP056', 'F001'),
(221, 'DP057', 'F005'),
(223, 'DP059', 'F006'),
(224, 'DP060', 'F014'),
(225, 'DP061', 'F003'),
(226, 'DP062', 'F008'),
(227, 'DP063', 'F020'),
(228, 'DP064', 'F020'),
(229, 'DP065', 'F004'),
(230, 'DP066', 'F016'),
(231, 'DP067', 'F030'),
(232, 'DP068', 'F025'),
(233, 'DP069', 'F030'),
(234, 'DP070', 'F013'),
(235, 'DP071', 'F001'),
(236, 'DP072', 'F005'),
(237, 'DP073', 'F007'),
(238, 'DP074', 'F006'),
(239, 'DP075', 'F031'),
(240, 'DP076', 'F002'),
(241, 'DP077', 'F003'),
(242, 'DP078', 'F008'),
(243, 'DP079', 'F014'),
(244, 'DP080', 'F014'),
(245, 'DP081', 'F004'),
(246, 'DP082', 'F009'),
(247, 'DP083', 'F020'),
(248, 'DP084', 'F013'),
(249, 'DP085', 'F018'),
(250, 'DP086', 'F020'),
(339, 'DP087', 'F018'),
(340, 'DP088', 'F001'),
(341, 'DP089', 'F005'),
(342, 'DP090', 'F007'),
(343, 'DP091', 'F009'),
(344, 'DP092', 'F002'),
(345, 'DP093', 'F003'),
(346, 'DP094', 'F008'),
(347, 'DP095', 'F014'),
(348, 'DP096', 'F013'),
(349, 'DP097', 'F014'),
(350, 'DP098', 'F004'),
(351, 'DP099', 'F016'),
(352, 'DP100', 'F020'),
(353, 'DP101', 'F025'),
(354, 'DP102', 'F006'),
(387, 'DP103', 'F001'),
(388, 'DP104', 'F005'),
(389, 'DP105', 'F018'),
(390, 'DP106', 'F006'),
(391, 'DP107', 'F031'),
(392, 'DP108', 'F014'),
(393, 'DP109', 'F003'),
(394, 'DP110', 'F008'),
(395, 'DP111', 'F020'),
(396, 'DP112', 'F020'),
(398, 'DP114', 'F016'),
(399, 'DP115', 'F030'),
(400, 'DP116', 'F025'),
(401, 'DP117', 'F030'),
(402, 'DP118', 'F013');

-- --------------------------------------------------------

--
-- Table structure for table `suffers_from`
--

CREATE TABLE `suffers_from` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `health_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suffers_from`
--

INSERT INTO `suffers_from` (`id`, `user_id`, `health_id`) VALUES
(16, 'U001', 'H001'),
(15, 'U001', 'H002'),
(17, 'U001', 'H004'),
(2, 'U002', 'H004'),
(3, 'U003', 'H002'),
(4, 'U003', 'H003'),
(5, 'U004', 'H002'),
(10, 'U005', 'H012'),
(11, 'U005', 'H013'),
(12, 'U008', 'H006'),
(14, 'U009', 'H002'),
(13, 'U009', 'H006');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `age` int(3) NOT NULL,
  `gender` char(10) NOT NULL,
  `height` decimal(4,3) NOT NULL,
  `weight` decimal(6,3) NOT NULL,
  `activity_level` int(1) NOT NULL,
  `activity_multiplier` decimal(4,3) NOT NULL,
  `daily_calories` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `name`, `email`, `password`, `age`, `gender`, `height`, `weight`, `activity_level`, `activity_multiplier`, `daily_calories`) VALUES
('U001', 'Ariana', 'ariana@gmail.com', 'U001pass!', 23, 'Female', 1.623, 58.000, 2, 1.375, 1904.97),
('U002', 'Bilal', 'bilal@gmail.com', 'U002pass!', 28, 'Male', 1.750, 74.000, 3, 1.550, NULL),
('U003', 'Chitra', 'chitra@gmail.com', 'U003pass!', 33, 'Female', 1.680, 66.500, 2, 1.200, 1725.96),
('U004', 'Dipto', 'dipto@gmail.com', 'U004pass!', 23, 'Male', 1.700, 60.000, 4, 1.725, 2740.44),
('U005', 'Ruhin', 'ruhin@gmail.com', '1234pass', 22, 'Female', 1.584, 60.000, 1, 1.200, 1675.25),
('U006', 'Rose', 'rose@gmail.com', '4567pass', 21, 'Female', 1.600, 57.000, 2, 1.375, 1894.34),
('U007', 'Conrad', 'fisher@gmail.com', '1234pass', 23, 'Male', 1.828, 70.000, 3, 1.550, 2747.69),
('U008', 'Nameer Rahman Rafan', 'rafanideal60@gmail.com', 'Ruhin is stingy', 17, 'Male', 1.720, 70.000, 3, 1.550, 2720.34),
('U009', 'Najiba', 'najiba@email.com', '1234naj', 20, 'Female', 1.570, 54.000, 2, 1.200, 1634.76);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `affects`
--
ALTER TABLE `affects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_affects_pair` (`food_restriction_id`,`food_id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `applies_to`
--
ALTER TABLE `applies_to`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_applies_pair` (`exercise_restriction_id`,`exercise_id`),
  ADD KEY `exercise_id` (`exercise_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `dietplan`
--
ALTER TABLE `dietplan`
  ADD PRIMARY KEY (`diet_plan_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `exercise`
--
ALTER TABLE `exercise`
  ADD PRIMARY KEY (`exercise_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exercise_preference`
--
ALTER TABLE `exercise_preference`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exercise_preference_exercise_id_bac6cdd5_fk_exercise_exercise_id` (`exercise_id`),
  ADD KEY `exercise_preference_user_id_9a171f8c_fk_user_user_id` (`user_id`);

--
-- Indexes for table `exercise_restriction`
--
ALTER TABLE `exercise_restriction`
  ADD PRIMARY KEY (`exercise_restriction_id`),
  ADD KEY `health_id` (`health_id`);

--
-- Indexes for table `food_nutrition`
--
ALTER TABLE `food_nutrition`
  ADD PRIMARY KEY (`food_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `food_preference`
--
ALTER TABLE `food_preference`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_preference_food_id_52993274_fk_food_nutrition_food_id` (`food_id`),
  ADD KEY `food_preference_user_id_321a87d4_fk_user_user_id` (`user_id`);

--
-- Indexes for table `food_restriction`
--
ALTER TABLE `food_restriction`
  ADD PRIMARY KEY (`food_restriction_id`),
  ADD KEY `health_id` (`health_id`);

--
-- Indexes for table `health_problem`
--
ALTER TABLE `health_problem`
  ADD PRIMARY KEY (`health_id`);

--
-- Indexes for table `includes`
--
ALTER TABLE `includes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_includes_pair` (`diet_plan_id`,`food_id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `suffers_from`
--
ALTER TABLE `suffers_from`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_suffers_pair` (`user_id`,`health_id`),
  ADD KEY `health_id` (`health_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `affects`
--
ALTER TABLE `affects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `applies_to`
--
ALTER TABLE `applies_to`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `exercise_preference`
--
ALTER TABLE `exercise_preference`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `food_preference`
--
ALTER TABLE `food_preference`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `includes`
--
ALTER TABLE `includes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `suffers_from`
--
ALTER TABLE `suffers_from`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `affects`
--
ALTER TABLE `affects`
  ADD CONSTRAINT `affects_ibfk_1` FOREIGN KEY (`food_restriction_id`) REFERENCES `food_restriction` (`food_restriction_id`),
  ADD CONSTRAINT `affects_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_nutrition` (`food_id`);

--
-- Constraints for table `applies_to`
--
ALTER TABLE `applies_to`
  ADD CONSTRAINT `applies_to_ibfk_1` FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`exercise_id`),
  ADD CONSTRAINT `applies_to_ibfk_2` FOREIGN KEY (`exercise_restriction_id`) REFERENCES `exercise_restriction` (`exercise_restriction_id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `dietplan`
--
ALTER TABLE `dietplan`
  ADD CONSTRAINT `dietplan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `exercise`
--
ALTER TABLE `exercise`
  ADD CONSTRAINT `exercise_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `exercise_preference`
--
ALTER TABLE `exercise_preference`
  ADD CONSTRAINT `exercise_preference_exercise_id_bac6cdd5_fk_exercise_exercise_id` FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`exercise_id`),
  ADD CONSTRAINT `exercise_preference_user_id_9a171f8c_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `exercise_restriction`
--
ALTER TABLE `exercise_restriction`
  ADD CONSTRAINT `exercise_restriction_ibfk_1` FOREIGN KEY (`health_id`) REFERENCES `health_problem` (`health_id`);

--
-- Constraints for table `food_nutrition`
--
ALTER TABLE `food_nutrition`
  ADD CONSTRAINT `food_nutrition_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `food_preference`
--
ALTER TABLE `food_preference`
  ADD CONSTRAINT `food_preference_food_id_52993274_fk_food_nutrition_food_id` FOREIGN KEY (`food_id`) REFERENCES `food_nutrition` (`food_id`),
  ADD CONSTRAINT `food_preference_user_id_321a87d4_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `food_restriction`
--
ALTER TABLE `food_restriction`
  ADD CONSTRAINT `food_restriction_ibfk_1` FOREIGN KEY (`health_id`) REFERENCES `health_problem` (`health_id`);

--
-- Constraints for table `includes`
--
ALTER TABLE `includes`
  ADD CONSTRAINT `includes_ibfk_1` FOREIGN KEY (`diet_plan_id`) REFERENCES `dietplan` (`diet_plan_id`),
  ADD CONSTRAINT `includes_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_nutrition` (`food_id`);

--
-- Constraints for table `suffers_from`
--
ALTER TABLE `suffers_from`
  ADD CONSTRAINT `suffers_from_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `suffers_from_ibfk_2` FOREIGN KEY (`health_id`) REFERENCES `health_problem` (`health_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
