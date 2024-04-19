-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2024 at 08:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `did` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `dname` varchar(50) NOT NULL,
  `dept` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`did`, `email`, `dname`, `dept`) VALUES
(1, 'doctor@gmail.com', 'DR. Mehta', 'Dermatologist');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `slot` varchar(50) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `dept` varchar(50) NOT NULL,
  `number` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`pid`, `email`, `name`, `gender`, `slot`, `disease`, `time`, `date`, `dept`, `number`) VALUES
(3, 'jspm@gmail.com', 'JSPM', 'Male', 'evening', 'cough', '18:18:00', '2024-04-17', 'Ortho', '1234567890'),
(6, 'rscoe@gmail.com', 'RSCOE', 'Male', 'night', 'Piles', '21:31:00', '2024-04-18', 'Select Doctor Department', '345267819'),
(8, 'rscoe@gmail.com', 'RSCOE', 'Female', 'evening', 'cough', '18:32:00', '2024-04-18', 'Select Doctor Department', '9876543210'),
(9, 'rscoe@gmail.com', 'RSCOE', 'Female', 'night', 'fever', '21:33:00', '2024-04-10', 'Select Doctor Department', '9076567834'),
(13, 'jspm@gmail.com', 'JSPM', 'Male', 'morning', 'Piles', '04:42:00', '2024-04-18', 'Dermatologist', '434736487');

--
-- Triggers `patients`
--
DELIMITER $$
CREATE TRIGGER `patientinsertion` AFTER INSERT ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'PATIENT INSERTED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientremove` AFTER DELETE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.pid,OLD.email,OLD.name,'PATIENT DELETED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientupdation` AFTER UPDATE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'PATIENT UPDATED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `pid`, `email`, `name`, `action`, `timestamp`) VALUES
(1, 13, 'jspm@gmail.com', 'JSPM', 'PATIENT INSERTED', '2024-04-18 22:42:49'),
(2, 3, 'jspm@gmail.com', 'JSPM', 'PATIENT UPDATED', '2024-04-18 22:47:05'),
(3, 1, 'jspm@gmail.com', 'JSPM', 'PATIENT DELETED', '2024-04-18 22:51:20');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(1, 'JSPM', 'jspm@gmail.com', 'scrypt:32768:8:1$KlOy2WhG5A3o8QJS$112019f46276834f67a2f635bbc5bcd4c7fe532a083fbcd338ed0a49c8e8d4b0a28f1748cd1168b6b3f6de67cdde191ae36ed8e048133428055a911cac163264'),
(2, 'JSPM2', 'jspm2@gmail.com', 'scrypt:32768:8:1$nFmlQc0EGHU0hLSp$1281e5d883b3c8a9b627be382c3fe4c70af82fa12245eb989fd1cb09d6f8629cb8da02e88e43c5dd31f216927c41b7f8cbb3e0c60de87448cb02a5d2b260fb54'),
(3, 'RSCOE', 'rscoe@gmail.com', 'scrypt:32768:8:1$OireCIeXaXKoxp3V$68c999e7394dde388b4ebac80c3312be064d9aa990037b66d85f08a7f011edb9466f11330c0542edda03e4fecba9a1562e3482be639433891bb47dbd2f00aa86'),
(4, 'doctor', 'doctor@gmail.com', 'scrypt:32768:8:1$swyYqKBgBVRLL5XP$8ce5bfc6d62751e9c911f1bb59f31a056e0b9bbb66f1aaecfdb181a3cb605eab55f551b1a85418d60688e5bd92195fbe1ea1d9bb73257ab3aa181fb233abfb41'),
(5, 'doctor2', 'doctor2@gmail.com', 'scrypt:32768:8:1$K7FBlBD1sZLHOR9V$917e0339881108059d024b87dba19810ffd223e95b4c4e75aa216b4579f89eb15f8a9962c34b7600fe3771c4a59e890354c1620997be4bbb5bad2728e5e68316');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
