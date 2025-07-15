-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2025 at 09:23 PM
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
-- Database: `e-learning`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `institute_name` varchar(100) NOT NULL,
  `access_level` enum('Super Admin','Institute Admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `user_id`, `institute_name`, `access_level`) VALUES
(1, 3, 'Management Student', 'Super Admin');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `posted_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  `bookmarked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_notes`
--

CREATE TABLE `exam_notes` (
  `id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  `assigned_exam` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_notes`
--

INSERT INTO `exam_notes` (`id`, `note_id`, `assigned_exam`) VALUES
(1, 2, 'NEET');

-- --------------------------------------------------------

--
-- Table structure for table `masters`
--

CREATE TABLE `masters` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject_specialization` varchar(100) NOT NULL,
  `assigned` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `masters`
--

INSERT INTO `masters` (`id`, `user_id`, `subject_specialization`, `assigned`) VALUES
(1, 2, 'Maths', '11th-Science');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `file_path` text NOT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `subject`, `description`, `file_path`, `uploaded_by`, `created_at`) VALUES
(1, 's', 's', 's', 'https://res.cloudinary.com/dwkp1j8ls/raw/upload/v1752591555/notes/mah5labh7matl27gihip.pdf', 3, '2025-07-15 14:59:16'),
(2, 'e', 'e', 'e', 'https://res.cloudinary.com/dwkp1j8ls/raw/upload/v1752591591/notes/fqg6ngvsgnidelizux2c.pdf', 3, '2025-07-15 14:59:52');

-- --------------------------------------------------------

--
-- Table structure for table `standard_notes`
--

CREATE TABLE `standard_notes` (
  `id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  `assigned_standard` varchar(10) NOT NULL,
  `assigned_stream` varchar(50) NOT NULL,
  `assigned_board` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `standard_notes`
--

INSERT INTO `standard_notes` (`id`, `note_id`, `assigned_standard`, `assigned_stream`, `assigned_board`) VALUES
(1, 1, '12th', 'Science', 'State');

-- --------------------------------------------------------

--
-- Table structure for table `student_profiles`
--

CREATE TABLE `student_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `board` varchar(50) NOT NULL,
  `standard` varchar(20) NOT NULL,
  `stream` varchar(30) NOT NULL,
  `exam_preparing` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_profiles`
--

INSERT INTO `student_profiles` (`id`, `user_id`, `board`, `standard`, `stream`, `exam_preparing`) VALUES
(1, 1, 'ICSE', '11th', 'Science', 'NEET'),
(2, 4, 'State', '12th', 'Science', 'NEET');

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `scheduled_date` date DEFAULT NULL,
  `uploaded_by` varchar(100) DEFAULT NULL,
  `file_path` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','master','admin') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Sameer', '123@gmail.com', '123', 'student', '2025-07-15 07:37:06'),
(2, 'Teacher', 'master@gmail.com', '123', 'master', '2025-07-15 07:39:45'),
(3, 'Admin', 'admin@gmail.com', '123', 'admin', '2025-07-15 07:40:42'),
(4, 'Sameer', '1234@gmail.com', '123', 'student', '2025-07-15 09:05:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `note_id` (`note_id`);

--
-- Indexes for table `exam_notes`
--
ALTER TABLE `exam_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `note_id` (`note_id`);

--
-- Indexes for table `masters`
--
ALTER TABLE `masters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `standard_notes`
--
ALTER TABLE `standard_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `note_id` (`note_id`);

--
-- Indexes for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_notes`
--
ALTER TABLE `exam_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `masters`
--
ALTER TABLE `masters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `standard_notes`
--
ALTER TABLE `standard_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_profiles`
--
ALTER TABLE `student_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_notes`
--
ALTER TABLE `exam_notes`
  ADD CONSTRAINT `exam_notes_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `masters`
--
ALTER TABLE `masters`
  ADD CONSTRAINT `masters_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `standard_notes`
--
ALTER TABLE `standard_notes`
  ADD CONSTRAINT `standard_notes_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD CONSTRAINT `student_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
