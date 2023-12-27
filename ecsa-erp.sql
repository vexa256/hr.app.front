-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 27, 2023 at 07:41 AM
-- Server version: 8.0.35-0ubuntu0.20.04.1
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecsa-erp`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `DepartmentName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `EID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SupervisorID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PhoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PassportOrNationalIDNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmployeeType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'International',
  `PID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `BankAccountNumber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `BankAccountName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `BankName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SalaryPerMonthInUsd` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TaxableSalaryAmountInUsd` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DateOfJoining` date NOT NULL,
  `ContractValidityInMonths` int NOT NULL,
  `DID` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`Name`, `UserID`, `EID`, `SupervisorID`, `Email`, `PhoneNumber`, `DateOfBirth`, `Gender`, `PassportOrNationalIDNumber`, `Address`, `City`, `Country`, `EmployeeType`, `PID`, `BankAccountNumber`, `BankAccountName`, `BankName`, `SalaryPerMonthInUsd`, `TaxableSalaryAmountInUsd`, `DateOfJoining`, `ContractValidityInMonths`, `DID`) VALUES
('John Doe', 'U1001', 'E1001', 'S1001', 'johndoe@example.com', '1234567890', '1990-01-01', 'Male', 'P1001', '123 Main St', 'Metropolis', 'Country1', 'Full-Time', 'P1001', 'BA1001', 'John Doe', 'Bank1', '5000', '4500', '2020-01-01', 12, 'D1001'),
('Jane Doe', 'U1002', 'E1002', 'S1002', 'janedoe@example.com', '1234567891', '1990-02-01', 'Female', 'P1002', '456 Second St', 'Gotham', 'Country2', 'Part-Time', 'P1002', 'BA1002', 'Jane Doe', 'Bank2', '4000', '3500', '2020-02-01', 24, 'D1002'),
('Alice Johnson', 'U1003', 'E1003', 'S1003', 'alicej@example.com', '1234567892', '1991-03-01', 'Female', 'P1003', '789 Third St', 'Star City', 'Country3', 'Contract', 'P1003', 'BA1003', 'Alice Johnson', 'Bank3', '4500', '4000', '2020-03-01', 6, 'D1003'),
('Bob Smith', 'U1004', 'E1004', 'S1004', 'bobsmith@example.com', '1234567893', '1992-04-01', 'Male', 'P1004', '1011 Fourth St', 'Central City', 'Country4', 'Full-Time', 'P1004', 'BA1004', 'Bob Smith', 'Bank4', '5500', '5000', '2020-04-01', 12, 'D1004'),
('Carol White', 'U1005', 'E1005', 'S1005', 'carolw@example.com', '1234567894', '1993-05-01', 'Female', 'P1005', '1213 Fifth St', 'Liberty City', 'Country5', 'Part-Time', 'P1005', 'BA1005', 'Carol White', 'Bank5', '3000', '2500', '2020-05-01', 24, 'D1005'),
('David Green', 'U1006', 'E1006', 'S1006', 'davidg@example.com', '1234567895', '1994-06-01', 'Male', 'P1006', '1415 Sixth St', 'Vice City', 'Country6', 'Contract', 'P1006', 'BA1006', 'David Green', 'Bank6', '4700', '4200', '2020-06-01', 6, 'D1006'),
('Emma Brown', 'U1007', 'E1007', 'S1007', 'emmab@example.com', '1234567896', '1995-07-01', 'Female', 'P1007', '1617 Seventh St', 'Angel City', 'Country7', 'Full-Time', 'P1007', 'BA1007', 'Emma Brown', 'Bank7', '5100', '4600', '2020-07-01', 12, 'D1007'),
('Frank Jones', 'U1008', 'E1008', 'S1008', 'frankj@example.com', '1234567897', '1996-08-01', 'Male', 'P1008', '1819 Eighth St', 'Emerald City', 'Country8', 'Part-Time', 'P1008', 'BA1008', 'Frank Jones', 'Bank8', '3500', '3000', '2020-08-01', 24, 'D1008'),
('Grace Lee', 'U1009', 'E1009', 'S1009', 'gracel@example.com', '1234567898', '1997-09-01', 'Female', 'P1009', '2021 Ninth St', 'Silver City', 'Country9', 'Contract', 'P1009', 'BA1009', 'Grace Lee', 'Bank9', '4200', '3700', '2020-09-01', 6, 'D1009'),
('Henry Davis', 'U1010', 'E1010', 'S1010', 'henryd@example.com', '1234567899', '1998-10-01', 'Male', 'P1010', '2223 Tenth St', 'Bronze City', 'Country10', 'Full-Time', 'P1010', 'BA1010', 'Henry Davis', 'Bank10', '5300', '4800', '2020-10-01', 12, 'D1010');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_12_26_183941_create_employees_table', 1),
(6, '2023_12_26_185528_create_departments_table', 1),
(7, '2023_12_26_185534_create_positions_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE `positions` (
  `id` bigint UNSIGNED NOT NULL,
  `Position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `UserID` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_departmentname_unique` (`DepartmentName`),
  ADD UNIQUE KEY `departments_description_unique` (`Description`),
  ADD UNIQUE KEY `departments_did_unique` (`DID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD UNIQUE KEY `employees_userid_unique` (`UserID`),
  ADD UNIQUE KEY `employees_eid_unique` (`EID`),
  ADD UNIQUE KEY `employees_email_unique` (`Email`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `positions_position_unique` (`Position`),
  ADD UNIQUE KEY `positions_description_unique` (`Description`),
  ADD UNIQUE KEY `positions_pid_unique` (`PID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `positions`
--
ALTER TABLE `positions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
