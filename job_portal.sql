-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2025 at 10:34 AM
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
-- Database: `job_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_generates`
--

CREATE TABLE `ai_generates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `ai_template_id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `prompt` text NOT NULL,
  `result` text NOT NULL,
  `length` varchar(191) NOT NULL,
  `charge` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_templates`
--

CREATE TABLE `ai_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `preview` varchar(191) DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `type` enum('candidate','employer') NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'draft',
  `fields` text DEFAULT NULL,
  `prompt` text NOT NULL,
  `ai_model` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ai_templates`
--

INSERT INTO `ai_templates` (`id`, `uuid`, `title`, `description`, `preview`, `icon`, `type`, `status`, `fields`, `prompt`, `ai_model`, `created_at`, `updated_at`) VALUES
(1, '3dbf2a90-a75b-43df-bf2f-598b051dd9cf', 'Resume Updater', 'Revitalize your resume with our Resume Updater - the key to landing your dream job!', '/uploads/resumeupdater.png', '/uploads/resumeupdater.png', 'candidate', 'active', '[{\"type\":\"textarea\",\"name\":\"Resume\",\"placeholder\":\"Add Resume Here\",\"value\":null},{\"type\":\"textarea\",\"name\":\"Job description\",\"placeholder\":\"Add Job description\",\"value\":null}]', 'Need to update my resume. Current Resume: [Resume] and Job description [Job description]', 'text-davinci-003', '2023-12-17 11:56:46', '2023-12-17 11:56:46'),
(2, '8d347ce5-2ce8-4890-b27d-68ccbc78c0c4', 'LinkedIn Ads', 'Eye-catching ads that will not only attract the right audience but also drive them to your lead magnet.', '/uploads/linkedInads.png', '/uploads/linkedInads.png', 'employer', 'active', '[{\"type\":\"input\",\"name\":\"Service Name\",\"placeholder\":\"Jobi\",\"value\":null},{\"type\":\"input\",\"name\":\"Service Description\",\"placeholder\":\"Service Description\",\"value\":null},{\"type\":\"input\",\"name\":\"Target Keywords\",\"placeholder\":\"landing page, Google ads, Facebook ads\",\"value\":null}]', 'Create a LinkedIn Ads campaign promoting the product [Service Name] to a professional audience. The product is designed to [Service Description]. Target keywords related to [Target Keywords] to reach a relevant audience. Craft ad copy that conveys the product\'s benefits, emphasizes and prompts users to take action.', 'text-davinci-003', '2023-12-17 12:21:23', '2023-12-17 12:21:23'),
(3, '92541abc-92f4-4651-a0fb-ca083b61b91a', 'Interview question generator', 'Generate Interview questions using this tool.', '/uploads/interviewquestiongenerator.png', '/uploads/interviewquestiongenerator.png', 'employer', 'active', '[{\"type\":\"input\",\"name\":\"Job Title\",\"placeholder\":\"Ex. Java Developer\",\"value\":null}]', 'Generate Interview Question for [Job Title]', 'text-davinci-003', '2023-12-17 12:33:27', '2023-12-17 12:33:27'),
(4, 'ebdbea3f-4daf-4173-8edb-6d562bc0124b', 'LinkedIn message generator', 'Create compelling outreach messages that capture the attention of top talent on LinkedIn.', '/uploads/linkedInmessagegenerator.png', '/uploads/linkedInmessagegenerator.png', 'employer', 'active', '[{\"type\":\"input\",\"name\":\"Your Company\",\"placeholder\":\"DevStation\",\"value\":null},{\"type\":\"input\",\"name\":\"Job Title\",\"placeholder\":\"Java Developer\",\"value\":null}]', 'write the message for LinkedIn my company name is \"[Your Company]\" and the job title is \"[Job Title]\"', 'text-davinci-003', '2023-12-17 12:42:41', '2023-12-17 12:42:41'),
(5, '3a647ce7-d024-4eb0-8f66-e916ac644ad4', 'Cover letter generator', 'Generate a cover letter from scratch can be time-consuming, especially if you\'re applying to multiple positions.', '/uploads/coverlettergenerator.png', '/uploads/coverlettergenerator.png', 'candidate', 'active', '[{\"type\":\"input\",\"name\":\"Your Name\",\"placeholder\":\"Ex. Jhone Doe\",\"value\":null},{\"type\":\"input\",\"name\":\"job position name\",\"placeholder\":\"Ex. Laravel Developer\",\"value\":null},{\"type\":\"input\",\"name\":\"Experience\",\"placeholder\":\"1 year\",\"value\":null}]', 'Write a job cover letter my name is \"[Your Name]\" my experience is [Experience] and the job position is \"[job position name]\"', 'text-davinci-003', '2023-12-17 12:54:55', '2023-12-17 12:54:55'),
(6, 'f26b7846-d036-4b49-b5c6-3cefa813a888', 'Message Replier', 'Crafting automated responses for efficient and effective communication.', '/uploads/messagereplier.png', '/uploads/messagereplier.png', 'candidate', 'active', '[{\"type\":\"input\",\"name\":\"Message\",\"placeholder\":\"Hi, How are you?\",\"value\":null}]', 'Write a reply message for [Message]', 'text-davinci-003', '2023-12-17 13:18:31', '2023-12-17 13:21:21');

-- --------------------------------------------------------

--
-- Table structure for table `ai_template_user`
--

CREATE TABLE `ai_template_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `ai_template_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `candidatebookmarks`
--

CREATE TABLE `candidatebookmarks` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `candidate_id` bigint(20) UNSIGNED NOT NULL,
  `opening_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `candidate_reviews`
--

CREATE TABLE `candidate_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ratting` tinyint(4) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `preview` varchar(191) DEFAULT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'category',
  `status` int(11) NOT NULL DEFAULT 1,
  `is_featured` int(11) NOT NULL DEFAULT 1,
  `is_menu_item` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(191) NOT NULL DEFAULT 'en',
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `slug`, `icon`, `preview`, `type`, `status`, `is_featured`, `is_menu_item`, `lang`, `category_id`, `created_at`, `updated_at`) VALUES
(1, '#', '/assets/images/logo/media_03.png', NULL, NULL, 'brand', 1, 1, 0, 'en', NULL, '2023-03-06 05:49:25', '2023-03-06 05:49:25'),
(2, '#', '/assets/images/logo/media_04.png', NULL, NULL, 'brand', 1, 1, 0, 'en', NULL, '2023-03-06 05:49:34', '2023-03-06 05:49:34'),
(3, '#', '/assets/images/logo/media_05.png', NULL, NULL, 'brand', 1, 1, 0, 'en', NULL, '2023-03-06 05:49:44', '2023-03-06 05:49:44'),
(4, '#', '/assets/images/logo/media_06.png', NULL, NULL, 'brand', 1, 1, 0, 'en', NULL, '2023-03-06 05:49:52', '2023-03-06 05:49:52'),
(5, '#', '/assets/images/logo/media_07.png', NULL, NULL, 'brand', 1, 1, 0, 'en', NULL, '2023-03-06 05:50:01', '2023-03-06 05:50:01'),
(6, '#', '/assets/images/logo/media_08.png', NULL, NULL, 'brand', 1, 1, 0, 'integration', NULL, '2023-04-09 14:14:23', '2023-04-09 14:14:23'),
(7, 'Education', 'education', NULL, NULL, 'blog_category', 1, 1, 0, 'en', NULL, '2023-03-06 13:05:30', '2023-03-06 13:05:30'),
(8, 'Information', 'information', NULL, NULL, 'blog_category', 1, 1, 0, 'en', NULL, '2023-03-06 13:06:44', '2023-03-06 13:06:44'),
(9, 'Interview', 'interview', NULL, NULL, 'blog_category', 1, 1, 0, 'en', NULL, '2023-03-06 13:06:50', '2023-03-06 13:06:50'),
(10, 'Skill', 'skill', NULL, NULL, 'blog_category', 1, 1, 0, 'en', NULL, '2023-03-06 13:07:56', '2023-03-06 13:07:56'),
(11, 'Education', 'education', NULL, NULL, 'tags', 1, 1, 0, 'en', NULL, '2023-03-06 13:08:24', '2023-03-06 13:08:24'),
(12, 'Ideas', 'ideas', NULL, NULL, 'tags', 1, 1, 0, 'en', NULL, '2023-03-06 13:08:46', '2023-03-06 13:08:46'),
(13, 'Development', 'development', NULL, NULL, 'tags', 1, 1, 0, 'en', NULL, '2023-03-06 13:09:05', '2023-03-06 13:09:05'),
(14, 'Branding', 'branding', NULL, NULL, 'tags', 1, 1, 0, 'en', NULL, '2023-03-06 13:09:16', '2023-03-06 13:09:16'),
(15, 'Developer', 'developer', NULL, NULL, 'blog_category', 1, 1, 0, 'en', NULL, '2023-03-06 13:05:06', '2023-03-06 13:05:06'),
(23, 'Content Writer', 'content-writer', NULL, '/uploads/24/01/MUTDggNL4NYqfyYV5VZF.jpg', 'service', 1, 1, 0, 'en', NULL, '2023-08-23 11:04:09', '2024-01-02 11:01:36'),
(24, 'UI/UX Design', 'uiux-design', NULL, '/assets/images/icon/icon_01.svg', 'job_category', 1, 1, 1, 'en', 31, '2023-08-23 11:04:38', '2023-12-31 11:30:16'),
(25, 'Development', 'development', NULL, '/assets/images/icon/icon_02.svg', 'job_category', 1, 1, 1, 'en', 38, '2023-08-23 11:04:52', '2023-12-31 11:30:08'),
(26, 'React', 'react', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-08-23 11:05:06', '2023-10-07 03:51:13'),
(27, 'Web Development', 'web-development', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-08-23 11:05:12', '2023-10-07 03:50:37'),
(28, 'Layout Design', 'layout-design', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 24, '2023-08-23 11:05:40', '2023-10-07 03:50:03'),
(29, 'Squarespace', 'squarespace', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 32, '2023-08-23 11:05:48', '2023-10-07 03:49:42'),
(30, 'Web Design', 'web-design', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-08-23 11:06:04', '2023-10-07 03:49:23'),
(31, 'UI / UX Designer', 'ui-ux-designer', NULL, '/uploads/24/01/3Qn6QBjLJ15wKMSlFpxl.jpg', 'service', 1, 1, 0, 'en', NULL, '2023-08-23 11:06:24', '2024-01-01 12:42:29'),
(32, 'Marketing', 'marketing', NULL, '/assets/images/icon/icon_03.svg', 'job_category', 1, 1, 1, 'en', 37, '2023-08-23 11:06:50', '2024-01-06 11:24:24'),
(33, 'Telemarketing', 'telemarketing', NULL, '/assets/images/icon/icon_04.svg', 'job_category', 1, 1, 1, 'en', 37, '2023-09-16 01:29:55', '2023-12-31 11:29:52'),
(34, 'Editing', 'editing', NULL, '/assets/images/icon/icon_05.svg', 'job_category', 1, 1, 1, 'en', 40, '2023-09-16 01:30:24', '2024-01-06 11:16:22'),
(35, 'Accounting', 'accounting', NULL, '/assets/images/icon/icon_06.svg', 'job_category', 1, 1, 1, 'en', 37, '2023-09-16 01:30:56', '2023-12-31 10:57:47'),
(36, 'SEO Guru', 'seo-guru', NULL, '/uploads/24/01/aLocqkzy7zUsWyJAT2i5.jpg', 'service', 1, 1, 0, 'en', NULL, '2023-10-07 03:44:11', '2024-01-01 12:47:26'),
(37, 'Digital Markter', 'digital-markter', NULL, '/uploads/24/01/o9Gl1zuX2aSVoj51AGLb.jpg', 'service', 1, 1, 0, 'en', NULL, '2023-10-07 03:45:19', '2024-01-01 12:43:06'),
(38, 'Web & App Development', 'web-app-development', NULL, '/uploads/24/01/TX0ytilFXigZNfQd21UD.jpg', 'service', 1, 1, 0, 'en', NULL, '2023-10-07 03:46:52', '2024-01-01 12:41:17'),
(39, 'Full Stact', 'full-stact', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-10-07 03:51:06', '2023-10-07 03:51:06'),
(40, 'Graphic Designer', 'graphic-designer', NULL, '/uploads/24/01/u9YewjYfkkZx3xxhUZxn.jpg', 'service', 1, 1, 0, 'en', NULL, '2023-10-07 05:03:16', '2024-01-01 13:04:38'),
(41, 'Design', 'design', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 24, '2023-10-07 05:03:58', '2023-10-07 05:03:58'),
(42, 'UI', 'ui', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 24, '2023-10-07 05:04:05', '2023-10-07 05:04:05'),
(43, 'Digital', 'digital', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 24, '2023-10-07 05:04:15', '2023-10-07 05:04:15'),
(44, 'Java', 'java', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-10-07 05:04:37', '2023-10-07 05:04:37'),
(45, 'Developer', 'developer', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-10-07 05:04:46', '2023-10-07 05:04:46'),
(46, 'Code', 'code', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 25, '2023-10-07 05:04:53', '2023-10-07 05:04:53'),
(47, 'Brand & Product', 'brand-product', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 24, '2023-10-07 05:05:14', '2023-10-07 05:05:14'),
(48, 'Account', 'account', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 35, '2023-10-07 05:05:30', '2023-10-07 05:05:30'),
(49, 'Finance', 'finance', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 35, '2023-10-07 05:05:40', '2023-10-07 05:05:40'),
(50, 'Marketing', 'marketing', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 35, '2023-10-07 05:05:51', '2023-10-07 05:05:51'),
(51, 'Data', 'data', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 32, '2023-10-07 05:06:08', '2023-10-07 05:06:08'),
(52, 'Art', 'art', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 24, '2023-10-07 05:06:34', '2023-10-07 05:06:34'),
(53, 'SEO writers', 'seo-writers', NULL, '/uploads/24/01/3zbXFnO1BiAbYLBPSOdU.png', 'job_category', 1, 0, 0, 'en', 23, '2024-01-02 11:02:45', '2024-01-03 11:45:47'),
(54, 'Ecommerce', 'ecommerce', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 53, '2024-01-02 11:03:06', '2024-01-02 11:03:21'),
(55, 'niche experts', 'niche-experts', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 53, '2024-01-02 11:05:46', '2024-01-02 11:05:46'),
(56, 'Photoshop', 'photoshop', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 34, '2024-01-06 11:14:18', '2024-01-06 11:14:18'),
(57, 'Figma', 'figma', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 34, '2024-01-06 11:14:30', '2024-01-06 11:14:30'),
(58, 'Active listening', 'active-listening', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 33, '2024-01-06 11:47:14', '2024-01-06 11:47:14'),
(59, 'Communication', 'communication', NULL, NULL, 'job_tag', 1, 1, 0, 'en', 33, '2024-01-06 11:47:27', '2024-01-06 11:47:27'),
(60, 'Marketing', 'marketing', NULL, NULL, 'faq_category', 1, 1, 0, 'en', NULL, '2024-01-09 10:25:03', '2024-01-09 10:25:03'),
(61, 'Buying', 'buying', NULL, NULL, 'faq_category', 1, 1, 0, 'en', NULL, '2024-01-09 10:25:16', '2024-01-09 10:25:16'),
(62, 'User Manual', 'user-manual', NULL, NULL, 'faq_category', 1, 1, 0, 'en', NULL, '2024-01-09 10:25:26', '2024-01-09 10:25:26'),
(63, 'Payments', 'payments', NULL, NULL, 'faq_category', 1, 1, 0, 'en', NULL, '2024-01-09 10:25:36', '2024-01-09 10:25:36'),
(64, 'Terms & Conditions', 'terms-conditions', NULL, NULL, 'faq_category', 1, 1, 0, 'en', NULL, '2024-01-09 10:25:47', '2024-01-09 10:25:47'),
(65, 'Account', 'account', NULL, NULL, 'faq_category', 1, 1, 0, 'en', NULL, '2024-01-09 10:25:56', '2024-01-09 10:25:56');

-- --------------------------------------------------------

--
-- Table structure for table `categorymetas`
--

CREATE TABLE `categorymetas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category_opening`
--

CREATE TABLE `category_opening` (
  `opening_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_opening`
--

INSERT INTO `category_opening` (`opening_id`, `category_id`) VALUES
(1, 42),
(1, 47),
(1, 52),
(1, 41),
(1, 43),
(1, 28),
(1, 24),
(2, 28),
(2, 42),
(2, 47),
(2, 24),
(3, 39),
(3, 45),
(3, 26),
(3, 25),
(4, 39),
(4, 45),
(4, 26),
(4, 25),
(5, 39),
(5, 45),
(5, 26),
(5, 25),
(7, 39),
(7, 45),
(7, 26),
(7, 25),
(8, 39),
(8, 45),
(8, 26),
(8, 25),
(9, 39),
(9, 45),
(9, 26),
(9, 25),
(10, 39),
(10, 45),
(10, 26),
(10, 25),
(11, 39),
(11, 45),
(11, 26),
(11, 25),
(12, 39),
(12, 45),
(12, 26),
(12, 25),
(13, 39),
(13, 45),
(13, 26),
(13, 25),
(14, 39),
(14, 45),
(14, 26),
(14, 25),
(6, 49),
(6, 50),
(6, 48),
(6, 35),
(15, 48),
(15, 49),
(15, 50),
(15, 35),
(16, 56),
(16, 57),
(16, 34),
(17, 29),
(17, 51),
(17, 32),
(18, 58),
(18, 59),
(18, 33);

-- --------------------------------------------------------

--
-- Table structure for table `category_templates`
--

CREATE TABLE `category_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `template_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `company_reviews`
--

CREATE TABLE `company_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ratting` tinyint(4) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `blocked_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_user`
--

CREATE TABLE `conversation_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `credit_logs`
--

CREATE TABLE `credit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `price` double NOT NULL,
  `credits` double NOT NULL,
  `payment_id` varchar(191) DEFAULT NULL,
  `gateway_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `meta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `description_templates`
--

CREATE TABLE `description_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('company','job') NOT NULL,
  `body` text NOT NULL,
  `shortcodes` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `description_templates`
--

INSERT INTO `description_templates` (`id`, `type`, `body`, `shortcodes`, `status`, `created_at`, `updated_at`) VALUES
(1, 'company', 'Company Description:[company_name]\n          \n          Welcome to [company_name], where words come alive and ideas take flight! At [company_name], we are committed to elevating your brand\'s narrative through exceptional content writing services. As a premier content creation hub, we understand the power of words in shaping perceptions, building connections, and driving success.\n          \n          Our team of seasoned wordsmiths at [company_name] is dedicated to crafting engaging, insightful, and impactful content tailored to meet your unique needs. Whether you\'re looking to enhance your online presence, captivate your audience, or convey your brand\'s message with clarity and resonance, we\'ve got you covered.\n          \n          What sets [company_name] apart is our unwavering commitment to quality and creativity. We believe that every piece of content should be a masterpiece, reflecting the essence of your brand and resonating with your target audience. Our diverse team of writers brings a wealth of experience and expertise to the table, ensuring that your content not only meets but exceeds industry standards.\n          \n          [company_name] specializes in a range of content writing services, including website content, blog posts, articles, social media content, product descriptions, and more. Whether you\'re a start-up looking to establish a compelling online presence or an established enterprise seeking to refresh your brand voice, our team is poised to deliver results that surpass expectations.\n          \n          At [company_name], we understand that each client is unique, and we take a personalized approach to every project. Our collaborative process involves understanding your goals, target audience, and brand identity, allowing us to create content that resonates and drives tangible results.\n          \n          Why choose [company_name]?\n          \n          1. **Expertise:** Our team comprises skilled writers with expertise in various industries, ensuring that your content is not only well-written but also industry-relevant.\n          \n          2. **Creativity:** We thrive on creativity, infusing every piece of content with a unique flair that sets your brand apart from the competition.\n          \n          3. **Reliability:** Timely delivery and reliability are at the core of our values. When you choose [company_name] , you can trust us to meet deadlines without compromising on quality.\n          \n          4. **Client-Centric Approach:** Your satisfaction is our priority. We value open communication and collaboration, working closely with you to achieve the desired outcomes.\n          \n          Experience the power of compelling content with [company_name]. Let us be the architects of your brand\'s narrative, shaping stories that resonate and inspire. Elevate your content, elevate your brand with [company_name].', '[\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\"]', 'active', '2024-01-12 10:07:20', '2024-01-12 10:07:20'),
(2, 'company', 'Company Description: [company_name]\n          \n          Welcome to [company_name], your partner in crafting exceptional digital experiences through cutting-edge UI/UX design solutions. At [company_name], we believe in the transformative power of user-centric design, seamlessly blending innovation with functionality to create interfaces that captivate and delight.\n          \n          As a leading provider of UI/UX design services, [company_name] is dedicated to helping businesses and organizations elevate their digital presence. Our team of talented designers brings a wealth of expertise and creativity to the table, ensuring that every project is a testament to thoughtful design and meticulous attention to detail.\n          \n          **Our Approach:**\n          \n          At [company_name], we understand that the heart of great design lies in understanding the end user. We take a user-centric approach to every project, diving deep into user behaviors, preferences, and needs. This approach allows us to create interfaces that not only look visually stunning but also provide an intuitive and seamless user experience.\n          \n          **Services Offered:**\n          \n          - **User Interface (UI) Design:** Our UI designers are masters at creating visually appealing and intuitive interfaces that reflect your brand identity while ensuring ease of use.\n          \n          - **User Experience (UX) Design:** We go beyond aesthetics, focusing on the user journey to enhance the overall experience. Our UX design ensures that every interaction is meaningful and leaves a lasting impression.\n          \n          - **Prototyping and Wireframing:** Before the pixels hit the screen, we meticulously plan and prototype to bring ideas to life, allowing for early testing and refinement.\n          \n          - **Responsive Design:** In a digital landscape that spans various devices, our responsive design ensures that your interface looks and functions flawlessly across desktops, tablets, and mobile devices.\n          \n          - **Usability Testing:** We believe in continuous improvement. Our usability testing ensures that the final product meets the highest standards of functionality and user satisfaction.\n          \n          **Why Choose [company_name]?**\n          \n          1. **Innovation:** We stay ahead of design trends and embrace innovation to deliver interfaces that not only meet but exceed industry standards.\n          \n          2. **Collaboration:** Your vision is our guide. We collaborate closely with our clients, ensuring that every design aligns with their brand goals and resonates with their target audience.\n          \n          3. **Timely Delivery:** We understand the importance of timelines. Our commitment to timely delivery ensures that your project progresses smoothly, meeting deadlines without compromising on quality.\n          \n          4. **Client-Centric Focus:** Your success is our success. We are dedicated to building long-lasting relationships with our clients, providing ongoing support and evolving with their design needs.\n          \n          Experience the transformative impact of exceptional UI/UX design with [company_name]. Let us turn your digital vision into a visually stunning and user-friendly reality. Elevate your digital experience, elevate your brand with [company_name].', '[\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\"]', 'active', '2024-01-12 10:09:25', '2024-01-12 10:09:25'),
(3, 'company', 'Company Description: [company_name]\n          \n          Welcome to [company_name], where digital excellence meets strategic innovation! At [company_name], we are your trusted partner in navigating the dynamic landscape of online visibility and brand prominence. As a premier provider of SEO and Digital Marketing services, we specialize in driving targeted traffic, boosting online presence, and ensuring your brand stands out in the digital realm.\n          \n          **Our Expertise:**\n          \n          At [company_name], we understand that the digital landscape is ever-evolving. Our team of seasoned SEO experts and digital marketers are equipped with the knowledge and skills to keep your brand at the forefront of this evolution. We offer a comprehensive suite of services tailored to meet the unique needs of businesses seeking to thrive in the online space.\n          \n          **Services Offered:**\n          \n          - **Search Engine Optimization (SEO):** Elevate your search engine rankings and increase organic traffic with our strategic SEO services. We employ industry best practices to optimize your website, ensuring it is not only visible but also highly relevant to your target audience.\n          \n          - **Digital Marketing Strategy:** Harness the power of digital channels with our results-driven marketing strategies. From social media marketing to content marketing, we tailor our approach to align with your brand goals and connect with your audience.\n          \n          - **Pay-Per-Click (PPC) Advertising:** Maximize your online visibility with targeted PPC campaigns. Our experts craft compelling ad campaigns that drive relevant traffic, increase conversions, and deliver a measurable return on investment.\n          \n          - **Content Marketing:** Engage your audience and build brand authority with our content marketing services. From blog posts to infographics, we create content that resonates with your audience and enhances your online presence.\n          \n          - **Social Media Management:** Leverage the power of social media platforms to connect with your audience. Our social media management services encompass content creation, community engagement, and strategic campaigns to boost your brand\'s social presence.\n          \n          **Why Choose [company_name]?**\n          \n          1. **Proven Results:** Our track record speaks for itself. We have a proven history of delivering tangible results, increasing organic traffic, and enhancing online visibility for our clients.\n          \n          2. **Customized Solutions:** We understand that one size does not fit all. Our solutions are tailored to your unique business needs, ensuring a customized approach that aligns with your goals.\n          \n          3. **Transparent Communication:** Open and transparent communication is at the core of our client relationships. We keep you informed every step of the way, providing insights and progress reports.\n          \n          4. **Innovation:** The digital landscape is dynamic, and we embrace innovation. Our team stays ahead of industry trends, ensuring your strategies are cutting-edge and effective.\n          \n          Experience the power of strategic SEO and Digital Marketing with [company_name]. Let us be the architects of your online success, driving results that propel your brand to new heights. Elevate your digital presence, elevate your brand with [company_name].', '[\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\"]', 'active', '2024-01-12 10:11:45', '2024-01-12 10:11:45'),
(4, 'company', 'Company Description: [company_name]\n          \n          Welcome to [company_name], your creative hub for cutting-edge design solutions that redefine the digital experience! At [company_name], we are your dedicated partners in crafting exceptional web, software, and graphic designs that not only meet but exceed your expectations. Our passion for innovation and commitment to excellence make us the go-to destination for businesses seeking to elevate their online presence and user engagement.\n          \n          **Our Design Expertise:**\n          \n          At [company_name], we bring together a dynamic team of designers, developers, and creative minds to transform your vision into visually stunning and functionally robust designs. Whether you\'re looking to establish a captivating online presence, streamline your software interface, or enhance your brand identity through graphic design, we\'ve got the expertise to bring your ideas to life.\n          \n          **Services Offered:**\n          \n          1. **Web Design:** Our web design services are centered on creating user-centric, visually appealing websites that not only capture attention but also provide a seamless and intuitive user experience. From landing pages to e-commerce platforms, we tailor our designs to align with your brand identity and business goals.\n          \n          2. **Software Design:** In the realm of software, user experience is paramount. Our software design solutions focus on creating interfaces that are not only aesthetically pleasing but also highly functional. We ensure that your software engages users and enhances their overall experience.\n          \n          3. **Graphic Design:** Elevate your brand identity with our graphic design services. From logos and branding materials to marketing collateral and digital assets, our graphic designers craft visuals that communicate your brand story effectively and leave a lasting impression.\n          \n          **Why Choose [company_name]?**\n          \n          1. **Holistic Design Approach:** We offer a comprehensive suite of design services, ensuring that every aspect of your digital presence is cohesive and visually compelling.\n          \n          2. **Collaborative Process:** Your vision is our inspiration. We collaborate closely with our clients, involving them in the creative process to ensure the final product reflects their unique identity and goals.\n          \n          3. **Innovation and Creativity:** We thrive on innovation and creativity. Our designers stay ahead of design trends, ensuring that your projects are not only current but also future-proof.\n          \n          4. **Technical Excellence:** Functionality is as crucial as aesthetics. Our team combines design flair with technical expertise to deliver designs that not only look good but also perform seamlessly.\n          \n          Experience the transformative impact of exceptional design with [company_name]. Let us be the architects of your digital journey, creating designs that resonate, captivate, and elevate your brand to new heights. Elevate your digital presence, elevate your brand with [company_name].', '[\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\"]', 'active', '2024-01-12 10:13:55', '2024-01-12 10:13:55'),
(5, 'job', 'Job Title: [JOB_NAME]\n          \n          Company: [company_name]\n          \n          Location: [company_address]\n          \n          Are you a wordsmith with a passion for crafting compelling narratives that captivate and engage audiences? [company_name], a dynamic and innovative company located in Agrabad, is seeking a talented [JOB_NAME] to join our creative team. As a [JOB_NAME] at [company_name], you\'ll have the opportunity to shape the voice of our brand and create content that resonates with our audience.\n          \n          **Key Responsibilities:**\n          \n          1. **Content Creation:** Develop high-quality and engaging content for various platforms, including website pages, blog posts, social media, marketing collateral, and more.\n          \n          2. **Research:** Conduct thorough research on industry trends, competitors, and relevant topics to ensure that the content is informed, accurate, and aligned with our brand objectives.\n          \n          3. **Collaboration:** Work closely with other teams, including marketing, design, and development, to ensure content aligns with overall brand strategy and objectives.\n          \n          4. **Editing and Proofreading:** Review and edit content to ensure it meets high editorial standards, is free of errors, and adheres to brand guidelines.\n          \n          5. **SEO Optimization:** Implement SEO best practices to enhance content visibility and search engine rankings.\n          \n          6. **Content Calendar Management:** Contribute to the development and execution of content calendars to ensure a consistent and timely flow of content across platforms.\n          \n          **Requirements:**\n          \n          - Proven experience as a [JOB_NAME] or similar role.\n          - Exceptional writing, editing, and proofreading skills.\n          - Strong research skills and the ability to translate complex information into clear, concise, and engaging content.\n          - Familiarity with SEO best practices.\n          - Ability to work in a collaborative team environment.\n          - Excellent time-management skills and the ability to meet deadlines.\n          - A creative mindset and a passion for staying updated on industry trends.\n          \n          **Location:**\n          \n          [company_name] is located in Agrabad, providing a vibrant and inspiring work environment that fosters creativity and collaboration.\n          \n          If you are a talented [JOB_NAME] looking to make a meaningful impact with your writing skills, we invite you to join [company_name]. Apply now and be a part of our dynamic team, shaping the future of digital content. Please send your resume, portfolio, and a cover letter detailing your relevant experience to this post.', '[\"[JOB_NAME]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[JOB_NAME]\",\"[JOB_NAME]\",\"[company_name]\",\"[JOB_NAME]\",\"[company_name]\",\"[JOB_NAME]\",\"[company_name]\"]', 'active', '2024-01-12 10:18:46', '2024-01-12 10:18:46'),
(6, 'job', 'Job Title: [JOB_NAME]\n          \n          Company: [company_name]\n          \n          Location: [company_address]\n          \n          Are you a creative thinker with a passion for designing exceptional user experiences? [company_name], located at [company_address], is on the lookout for a talented UI/UX Designer to join our innovative team. As a UI/UX Designer, you will play a key role in shaping the digital presence of our brand by creating intuitive and visually appealing interfaces that enhance user satisfaction.\n          \n          Key Responsibilities:\n          \n          User Interface (UI) Design: Develop visually stunning and user-friendly interfaces for web and mobile applications, ensuring a seamless and intuitive user experience.\n          \n          User Experience (UX) Design: Conduct user research, analyze user feedback, and translate insights into design concepts that enhance overall user satisfaction and engagement.\n          \n          Wireframing and Prototyping: Create wireframes and prototypes to visualize design concepts and gather valuable feedback for iterative improvements.\n          \n          Collaboration: Work closely with cross-functional teams, including developers, product managers, and other designers, to ensure a cohesive and consistent user experience across all platforms.\n          \n          Visual Design: Implement best practices in visual design to create aesthetically pleasing and on-brand user interfaces that align with [company_name]\'s design principles.\n          \n          Usability Testing: Conduct usability testing to identify and address potential user experience issues, ensuring the final product meets high standards of usability.\n          \n          Requirements:\n          \n          Proven experience as a UI/UX Designer or similar role.\n          Proficient in design tools such as Sketch, Figma, or Adobe Creative Suite.\n          Strong portfolio showcasing a range of UI/UX design projects.\n          Familiarity with user-centered design principles and best practices.\n          Excellent communication and collaboration skills.\n          Up-to-date with industry trends and a passion for continuous learning.\n          Location:\n          \n          [company_name] is located at [[company_address], offering a dynamic and collaborative work environment.\n          \n          If you are a creative UI/UX Designer ready to make a significant impact in the digital design space, [company_name] invites you to join our team. To apply, please submit your resume, portfolio, and a cover letter detailing your relevant experience to the apply option.', '[\"[JOB_NAME]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_name]\",\"[[company_address]\",\"[company_name]\"]', 'active', '2024-01-12 10:22:57', '2024-01-12 10:22:57'),
(7, 'job', 'Job Title: [JOB_NAME]\n          \n          Company: [company_name]\n          \n          Location: [company_address]\n          \n          Are you a strategic thinker with a passion for driving online visibility and engagement? [company_name], located at [company_address], is in search of a dynamic SEO and Digital Marketer to join our innovative marketing team. As an SEO and Digital Marketer, you will play a pivotal role in enhancing our online presence, optimizing content for search engines, and executing digital marketing strategies to propel [company_name] to new heights.\n          \n          **Key Responsibilities:**\n          \n          1. **Search Engine Optimization (SEO):** Develop and implement SEO strategies to improve organic search rankings, drive website traffic, and enhance online visibility.\n          \n          2. **Keyword Research:** Conduct comprehensive keyword research to identify opportunities for content optimization and improved search engine performance.\n          \n          3. **Content Optimization:** Collaborate with content creators to optimize website content, blog posts, and other digital assets for SEO, ensuring alignment with industry best practices.\n          \n          4. **Digital Marketing Strategy:** Develop and execute digital marketing strategies across various channels, including social media, email, and paid advertising, to drive brand awareness and lead generation.\n          \n          5. **Analytics and Reporting:** Monitor and analyze website analytics, campaign performance, and SEO metrics to provide actionable insights and recommendations for continuous improvement.\n          \n          6. **Competitor Analysis:** Stay informed about industry trends and conduct competitor analysis to identify opportunities and challenges in the digital landscape.\n          \n          **Requirements:**\n          \n          - Proven experience as an SEO and Digital Marketer or similar role.\n          - In-depth knowledge of SEO best practices, search engine algorithms, and digital marketing trends.\n          - Proficiency in SEO tools, analytics platforms, and digital marketing software.\n          - Strong analytical skills with the ability to interpret data and provide insights.\n          - Excellent communication and collaboration skills.\n          - Up-to-date with industry changes and a passion for continuous learning.\n          \n          **Location:**\n          \n          [company_name] is located at [company_address], offering a collaborative and dynamic work environment.\n          \n          If you are a results-driven SEO and Digital Marketer ready to make a significant impact in the digital marketing landscape, [company_name] invites you to join our team. To apply, please submit your resume and a cover letter detailing your relevant experience to the apply button.', '[\"[JOB_NAME]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_name]\",\"[company_address]\",\"[company_name]\"]', 'active', '2024-01-12 10:26:00', '2024-01-12 10:26:00'),
(8, 'job', 'Job Title: [JOB_NAME]\n          \n          Company: [company_name]\n          \n          Location: [company_address]\n          \n          Are you a talented developer with a passion for creating seamless digital experiences? [company_name], located at [company_address], is seeking a skilled Web and App Developer to join our dynamic team. As a Web and App Developer, you will be at the forefront of transforming ideas into functional, user-friendly websites and applications that align with [company_name]\'s commitment to innovation and excellence.\n          \n          **Key Responsibilities:**\n          \n          1. **Full-Stack Development:** Take ownership of the complete development life cycle, from front-end design to back-end implementation, ensuring robust and scalable solutions for web and mobile applications.\n          \n          2. **Website Development:** Develop and maintain responsive, visually appealing websites that meet the highest standards of user experience and design.\n          \n          3. **Mobile App Development:** Design and build mobile applications for iOS and Android platforms, ensuring optimal performance and user satisfaction.\n          \n          4. **Collaboration:** Work closely with cross-functional teams, including UI/UX designers, product managers, and other developers, to deliver high-quality digital solutions.\n          \n          5. **Code Review and Optimization:** Conduct regular code reviews, identify areas for optimization, and implement best practices to ensure code quality and maintainability.\n          \n          6. **Troubleshooting and Debugging:** Investigate and resolve technical issues, troubleshoot bugs, and provide effective solutions to maintain smooth and error-free application performance.\n          \n          **Requirements:**\n          \n          - Proven experience as a Web and App Developer or similar role.\n          - Proficient in front-end and back-end development technologies such as HTML, CSS, JavaScript, React, Node.js, and others.\n          - Experience in mobile app development using frameworks such as React Native or Flutter.\n          - Knowledge of database management and API integration.\n          - Strong problem-solving and debugging skills.\n          - Excellent communication and collaboration skills.\n          \n          **Location:**\n          \n          [company_name] is located at [company_address], offering a collaborative and innovative work environment.\n          \n          If you are a passionate Web and App Developer ready to contribute to the creation of cutting-edge digital solutions, [company_name] invites you to join our team. To apply, please submit your resume and a cover letter detailing your relevant experience to the apply button.', '[\"[JOB_NAME]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_name]\",\"[company_address]\",\"[company_name]\"]', 'active', '2024-01-12 10:29:42', '2024-01-12 10:29:42'),
(9, 'job', 'Job Title: [JOB_NAME]\n          \n          Company: [company_name]\n          \n          Location: [company_address]\n          \n          Are you a creative visionary with a passion for visual storytelling? [company_name], situated at [company_address], is actively seeking a talented Graphic Designer to join our innovative team. As a Graphic Designer, you will play a pivotal role in shaping the visual identity of [company_name] through compelling and aesthetically pleasing design solutions.\n          \n          **Key Responsibilities:**\n          \n          1. **Visual Design:** Develop visually stunning and cohesive design solutions for various mediums, including digital and print, that align with [company_name]\'s brand identity and objectives.\n          \n          2. **Branding:** Contribute to the evolution and maintenance of [company_name]\'s brand by creating visually impactful logos, marketing collateral, and other brand assets.\n          \n          3. **Digital Assets:** Design engaging digital assets for online platforms, social media, websites, and other digital channels to enhance user engagement and brand presence.\n          \n          4. **Print Collateral:** Create print materials such as brochures, posters, banners, and other promotional items that effectively communicate [company_name]\'s message and values.\n          \n          5. **Collaboration:** Work collaboratively with cross-functional teams, including marketing, UI/UX designers, and developers, to ensure design alignment with overall brand and project objectives.\n          \n          6. **Creative Ideation:** Contribute innovative design concepts and ideas during brainstorming sessions, helping to push the creative boundaries and maintain a fresh and modern design perspective.\n          \n          **Requirements:**\n          \n          - Proven experience as a Graphic Designer or similar role.\n          - Proficient in graphic design software such as Adobe Creative Suite (Illustrator, Photoshop, InDesign).\n          - Strong portfolio showcasing a diverse range of design projects.\n          - Excellent understanding of design principles, typography, and color theory.\n          - Strong attention to detail and ability to translate creative briefs into visually compelling designs.\n          - Excellent communication and collaboration skills.\n          \n          **Location:**\n          \n          [company_name] is located at [company_address], providing a vibrant and collaborative work environment.\n          \n          If you are a creative Graphic Designer ready to make a significant impact on [company_name] visual identity, we invite you to join our team. To apply, please submit your resume, portfolio, and a cover letter detailing your relevant experience to apply option.', '[\"[JOB_NAME]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_address]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_name]\",\"[company_address]\",\"[company_name]\"]', 'active', '2024-01-12 10:32:31', '2024-01-12 10:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `expert_levels`
--

CREATE TABLE `expert_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expert_levels`
--

INSERT INTO `expert_levels` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'Expert', '2023-08-23 11:08:51', '2023-08-23 11:08:51'),
(2, 'Intermediate', '2023-08-23 11:09:06', '2023-08-23 11:09:06'),
(3, 'Fresher', '2023-08-23 11:09:15', '2023-08-23 11:09:15'),
(4, 'No-Experience', '2023-10-07 04:14:59', '2023-10-07 04:14:59'),
(5, 'Internship', '2023-10-07 04:15:10', '2023-10-07 04:15:10');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `currency` varchar(191) DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `charge` double NOT NULL DEFAULT 0,
  `multiply` double NOT NULL DEFAULT 1,
  `namespace` varchar(191) NOT NULL,
  `min_amount` double NOT NULL DEFAULT 1,
  `max_amount` double NOT NULL DEFAULT 1000,
  `is_auto` int(11) NOT NULL DEFAULT 0,
  `image_accept` int(11) DEFAULT NULL,
  `test_mode` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `phone_required` int(11) NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `name`, `currency`, `logo`, `charge`, `multiply`, `namespace`, `min_amount`, `max_amount`, `is_auto`, `image_accept`, `test_mode`, `status`, `phone_required`, `data`, `comment`, `created_at`, `updated_at`) VALUES
(1, 'paypal', 'usd', '/demo/paypal.png', 2, 1, 'App\\Gateway\\Paypal', 1, 1000, 1, 0, 1, 0, 0, '{\"client_id\":\"\",\"client_secret\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(2, 'stripe', 'usd', '/demo/stripe.png', 2, 1, 'App\\Gateway\\Stripe', 1, 1000, 1, 0, 1, 0, 0, '{\"publishable_key\":\"\",\"secret_key\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(3, 'mollie', 'usd', '/demo/mollie.png', 2, 1, 'App\\Gateway\\Mollie', 1, 1000, 1, 0, 1, 1, 0, '{\"api_key\":\"test_WqUGsP9qywy3eRVvWMRayxmVB5dx2r\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(4, 'paystack', NULL, '/demo/paystack.png', 2, 1, 'App\\Gateway\\Paystack', 1, 1000, 1, 0, 1, 0, 0, '{\"public_key\":\"\",\"secret_key\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(5, 'razorpay', 'inr', '/demo/rajorpay.png', 2, 1, 'App\\Gateway\\Razorpay', 1, 10000, 1, 0, 1, 0, 0, '{\"key_id\":\"\",\"key_secret\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(6, 'instamojo', 'inr', '/demo/instamojo.png', 2, 1, 'App\\Gateway\\Instamojo', 1, 1000, 1, 0, 1, 0, 1, '{\"x_api_key\":\"\",\"x_auth_token\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(7, 'toyyibpay', 'rm', '/demo/toyybipay.png', 2, 1, 'App\\Gateway\\Toyyibpay', 1, 1000, 1, 0, 1, 0, 1, '{\"user_secret_key\":\"\",\"cateogry_code\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(8, 'flutterwave', NULL, '/demo/flutterwave.png', 2, 1, 'App\\Gateway\\Flutterwave', 1, 1000, 1, 0, 1, 0, 1, '{\"public_key\":\"\",\"secret_key\":\"\",\"encryption_key\":\"\",\"payment_options\":\"card\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(9, 'payu', NULL, '/demo/payu.png', 2, 1, 'App\\Gateway\\Payu', 1, 1000, 1, 0, 1, 0, 1, '{\"merchant_key\":\"\",\"merchant_salt\":\"\",\"auth_header\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17'),
(10, 'thawani', NULL, '/demo/uhawan.png', 1, 1, 'App\\Gateway\\Thawani', 1, 1000, 1, 0, 1, 0, 1, '{\"secret_key\":\"\",\"publishable_key\":\"\"}', NULL, '2025-03-01 00:00:17', '2025-03-01 00:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `jobbookmarks`
--

CREATE TABLE `jobbookmarks` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `opening_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_methods`
--

CREATE TABLE `kyc_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `image` varchar(191) NOT NULL,
  `image_accept` tinyint(1) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `fields` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kyc_methods`
--

INSERT INTO `kyc_methods` (`id`, `title`, `image`, `image_accept`, `status`, `fields`, `created_at`, `updated_at`) VALUES
(1, 'NID Card', '/uploads/card.png', 1, 1, '[{\"type\": \"text\", \"label\": \"ID No\"}, {\"type\": \"text\", \"label\": \"Date Of Birth\"}]', '2025-03-01 00:00:17', '2025-03-01 00:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `kyc_method_user`
--

CREATE TABLE `kyc_method_user` (
  `kyc_method_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `kyc_request_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_requests`
--

CREATE TABLE `kyc_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `request_id` varchar(191) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `kyc_method_id` bigint(20) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0 for pending, 1 for approved, 2 for rejected',
  `rejected_at` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `fields` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `meta` text DEFAULT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `slug`, `meta`, `location_id`, `created_at`, `updated_at`) VALUES
(1, 'Barcelona', 'bangladesh', NULL, NULL, NULL, NULL),
(3, 'Spain', 'dhaka', NULL, 1, NULL, NULL),
(6, 'New York', 'new-york', NULL, NULL, '2023-10-07 06:20:31', '2023-10-07 06:20:31'),
(7, 'Washington', 'washington', NULL, 6, '2023-10-07 06:20:42', '2023-10-07 06:20:42'),
(8, 'US', 'us', NULL, NULL, '2023-10-07 06:21:25', '2023-10-07 06:21:25'),
(9, 'UK', 'uk', NULL, NULL, '2023-10-07 06:21:29', '2023-10-07 06:21:29'),
(10, 'UAE', 'uae', NULL, NULL, '2023-10-07 06:21:40', '2023-10-07 06:21:40'),
(11, 'Italy', 'italy', NULL, NULL, '2023-10-07 06:21:46', '2023-10-07 06:21:46'),
(12, 'IN', 'in', NULL, NULL, '2023-10-07 06:21:57', '2023-10-07 06:21:57'),
(13, 'Washington', 'washington', NULL, 8, '2023-10-07 06:22:16', '2023-10-07 06:22:16'),
(14, 'California', 'california', NULL, 8, '2023-10-07 06:22:30', '2023-10-07 06:22:30'),
(15, 'New York', 'new-york', NULL, 8, '2023-10-07 06:22:46', '2023-10-07 06:22:46'),
(16, 'London', 'london', NULL, 9, '2023-10-07 06:23:00', '2023-10-07 06:23:00'),
(17, 'Manchester', 'manchester', NULL, 9, '2023-10-07 06:23:14', '2023-10-07 06:23:14'),
(18, 'Dubai', 'dubai', NULL, 10, '2023-10-07 06:23:33', '2023-10-07 06:23:33'),
(19, 'Milan', 'milan', NULL, 11, '2023-10-07 06:23:49', '2023-10-07 06:23:49'),
(20, 'Bangalore', 'bangalore', NULL, 12, '2023-10-07 06:24:12', '2023-10-07 06:24:12');

-- --------------------------------------------------------

--
-- Table structure for table `location_opening`
--

CREATE TABLE `location_opening` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `opening_id` bigint(20) UNSIGNED NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `state_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `location_opening`
--

INSERT INTO `location_opening` (`id`, `opening_id`, `country_id`, `state_id`) VALUES
(1, 1, 1, 3),
(2, 2, 8, 15),
(3, 3, 9, 16),
(4, 4, 9, 16),
(5, 5, 9, 16),
(6, 6, 9, 16),
(7, 7, 9, 16),
(8, 8, 9, 16),
(9, 9, 9, 16),
(10, 10, 9, 16),
(11, 11, 9, 16),
(12, 12, 9, 16),
(13, 13, 9, 16),
(14, 14, 9, 16);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `position` varchar(191) NOT NULL,
  `data` text NOT NULL,
  `lang` varchar(191) NOT NULL DEFAULT 'en',
  `status` varchar(191) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `position`, `data`, `lang`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Header', 'main-menu', '[{\"id\":\"e95lu1cs\",\"text\":\"Home\",\"icon\":null,\"href\":\"\\/\",\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"3qiac40d\",\"text\":\"HOME 01\",\"icon\":null,\"href\":\"\\/?home=One\",\"target\":\"_top\",\"title\":null,\"children\":[]},{\"id\":\"atpn3jwr\",\"text\":\"HOME 02\",\"icon\":null,\"href\":\"\\/?home=Two\",\"target\":\"_top\",\"title\":null,\"children\":[]},{\"id\":\"ieg5ytzm\",\"text\":\"HOME 03\",\"icon\":null,\"href\":\"\\/?home=Three\",\"target\":\"_top\",\"title\":null,\"children\":[]},{\"id\":\"5mtyob4l\",\"text\":\"HOME 04\",\"icon\":null,\"href\":\"\\/?home=Four\",\"target\":\"_top\",\"title\":null,\"children\":[]},{\"id\":\"jwnoa41y\",\"text\":\"HOME 05\",\"icon\":null,\"href\":\"\\/?home=Five\",\"target\":\"_top\",\"title\":null,\"children\":[]},{\"id\":\"5h9ksp0f\",\"text\":\"HOME 06\",\"icon\":null,\"href\":\"\\/?home=Six\",\"target\":\"_top\",\"title\":null,\"children\":[]},{\"id\":\"30wayalt\",\"text\":\"HOME 07\",\"icon\":null,\"href\":\"\\/?home=Seven\",\"target\":\"_top\",\"title\":null,\"children\":[]}]},{\"id\":\"gays8vco\",\"text\":\"Job\",\"icon\":null,\"href\":null,\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"desexes\",\"text\":\"Job List Style 1\",\"icon\":null,\"href\":\"\\/jobs?v=One&type=List\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"4p439l2s\",\"text\":\"Job List Style 2\",\"icon\":null,\"href\":\"\\/jobs?v=Two&type=List\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"4p439l2s\",\"text\":\"Job List Style 3\",\"icon\":null,\"href\":\"\\/jobs?v=Three&type=List\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"4p4h39asdfl2s\",\"text\":\"Job Grid Style 1\",\"icon\":null,\"href\":\"\\/jobs?v=One&type=Grid\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"4p439laahsdf2s\",\"text\":\"Job Grid Style 2\",\"icon\":null,\"href\":\"\\/jobs?v=Two&type=Grid\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"4p439lasdf2s\",\"text\":\"Job Grid Style 3\",\"icon\":null,\"href\":\"\\/jobs?v=Three&type=Grid\",\"target\":\"_self\",\"title\":null,\"children\":[]}]},{\"id\":\"cujvodo2\",\"text\":\"Explore\",\"icon\":null,\"href\":null,\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"cwdlw82k\",\"text\":\"Company\",\"icon\":null,\"href\":null,\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"4m2knasdfaq5\",\"text\":\"Company V1\",\"icon\":null,\"href\":\"\\/companies?v=One\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"dfghdfg\",\"text\":\"Company V2\",\"icon\":null,\"href\":\"\\/companies?v=Three\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"hb64tsj8\",\"text\":\"Company Details\",\"icon\":null,\"href\":\"\\/companies\\/payoneer\",\"target\":\"_self\",\"title\":null,\"children\":[]}]},{\"id\":\"cwdlwasd82k\",\"text\":\"Candidates\",\"icon\":null,\"href\":null,\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"4m2knasdfaq5\",\"text\":\"Candidates V1\",\"icon\":null,\"href\":\"\\/candidates?v=One\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"dfghdfasag\",\"text\":\"Candidates V3\",\"icon\":null,\"href\":\"\\/candidates?v=Three\",\"target\":\"_self\",\"title\":null,\"children\":[]}]},{\"id\":\"h0ycorln\",\"text\":\"Essential\",\"icon\":null,\"href\":\"#\",\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"lj8uay6g\",\"text\":\"About Us\",\"icon\":null,\"href\":\"\\/about-us\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"2sv79g95\",\"text\":\"Pricing\",\"icon\":null,\"href\":\"\\/pricing\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"brf4ioyu\",\"text\":\"Faq\",\"icon\":null,\"href\":\"\\/faq\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"i6n3pmy\",\"text\":\"Register\",\"icon\":null,\"href\":\"\\/register\",\"target\":\"_self\",\"title\":null,\"children\":[]}]}]},{\"id\":\"b2hbs7ik\",\"text\":\"Blog\",\"icon\":null,\"href\":\"\\/blogs\",\"target\":\"_self\",\"title\":null,\"children\":[{\"id\":\"30mxif0u\",\"text\":\"Blog Standard\",\"icon\":null,\"href\":\"\\/blogs?v=One\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"l8omdij5\",\"text\":\"Blog Grid\",\"icon\":null,\"href\":\"\\/blogs?v=Two\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"kns0kshb\",\"text\":\"Blog Full Width\",\"icon\":null,\"href\":\"\\/blogs?v=Three\",\"target\":\"_self\",\"title\":null,\"children\":[]}]},{\"id\":\"h7hrsutc\",\"text\":\"Contact Us\",\"icon\":null,\"href\":\"\\/contact-us\",\"target\":\"_self\",\"title\":null,\"children\":[]}]', 'en', '1', '2023-08-03 11:27:06', '2023-11-08 00:59:49'),
(2, 'Service', 'footer-left', '[{\"id\":\"ctw391xu\",\"text\":\"Browse Jobs\",\"icon\":null,\"href\":\"\\/jobs\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"7u90osuc\",\"text\":\"Companies\",\"icon\":null,\"href\":\"\\/companies\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"4r8wupe3\",\"text\":\"Candidates\",\"icon\":null,\"href\":\"\\/candidates\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"k15ht8xt\",\"text\":\"Pricing\",\"icon\":null,\"href\":\"\\/pricing\",\"target\":\"_self\",\"title\":null,\"children\":[]}]', 'en', '1', '2023-08-16 12:03:43', '2024-01-12 11:05:35'),
(3, 'Company', 'footer-center', '[{\"id\":\"gaj7mxr8\",\"text\":\"About us\",\"icon\":null,\"href\":\"\\/about-us\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"8c6fkq6c\",\"text\":\"About Us\",\"icon\":null,\"href\":\"\\/about\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"law145ip\",\"text\":\"Blogs\",\"icon\":null,\"href\":\"\\/blogs\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"ekteoag9\",\"text\":\"Contact\",\"icon\":null,\"href\":\"\\/contact-us\",\"target\":\"_self\",\"title\":null,\"children\":[]}]', 'en', '1', '2023-08-16 12:03:58', '2024-01-12 11:07:59'),
(4, 'Support', 'footer-right', '[{\"id\":\"d49e2gaz\",\"text\":\"Terms & conditions\",\"icon\":null,\"href\":\"\\/page\\/terms-and-conditions\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"ahjc6sxa\",\"text\":\"Privacy Policy\",\"icon\":null,\"href\":\"\\/page\\/privacy-policy\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"h59zzusx\",\"text\":\"Login\",\"icon\":null,\"href\":\"\\/login\",\"target\":\"_self\",\"title\":null,\"children\":[]},{\"id\":\"iimp8pdz\",\"text\":\"Help\",\"icon\":null,\"href\":\"\\/contact-us\",\"target\":\"_self\",\"title\":null,\"children\":[]}]', 'en', '1', '2023-08-16 12:04:10', '2024-01-12 11:16:11');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0000_00_00_000000_create_websockets_statistics_entries_table', 1),
(2, '2014_10_12_000000_create_users_table', 1),
(3, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2022_06_15_174621_create_kyc_methods_table', 1),
(7, '2022_06_16_160826_create_kyc_requests_table', 1),
(8, '2022_06_18_112841_create_kyc_method_user_table', 1),
(9, '2023_02_11_160234_create_supports_table', 1),
(10, '2023_02_11_160247_create_supportlogs_table', 1),
(11, '2023_02_12_163752_create_plans_table', 1),
(12, '2023_02_12_163758_create_gateways_table', 1),
(13, '2023_02_12_163759_create_orders_table', 1),
(14, '2023_02_12_170152_create_notifications_table', 1),
(15, '2023_02_13_130039_create_permission_tables', 1),
(16, '2023_02_14_181559_create_options_table', 1),
(17, '2023_02_19_082229_create_posts_table', 1),
(18, '2023_02_19_082240_create_categories_table', 1),
(19, '2023_02_19_082254_create_postcategories_table', 1),
(20, '2023_02_19_084742_create_categorymetas_table', 1),
(21, '2023_02_19_084751_create_postmetas_table', 1),
(22, '2023_02_19_085200_create_menus_table', 1),
(23, '2023_03_02_184250_create_jobs_table', 1),
(24, '2023_08_13_061914_create_locations_table', 1),
(25, '2023_08_13_063958_create_portfolios_table', 1),
(26, '2023_08_14_061337_create_userlocations_table', 1),
(27, '2023_08_14_062814_create_usercategories_table', 1),
(28, '2023_08_19_173011_create_openings_table', 1),
(29, '2023_08_19_173853_create_category_opening_table', 1),
(30, '2023_08_20_035610_create_qualifications_table', 1),
(31, '2023_08_20_035948_create_location_opening_table', 1),
(32, '2023_08_20_042238_create_expert_levels_table', 1),
(33, '2023_08_20_060113_create_userjobs_table', 1),
(34, '2023_08_20_060212_create_jobbookmarks_table', 1),
(35, '2023_08_20_060548_create_candidatebookmarks_table', 1),
(36, '2023_08_22_062431_create_user_education_qualifications_table', 1),
(37, '2023_08_22_171730_create_visitors_table', 1),
(38, '2023_08_23_065151_create_profile_visitors_table', 1),
(39, '2023_09_02_180132_create_conversations_table', 1),
(40, '2023_09_02_180136_create_replies_table', 1),
(41, '2023_09_06_144022_create_conversation_user_table', 1),
(42, '2023_09_13_115731_create_company_reviews_table', 1),
(43, '2023_10_23_112231_create_description_templates_table', 1),
(44, '2023_10_24_103751_create_category_templates_table', 1),
(45, '2023_10_28_033103_create_credit_logs_table', 1),
(46, '2023_10_29_050412_create_ai_templates_table', 1),
(47, '2023_11_01_045808_create_ai_template_user_table', 1),
(48, '2023_11_04_031152_create_ai_generates_table', 1),
(49, '2024_01_04_030850_create_candidate_reviews_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `seen` int(11) NOT NULL DEFAULT 0,
  `is_admin` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openings`
--

CREATE TABLE `openings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `short_description` text NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `salary_type` varchar(191) NOT NULL,
  `salary_range` text DEFAULT NULL,
  `currency` varchar(191) NOT NULL DEFAULT 'USD',
  `experience` varchar(191) NOT NULL,
  `expertise` varchar(191) NOT NULL,
  `featured_expire_at` date DEFAULT NULL,
  `live_expire_at` date DEFAULT NULL,
  `attachment` text DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `fields` text DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT '0' COMMENT '0: inactive, 1: active, 2: pending;',
  `apply_type` int(11) DEFAULT 0 COMMENT '0: default, 1: email, 2: external',
  `meta` text DEFAULT NULL,
  `expired_at` date DEFAULT NULL,
  `total_visits` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` text DEFAULT NULL,
  `lang` varchar(191) NOT NULL DEFAULT 'en'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `key`, `value`, `lang`) VALUES
(1, 'primary_data', '{\"logo\":\"/assets/images/logo/logo_01.png\",\"favicon\":\"/assets/images/fav-icon/icon.png\",\"contact_email\":\"contact@jobi.com\",\"contact_phone\":\"310.841.5500\",\"address\":\"1012 Pebda Parkway, Mirpur 2, Dhaka, Bangladesh\",\"socials\":{\"facebook\":\"https://www.facebook.com/\",\"youtube\":\"https://youtube.com/\",\"twitter\":\"https://twitter.com/\",\"instagram\":\"https://www.instagram.com/\",\"linkedin\":\"https://linkedin.com/\"},\"deep_logo\":\"/assets/images/logo/logo_03.png\"}', 'en'),
(2, 'tax', '0', 'en'),
(3, 'base_currency', '{\"name\":\"INR\",\"icon\":\"\\u20b9\",\"position\":\"left\"}', 'en'),
(4, 'invoice_data', '{\"company_name\":\"Whatserve\",\"address\":\"San francisco\",\"city\":\"California\",\"country\":\"USA\",\"post_code\":\"12345\"}', 'en'),
(5, 'languages', '{\"en\":\"English\"}', 'en'),
(6, 'seo_home', '{\"site_name\":\"Home\",\"matatag\":\"\",\"matadescription\":\"\",\"twitter_site_title\":\"home\",\"preview\":\"\"}', 'en'),
(7, 'seo_blog', '{\"site_name\":\"Blogs\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(8, 'seo_about', '{\"site_name\":\"About Us\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(9, 'seo_pricing', '{\"site_name\":\"Pricing\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(10, 'seo_contact', '{\"site_name\":\"Contact Us\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(11, 'seo_faq', '{\"site_name\":\"Faq\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(12, 'seo_team', '{\"site_name\":\"Our Team\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(13, 'seo_features', '{\"site_name\":\"Features\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(14, 'seo_how_its_works', '{\"site_name\":\"How its work\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(15, 'header_footer', '{\"header\":{\"announcement_type\":\"NOW HIRING:\",\"announcement_title\":\"Are You A Driven And Motivated 1st Line IT Support Engineer?\",\"announcement_link\":\"\\/contact\"},\"footer\":{\"title\":\"Ready To Launch \\ud83d\\ude80\",\"description\":\"Automate your conversations and boost your marketing strategy\",\"right_image_link\":\"\\/pricing\",\"left_image_link\":\"\\/pricing\"},\"footer_button_image\":\"\\/demo\\/1678211121jY056A0fKjEFLQN7lJeZ.png\",\"footer_left_button_image\":\"\\/demo\\/1678211121yYLog9HsVoV5QCJAvX4g.png\"}', 'en'),
(16, 'home-page', '{\"heading\":{\"title\":\"Boost your marketing with <strong>WASender<\\/strong>\",\"left_button_link\":\"\\/pricing\",\"right_button_link\":\"\\/pricing\"},\"brand\":{\"title\":\"Over 32K+ software businesses growing with WASender\",\"status\":\"active\"},\"cta\":{\"title\":\"More than 13,000 teams use our platform\"},\"features\":{\"title\":\"Explore Our Amazing Features \\ud83d\\udd25\",\"status\":\"active\"},\"platform\":{\"title\":\"Start Building Chatbot using WASender\",\"description\":\"We provide a bird`s eye perspective of your entire bot, which aids in the development of a highly engaging bot. You can create, test, and build chatbots graphically using a single no-code online interface.\",\"button_title\":\"Get Started\",\"button_link\":\"\\/pricing\"},\"account_area\":{\"heading\":\"Create your free account\",\"subheading\":\"It takes only 3 minutes to get started\",\"description\":\"Plug your messaging channels, install your widget and\\r\\nyou\\u2019re ready to go\",\"form_link\":\"\\/register\\/2\",\"status\":\"active\",\"button_link1\":\"\\/pricing\",\"button_link2\":\"\\/pricing\"},\"about\":{\"title\":\"Whatsapp Automation\",\"description\":\"A WhatsApp bot can work around the clock and can handle multiple requests simultaneously, which means that it is always available to assist customers, even outside of regular business hours.\",\"action_area_title\":\"Lets create a Whatsapp chatbot \\ud83d\\ude80\"},\"top_faq\":{\"title\":\"WASender For Creatives business \\ud83d\\ude07\",\"description\":\"WASender is the best quaint james bond victoria sponge happy days cras arse over blatant\"},\"integration\":{\"title\":\"Top Integration \\ud83e\\udd1d\\ud83c\\udffb\"},\"testimonial\":{\"title\":\"User Feedback \\ud83c\\udf96\\ufe0f\"},\"calltoaction\":{\"title\":\"Discover a better way to <br> manage spendings\",\"button_title\":\"Get Started Now\",\"button_link\":\"\\/pricing\"},\"right_button_image\":\"\\/demo\\/16782229849w7zEZUReAELpYZzBhfy.png\",\"left_button_image\":\"\\/demo\\/16782229844xnXg3VVbopZTUmCVkoP.png\",\"hero_left_image\":\"\\/uploads\\/1680991267dcZhpgfhm46WulMpbFmU.png\",\"hero_image\":\"\\/demo\\/1678140600lS8T5SkGWjUDMw00x8aR.png\",\"testimonial_cover\":\"\\/uploads\\/1680990550b4VGZjg5I0mHrS0ZEzEO.png\",\"integration_cover\":\"\\/uploads\\/1680691072MdDwD8iZV7nFu32OLg7Z.png\",\"integration_left\":\"\\/uploads\\/1680687785yK5jB6wU8F0njvElGAqE.png\",\"integration_right\":\"\\/uploads\\/1680687785b4Qk1bP8HMnMCuedEqOo.png\",\"hero_right_image\":\"\\/uploads\\/1680991267IpQIAwGSbY5ZIFRwO6Pp.png\",\"cta_logo\":\"\\/demo\\/1678039536jzV8Ut6FTWgytwnEZxo0.png\",\"cta_thumbnail\":\"\\/demo\\/1678139635o3AHoY7EGdexS7UuUajq.png\",\"platform_thumbnail\":\"\\/demo\\/1678139743EuXomMHlbRJIEUobx62D.png\",\"account_area_thumbnail\":\"\\/demo\\/1678140032Wxqq2w6cndL4uWiEHf8B.png\",\"account_area_top_thumbnail\":\"\\/demo\\/1678039536eRShFlGn3Uw9tN1X14E0.png\",\"account_area_bottom_thumbnail\":\"\\/demo\\/16780395365JXHyeVBXUVAldB1V5Se.png\",\"account_footer_left_image\":\"\\/demo\\/16780395365VbXNjp8vpREwrrQ8R44.png\",\"account_footer_right_image\":\"\\/demo\\/1678039536cX0XI21coIdJ3M1Im54A.png\",\"faq_cover\":\"\\/uploads\\/1680990550DfwMWKaP9MfCYR6fPued.png\",\"about_cover\":\"\\/uploads\\/1680989187xEbFX8vGfdBmWfMkb3Xo.gif\"}', 'en'),
(17, 'why-choose', '{\"title\":\"Why choose WASender \\ud83c\\udf96\\ufe0f\",\"subtitle\":\"Get start\",\"left_button_link\":\"\\/pricing\",\"right_button_link\":\"\\/pricing\",\"left_block_title\":\"Active Customers\",\"left_block_value\":\"1200\",\"center_block_title\":\"Total Customers\",\"center_block_value\":\"1500\",\"right_block_title\":\"Positive Reviews\",\"right_block_value\":\"600\",\"left_button_image\":\"\\/demo\\/1678120554l1bhGUjz28tmiBtCqTK6.png\",\"right_button_image\":\"\\/demo\\/1678120554IAVDm9xBLZXYtGAamM0I.png\",\"left_block_image\":\"\\/demo\\/1678120554hneDbhf9WG6aXvdV0h6q.png\",\"center_block_image\":\"\\/demo\\/1678120554PcP79pqqlziQ71Yf1T70.png\",\"right_block_image\":\"\\/demo\\/1678120554dGH99dtfF4slpDVVHjT1.png\"}', 'en'),
(18, 'contact-page', '{\"address\":\"1012 Pebda Parkway, Mirpur 2 Dhaka,\",\"country\":\"Bangladesh\",\"map_link\":\"https:\\/\\/maps.google.com\\/maps?width=600&height=400&hl=en&q=dhaka%20collage&t=&z=12&ie=UTF8&iwloc=B&output=embed\",\"contact1\":\"8801234567890\",\"contact2\":\"8801234567891\",\"email1\":\"support@email.com\",\"email2\":\"contact@email.com\",\"contact_info_text\":\"Open a chat or give us call at\",\"contact_info_number\":\"310.841.5500\",\"live_chat_service_text\":\"live chat service\",\"live_chat_service_website\":\"www.jobilivechat.com\"}', 'en'),
(19, 'about-page', '{\"cta_s1\":{\"features\":[{\"title\":\"Who we are?\",\"body\":\"Our founders Dustin Moskovitz and Justin lorem Rosenstein met while leading Engineering teams at Facebook quesi. Lorem ipsum dolor sit, amet consectetur adipisicing elit.\"},{\"title\":\"What\\u2019s our goal\",\"body\":\"Our founders Dustin Moskovitz and Justin lorem Rosenstein met while leading Engineering teams at Facebook quesi. Lorem ipsum dolor sit, amet consectetur adipisicing elit.\"},{\"title\":\"Our vision\",\"body\":\"Our founders Dustin Moskovitz and Justin lorem Rosenstein met while leading Engineering teams at Facebook quesi. Lorem ipsum dolor sit, amet consectetur adipisicing elit.\"}],\"title\":\"We\\u2019ve been helping customer globally.\",\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s2\":{\"title\":\"Get over 50.000+ talented experts in jobi.\",\"subtitle\":\"A full hybrid workforce management tools are yours to use, as well as access to our top 1% of talent.\",\"features\":\"Seamless searching, Get top 3% experts for your project, Get top 3% experts for your project\",\"btn_text\":\"Post A Job\",\"btn_link\":\"\\/employer\\/jobs\\/create\",\"image1\":\"\\/assets\\/images\\/assets\\/img_02.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/img_03.jpg\",\"image3\":\"\\/assets\\/images\\/assets\\/img_04.jpg\",\"image4\":\"\\/assets\\/images\\/assets\\/screen_01.png\",\"image5\":\"\\/assets\\/images\\/assets\\/screen_02.png\",\"image6\":\"\\/assets\\/images\\/assets\\/screen_03.png\"},\"video_s1\":{\"link\":\"https:\\/\\/www.youtube.com\\/embed\\/aXFSJTjVjw0\",\"image\":\"\\/assets\\/images\\/assets\\/img_45.jpg\",\"completed_jobs\":\"7million\",\"clients\":\"30k+\",\"applied_jobs\":\"13billion\"}}', 'en'),
(20, 'counter', '{\"experience\":\"12\",\"active_customers\":\"900\",\"positive_reviews\":\"200\",\"satisfied_customers\":\"800\"}', 'en'),
(21, 'theme_path', '{\"home\":\"One\",\"job_list\":{\"path\":\"One\",\"type\":\"List\"},\"job_detail\":\"One\",\"candidate_list\":\"One\",\"candidate_detail\":\"One\",\"company_list\":\"One\",\"blog\":\"One\"}', 'en'),
(22, 'themeFive', '{\"hero\":{\"title\":\"Find your Job without any hassle.\",\"subtitle\":\"With the largest professional creative community online, simply search through from our website\",\"image1\":null,\"image3\":null,\"image4\":null,\"image\":\"\\/uploads\\/24\\/01\\/PkIUOORPcY07PDT4T5Ud.jpg\",\"image2\":\"\\/uploads\\/24\\/01\\/KKIWeulNoCuNjODNSAsY.png\",\"image5\":null,\"image6\":null},\"cta_s1\":{\"title\":\"Find top talents from jobi.\",\"features\":[{\"title\":\"Seamless Search\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"},{\"title\":\"Hire top talents\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customizable page design to reflect your brand.\"},{\"title\":\"Protected payments, every time\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customizable page design to reflect your brand.\"}],\"btn_text\":\"Learn More\",\"btn_link\":\"\\/candidates\",\"image1\":\"\\/assets\\/images\\/assets\\/screen_09.png\",\"image2\":\"\\/assets\\/images\\/assets\\/screen_08.png\",\"image\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s2\":{\"image\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"title\":\"Complete <span class=\\\"fw-light fst-italic\\\">job portal<\\/span> for everyone.\",\"left_btn_text\":\"Looking for job?\",\"left_btn_link\":\"\\/jobs\",\"right_btn_text\":\"Post A Job\",\"right_btn_link\":\"\\/register\",\"image1\":\"\\/uploads\\/24\\/01\\/ASsazUvtF4F3SFaGlH68.png\"},\"cta_s3\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s4\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"feedback_section\":{\"image\":null,\"image1\":null}}', 'en'),
(23, 'themeFour', '{\"hero\":{\"title\":\"Find your job without any hassle.\",\"subtitle\":\"Jobs & Job search. Find jobs in global. Executive jobs & work.\",\"btn_text\":\"Upload Your CV\",\"btn_link\":\"\\/register\",\"image\":\"\\/uploads\\/24\\/01\\/gYRnsN9H7VweG7zRsfn8.jpg\",\"image5\":null,\"image6\":null,\"image1\":\"\\/uploads\\/24\\/01\\/qkF6xFc1pD9qBiUX3DpR.png\",\"image2\":\"\\/uploads\\/24\\/01\\/hOz25CbpLRbcZ4z65OVN.png\",\"image3\":\"\\/uploads\\/24\\/01\\/TODhc2kNycELTJHs4pKp.png\",\"image4\":\"\\/uploads\\/24\\/01\\/k4mf8qieimApokUmc5es.png\"},\"cta_s1\":{\"title\":\"Get the job of your dreams quickly.\",\"subtitle\":\"Commonly used in the graphic, print publishing industris for previewing visual mockups. limited social discrimination.\",\"btn_text\":\"Find your job.\",\"btn_link\":\"\\/jobs\",\"image1\":\"\\/assets\\/images\\/assets\\/img_28.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/screen_14.png\",\"item1\":\"7million\",\"item2\":\"30k+\",\"item3\":\"13billion\",\"image\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s2\":{\"top_title\":\"LOOKING FOR AN EXPERT?\",\"title\":\"Find top talents from jobi.\",\"features\":[{\"title\":\"Seamless Search\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customizable page design to reflect your brand.\"},{\"title\":\"Hire top talents\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customizable page design to reflect your brand.\"}],\"btn_text\":\"Find Talents\",\"btn_link\":\"\\/candidates\",\"image1\":\"\\/assets\\/images\\/assets\\/img_11.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/img_12.jpg\",\"image3\":\"\\/assets\\/images\\/assets\\/img_13.jpg\",\"image\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s3\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s4\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"feedback_section\":{\"image\":null,\"image1\":null}}', 'en'),
(24, 'themeOne', '{\"hero\":{\"title\":\"Find & Hire  Top 3% of expert on jobi.\",\"subtitle\":\"We delivered blazing fast & striking work solution\",\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image\":\"\\/uploads\\/23\\/12\\/RtUH0F0vJ2zhUusqEYOA.jpg\",\"image5\":null,\"image6\":null},\"cta_s1\":{\"title\":\"Get over 50.000+ talented experts in jobi.\",\"subtitle\":\"A full hybrid workforce management tools are yours to use, as well as access to our top 1% of talent.\",\"features\":\"Seamless searching, Get top 3% experts for your project, Get top 3% experts for your project\",\"btn_text\":\"Post A Job\",\"btn_link\":\"\\/employer\\/jobs\\/create\",\"image1\":\"\\/assets\\/images\\/assets\\/img_02.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/img_03.jpg\",\"image3\":\"\\/assets\\/images\\/assets\\/img_04.jpg\",\"image4\":\"\\/assets\\/images\\/assets\\/screen_01.png\",\"image5\":\"\\/assets\\/images\\/assets\\/screen_02.png\",\"image6\":\"\\/assets\\/images\\/assets\\/screen_03.png\",\"image\":null},\"cta_s2\":{\"top_title\":\"TOP BRAND\",\"title\":\"Collaboration with Top Brands.\",\"subtitle\":\"We collaborate with a number of top tier companies on imagining the future of work, have a look.\",\"btn_text\":\"Learn More\",\"btn_link\":\"\\/about-us\",\"image1\":\"\\/assets\\/images\\/logo\\/logo_02.png\",\"image2\":\"\\/assets\\/images\\/logo\\/media_09.png\",\"image3\":\"\\/assets\\/images\\/logo\\/media_10.png\",\"image4\":\"\\/assets\\/images\\/logo\\/media_11.png\",\"image5\":\"\\/assets\\/images\\/logo\\/media_12.png\",\"image6\":\"\\/assets\\/images\\/logo\\/media_13.png\",\"image\":null},\"cta_s3\":{\"title\":\"Get your <br><span>Matched Jobs<\\/span> in a few minutes. aa\",\"subtitle\":\"Find your dream job & earn from world leading brands. Upload your CV now. vvv\",\"btn_text\":\"Upload Your CV\",\"btn_link\":\"\\/\",\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"image\":\"\\/uploads\\/23\\/12\\/GiVJfQEpt43cjSVa9wLc.png\"},\"category_section\":{\"title\":\"Most Demanding Categories.\",\"title_right\":\"Together with useful notifications, collaboration, insights, and improvement tip lorem etc.\",\"btn_text\":\"Explore all fields\",\"btn_link\":\"\\/jobs\"},\"cta_s4\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"feedback_section\":{\"image\":null,\"image1\":null}}', 'en'),
(25, 'themeSeven', '{\"hero\":{\"title\":\"Find & Hire Experts for any Job\",\"subtitle\":\"Jobs & Job search. Find jobs in global. Executive jobs & work.\",\"image\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"image1\":\"\\/uploads\\/24\\/01\\/Dz71AocCx5Ui4nxPO6gP.png\",\"image2\":\"\\/uploads\\/24\\/01\\/yfH0YieA2AwZ9jW6nJZ6.png\"},\"cta_s1\":{\"top_title\":\"Why choose us?\",\"title\":\"World of talent at your fingertips\",\"features\":[{\"title\":\"Seamless Search\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"},{\"title\":\"Hire top talents\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customizable page design to reflect your brand.\"},{\"title\":\"Protected payments, every time\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customizable page design to reflect your brand.\"}],\"btn_text\":\"Learn More\",\"btn_link\":\"\\/candidates\",\"image1\":\"\\/assets\\/images\\/assets\\/img_37.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/img_38.jpg\",\"image3\":\"\\/assets\\/images\\/assets\\/img_04.jpg\",\"image4\":\"\\/assets\\/images\\/assets\\/screen_01.png\",\"image5\":\"\\/assets\\/images\\/assets\\/screen_02.png\",\"image6\":\"\\/assets\\/images\\/assets\\/screen_03.png\",\"image\":null},\"cta_s2\":{\"title\":\"Get your Matched Jobs in a few minutes.\",\"subtitle\":\"Find your dream job & earn from world leading brands. Upload your CV now.\",\"btn_text\":\"Upload your CV\",\"btn_link\":\"\\/register\",\"image1\":\"\\/assets\\/images\\/assets\\/img_41.png\",\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"image\":\"\\/uploads\\/24\\/01\\/c8B9um8aV7RNO2uZ1kTF.png\"},\"cta_s3\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s4\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"feedback_section\":{\"image\":null,\"image1\":null}}', 'en'),
(26, 'themeSix', '{\"hero\":{\"title\":\"Find & Hire Experts for any Job.\",\"subtitle\":\"Unlock your potential with quality job & earn from world leading brands.\",\"item1\":\"30k+\",\"item2\":\"3%\",\"item3\":\"12mil\",\"image\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"image1\":\"\\/uploads\\/24\\/01\\/27OBaO0hGUrgugYih29s.jpg\",\"image2\":\"\\/uploads\\/24\\/01\\/oNHQJbw1cW0XDQ9HHzrZ.jpg\",\"image3\":\"\\/uploads\\/24\\/01\\/flP1ftVXJh9bnureGEJF.jpg\"},\"cta_s1\":{\"video\":\"https:\\/\\/www.youtube.com\\/embed\\/aXFSJTjVjw0\",\"title\":\"Let\\u2019s get started It\\u2019s <span style=\\\"color: #00BF58;\\\">simple.<\\/span>\",\"subtitle\":\"Get access to our top 1% talent as well as a complete set of hybrid workforce management tools.\",\"image1\":\"\\/assets\\/images\\/assets\\/img_21.jpg\",\"image\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"video_id\":\"XJTD3VOIWuw\",\"steps\":[{\"title\":\"It\\u2019s take 2 minutes to open an account.\",\"text\":\"OPEN ACOUNT\",\"link\":\"\\/register\"},{\"title\":\"Find talents or search your desire work.\",\"text\":\"APPLY JOB OR HIRE\",\"link\":\"\\/register\"},{\"title\":\"Get work done quickly with jobi gateway.\",\"text\":\"PAYMENT METHOD\",\"link\":\"\\/register\"}]},\"cta_s2\":{\"top_title\":\"Why choose us?\",\"title\":\"World of talent at your fingertips\",\"features\":[{\"title\":\"Seamless Search\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"},{\"title\":\"Hire top talents\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"},{\"title\":\"Protected payments, every time\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"}],\"btn_text\":\"Learn More\",\"btn_link\":\"\\/candidates\",\"image1\":\"\\/assets\\/images\\/assets\\/img_37.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/img_38.jpg\",\"image3\":\"\\/assets\\/images\\/assets\\/img_04.jpg\",\"image4\":\"\\/assets\\/images\\/assets\\/screen_01.png\",\"image5\":\"\\/assets\\/images\\/assets\\/screen_02.png\",\"image6\":\"\\/assets\\/images\\/assets\\/screen_03.png\",\"image\":null},\"cta_s3\":{\"top_title\":\"TOP BRAND\",\"title\":\"Collaboration with Top Brands.\",\"subtitle\":\"We collaborate with a number of top tier companies on imagining the future of work, have a look.\",\"btn_text\":\"Learn More\",\"btn_link\":\"\\/about-us\",\"image1\":\"\\/assets\\/images\\/logo\\/logo_02.png\",\"image2\":\"\\/assets\\/images\\/logo\\/media_09.png\",\"image3\":\"\\/assets\\/images\\/logo\\/media_10.png\",\"image4\":\"\\/assets\\/images\\/logo\\/media_11.png\",\"image5\":\"\\/assets\\/images\\/logo\\/media_12.png\",\"image6\":\"\\/assets\\/images\\/logo\\/media_13.png\",\"image\":null},\"cta_s4\":{\"image\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"title\":\"Complete job portal for everyone.\",\"subtitle\":\"Find your dream job & earn from all world the leading brands.\",\"left_btn_text\":\"Looking for job?\",\"left_btn_link\":\"\\/jobs\",\"right_btn_text\":\"Start Hiring\",\"right_btn_link\":\"\\/candidates\",\"image1\":\"\\/uploads\\/24\\/01\\/0yFtMJXzrHMYsuSIOR76.jpg\"},\"feedback_section\":{\"image1\":null,\"title\":\"What\\u2019s our clients Think of us?\",\"image\":\"\\/uploads\\/24\\/01\\/9Qo7coQfRhyItEHYSOQj.jpg\"}}', 'en'),
(27, 'themeThree', '{\"hero\":{\"top_title\":\"#1 Online Marketplace\",\"title\":\"Find the talents for any job.\",\"subtitle\":\"Unlock your potential with quality job & earn from world leading brands & co.\",\"btn_text\":\"Post a Job\",\"btn_link\":\"\\/register\",\"image\":null,\"image4\":null,\"image1\":\"\\/uploads\\/24\\/01\\/OGZAKU0eo6CHo2mqFT2S.png\",\"image2\":\"\\/uploads\\/24\\/01\\/TdyR8PZjnZNqleMt7Jza.png\",\"image3\":\"\\/uploads\\/24\\/01\\/oIRhJc4mzhRGT9NE2Wiq.png\",\"image5\":null,\"image6\":null},\"cta_s1\":{\"top_title\":\"Why choose us?\",\"title\":\"World of talent at your fingertips\",\"features\":[{\"title\":\"Seamless Search\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"},{\"title\":\"Hire top talents\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"},{\"title\":\"Protected payments, every time\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand.\"}],\"btn_text\":\"Learn More\",\"btn_link\":\"\\/about-us\",\"image1\":\"\\/assets\\/images\\/assets\\/screen_09.png\",\"image2\":\"\\/assets\\/images\\/assets\\/screen_08.png\",\"image\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s2\":{\"top_title\":\"Business Solution\",\"title\":\"Get quick Solution for your business.\",\"subtitle\":\"A full suite of hybrid workforce management tools are yours to use, as well as access to our top 1% of talent.\",\"btn_text\":\"Explore Jobi business\",\"btn_link\":\"\\/about-us\",\"image1\":\"\\/assets\\/images\\/assets\\/img_20.jpg\",\"item1\":\"30k+\",\"item2\":\"3%\",\"item3\":\"7mil\",\"image\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s3\":{\"video\":\"https:\\/\\/www.youtube.com\\/embed\\/fU39_3wrtoc\",\"title\":\"Let\\u2019s get started It\\u2019s simple.\",\"subtitle\":\"Get access to our top 1% talent as well as a complete set of hybrid workforce management tools.\",\"image\":\"\\/assets\\/images\\/assets\\/img_21.jpg\",\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"footer_item1\":\"It\\u2019s take 2 minutes to open an account.\",\"footer_item2\":\"Find talents or search your desire work.\",\"footer_item3\":\"Get work done quickly with jobi gatweay.\"},\"cta_s4\":{\"title\":\"Collaboration with leading Brands.\",\"subtitle\":\"We collaborate with a number of top tier companies on imagining the future of work, have a look.\",\"btn_text\":\"Learn More\",\"btn_link\":\"\\/companies\",\"circle_text1\":\"100+\",\"circle_text2\":\"Leading Brands\",\"image1\":\"\\/assets\\/images\\/logo\\/logo_05.png\",\"image2\":\"\\/assets\\/images\\/logo\\/media_17.png\",\"image3\":\"\\/assets\\/images\\/logo\\/media_18.png\",\"image4\":\"\\/assets\\/images\\/logo\\/media_19.png\",\"image5\":\"\\/assets\\/images\\/logo\\/media_20.png\",\"image6\":\"\\/assets\\/images\\/logo\\/media_21.png\",\"image\":null},\"footer_cats\":[{\"id\":\"1\",\"title\":\"Trending Skills\",\"items\":[{\"text\":\"Blockchain\",\"url\":\"\\/jobs\"},{\"text\":\"Node.js\",\"url\":\"\\/jobs\"},{\"text\":\"HR consulting\",\"url\":\"\\/jobs\"},{\"text\":\"Vue.js\",\"url\":\"\\/jobs\"},{\"text\":\"Microsoft Power BI\",\"url\":\"\\/jobs\"},{\"text\":\"React.js\",\"url\":\"\\/jobs\"},{\"text\":\"Videographers\",\"url\":\"\\/jobs\"}]},{\"id\":\"2\",\"title\":\"Top Skills\",\"items\":[{\"text\":\"Full Consultation\",\"url\":\"\\/jobs\"},{\"text\":\"Code Review\",\"url\":\"\\/jobs\"},{\"text\":\"Staff Augmentation\",\"url\":\"\\/jobs\"},{\"text\":\"Support\",\"url\":\"\\/jobs\"},{\"text\":\"Video Editors\",\"url\":\"\\/jobs\"},{\"text\":\"Data Entry Specialists\",\"url\":\"\\/jobs\"},{\"text\":\"Data Analyst\",\"url\":\"\\/jobs\"}]},{\"id\":\"3\",\"title\":\"Top in USA\",\"items\":[{\"text\":\"Technical Support\",\"url\":\"\\/jobs\"},{\"text\":\"Accountants\",\"url\":\"\\/jobs\"},{\"text\":\"Web Designers in US\",\"url\":\"\\/jobs\"},{\"text\":\"Customer identity\",\"url\":\"\\/jobs\"},{\"text\":\"Data Entry\",\"url\":\"\\/jobs\"}]},{\"id\":\"4\",\"title\":\"Project Catalog\",\"items\":[{\"text\":\"Microsites\",\"url\":\"\\/jobs\"},{\"text\":\"Marketing Automation\",\"url\":\"\\/jobs\"},{\"text\":\"SEO & SMM\",\"url\":\"\\/jobs\"},{\"text\":\"Lead Generation\",\"url\":\"\\/jobs\"},{\"text\":\"Article Writing Services\",\"url\":\"\\/jobs\"},{\"text\":\"SEO Services\",\"url\":\"\\/jobs\"},{\"text\":\"Translation Services\",\"url\":\"\\/jobs\"}]}],\"feedback_section\":{\"image\":null,\"image1\":null},\"category_section\":[]}', 'en'),
(28, 'themeTwo', '{\"hero\":{\"title\":\"Find & Hire Top 3% of expert on jobi.\",\"subtitle\":\"With the largest professional creative community online, simply search through from our website\",\"footer_item1\":\"18k+\",\"footer_item2\":\"A+ Rating\",\"footer_item3\":\"5\",\"footer_item4\":\"4.78 (300k+)\",\"image\":null,\"image4\":\"\\/uploads\\/24\\/01\\/sHcf1GmEBdCxkLtc5My4.png\",\"image5\":null,\"image6\":null,\"image1\":\"\\/uploads\\/24\\/01\\/uRbzm9kEtmhOVqmx0Of9.png\",\"image3\":\"\\/uploads\\/24\\/01\\/9B1hgJVP5E5p9IQmEn1O.png\",\"image2\":\"\\/uploads\\/24\\/01\\/K1S9U3dZpXd4nGnqRLs3.png\"},\"cta_s1\":{\"title\":\"Get the job of your dreams quickly.\",\"subtitle\":\"AInciddnt ut labore et dolor magna aliu. enim ad mim venam, quis nostru\",\"features\":\"Seamless searching, Protected payments every time, Wide rang of job categories\",\"btn_text\":\"Learn More\",\"btn_link\":\"\\/\",\"image1\":\"\\/assets\\/images\\/assets\\/img_11.jpg\",\"image2\":\"\\/assets\\/images\\/assets\\/img_12.jpg\",\"image3\":\"\\/assets\\/images\\/assets\\/img_13.jpg\",\"video\":\"https:\\/\\/www.youtube.com\\/embed\\/aXFSJTjVjw0\",\"image\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"item1\":\"7million\",\"item2\":\"30k+\",\"item3\":\"13billion\",\"video_id\":\"fU39_3wrtoc\"},\"cta_s2\":{\"top_title\":\"FIND FREELANCER\",\"title\":\"Hire top talents\",\"features\":[{\"title\":\"Seamless Search\",\"body\":\"It only takes 5 minutes. Set-up is smooth and simple, with fully customisable page design to reflect your brand. It only takes 5 minutes.\"},{\"title\":\"Hire top talents\",\"body\":\"Practice what you learned on realistic lorem quis test questions testing.\"}],\"btn_text\":\"Explorer All\",\"btn_link\":\"\\/faq\",\"image\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null,\"image1\":\"\\/uploads\\/24\\/01\\/pkIjBFMZjQ52IBa5mmeJ.png\",\"image2\":\"\\/uploads\\/24\\/01\\/QZP5oMhpkLXBvCTfb1wf.png\"},\"cta_s3\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"cta_s4\":{\"image\":null,\"image1\":null,\"image2\":null,\"image3\":null,\"image4\":null,\"image5\":null,\"image6\":null},\"feedback_section\":{\"top_title\":\"TESTIMONIAL\",\"title\":\"Clients loves jobi.\",\"bottom_title\":\"A+ Rating\",\"bottom_sub_title\":\"Avg rating 4.8 makes us best marketplace.\",\"image\":null,\"image1\":null}}', 'en'),
(29, 'seo_login', '{\"site_name\":\"Sign In\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(30, 'seo_register', '{\"site_name\":\"Sign Up\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(31, 'seo_job_list', '{\"site_name\":\"Jobs\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(32, 'seo_candidate_list', '{\"site_name\":\"Candidates\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(33, 'seo_companies', '{\"site_name\":\"Companies\",\"matatag\":\"\",\"matadescription\":\"\",\"preview\":\"\"}', 'en'),
(34, 'per_credit_fee', '1', 'en'),
(35, 'per_word_credit', '1', 'en');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(191) DEFAULT NULL,
  `payment_id` varchar(191) DEFAULT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `gateway_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `will_expire` date DEFAULT NULL,
  `meta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `group_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `group_name`, `created_at`, `updated_at`) VALUES
(1, 'about', 'web', 'Appearance', '2025-03-01 00:00:18', '2025-03-01 00:00:18'),
(2, 'blogs', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(3, 'blog-category', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(4, 'blog-tags', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(5, 'faq', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(6, 'features', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(7, 'team', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(8, 'language', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(9, 'menu', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(10, 'custom-page', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(11, 'partners', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(12, 'seo', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(13, 'testimonials', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(14, 'theme-setting', 'web', 'Appearance', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(15, 'page-settings', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(16, 'admin', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(17, 'developer-settings', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(18, 'roles', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(19, 'currency', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(20, 'locations', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(21, 'qualifications', 'web', 'Site Settings', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(22, 'customer', 'web', 'User Logs', '2025-03-01 00:00:19', '2025-03-01 00:00:19'),
(23, 'notification', 'web', 'User Logs', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(24, 'ai-templates', 'web', 'Ai Templates', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(25, 'ai-generated-history', 'web', 'Ai Templates', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(26, 'ai-language', 'web', 'Ai Templates', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(27, 'cron-job', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(28, 'gateways', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(29, 'order', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(30, 'subscriptions', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(31, 'support', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(32, 'companies', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(33, 'candidates', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(34, 'company-reviews', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(35, 'candidate-reviews', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(36, 'expert-levels', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(37, 'faq-category', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(38, 'jobs', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(39, 'job-service', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(40, 'job-category', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(41, 'job-tags', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(42, 'kyc-methods', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(43, 'kyc-requests', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20'),
(44, 'message-requests', 'web', 'Site Functionalities', '2025-03-01 00:00:20', '2025-03-01 00:00:20');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 3, 'auth_token', '8d05cbe16e3331312d2dcec5c01553e8a7da57bdbfe5ef2971b297cfdd649590', '[\"*\"]', NULL, NULL, '2025-03-01 00:42:34', '2025-03-01 00:42:34'),
(2, 'App\\Models\\User', 7, 'auth_token', '5e29286c40e414dba42039729e09c642455ae1c2bfa48f85aab99de50c05be5f', '[\"*\"]', NULL, NULL, '2025-03-01 01:02:56', '2025-03-01 01:02:56');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `is_featured` int(11) NOT NULL DEFAULT 0,
  `is_recommended` int(11) NOT NULL DEFAULT 0,
  `is_default` int(11) NOT NULL DEFAULT 0,
  `is_trial` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `days` int(11) NOT NULL DEFAULT 0,
  `trial_days` int(11) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `title`, `price`, `is_featured`, `is_recommended`, `is_default`, `is_trial`, `status`, `days`, `trial_days`, `data`, `created_at`, `updated_at`) VALUES
(1, 'Starter', 10, 1, 0, 1, 0, 1, 30, 0, '{\"job_limit\":10,\"featured_jobs\":5,\"live_job_for_days\":60,\"ai_credits\":1000}', '2023-10-05 12:59:25', '2023-10-05 13:01:25'),
(2, 'Enterprise', 50, 1, 1, 0, 1, 1, 30, 10, '{\"job_limit\":20,\"featured_jobs\":10,\"live_job_for_days\":90,\"ai_credits\":1000}', '2023-10-05 13:00:39', '2023-10-05 13:03:59'),
(3, 'Basic', 20, 1, 0, 0, 0, 1, 30, 0, '{\"job_limit\":20,\"featured_jobs\":15,\"live_job_for_days\":120,\"ai_credits\":1000}', '2023-10-05 13:02:49', '2023-10-05 13:02:49');

-- --------------------------------------------------------

--
-- Table structure for table `portfolios`
--

CREATE TABLE `portfolios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `preview` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `postcategories`
--

CREATE TABLE `postcategories` (
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `postcategories`
--

INSERT INTO `postcategories` (`post_id`, `category_id`) VALUES
(8, 7),
(8, 13),
(9, 7),
(9, 8),
(9, 12),
(9, 13),
(10, 13),
(10, 14),
(25, 61),
(24, 63),
(23, 62),
(16, 65),
(15, 62),
(3, 64),
(2, 62),
(1, 61);

-- --------------------------------------------------------

--
-- Table structure for table `postmetas`
--

CREATE TABLE `postmetas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `postmetas`
--

INSERT INTO `postmetas` (`id`, `post_id`, `key`, `value`) VALUES
(1, 1, 'excerpt', 'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
(2, 2, 'excerpt', 'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
(3, 3, 'excerpt', 'Yes, If you are unhappy with our service, we offer 30 days money-back guarantee on any plan.'),
(4, 4, 'excerpt', '{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"linkedin\":\"https:\\/\\/linkedin.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\"}'),
(5, 4, 'description', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
(6, 4, 'preview', '/demo/1678125197LZ4zAxvVjarz0PrmZCqK.png'),
(7, 5, 'excerpt', '{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"linkedin\":\"https:\\/\\/linkedin.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\"}'),
(8, 5, 'description', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
(9, 5, 'preview', '/demo/1678125246G7FoUHHxe2C88n1cVXCq.png'),
(10, 6, 'excerpt', '{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"linkedin\":\"https:\\/\\/linkedin.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\"}'),
(11, 6, 'description', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
(12, 6, 'preview', '/demo/16781252849ApdWcy0jUhLRb9QtCL4.png'),
(13, 7, 'excerpt', '{\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"linkedin\":\"https:\\/\\/linkedin.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\"}'),
(14, 7, 'description', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
(15, 7, 'preview', '/demo/1678125323UINo4L0ZND1ErxlWCAFu.png'),
(16, 8, 'preview', '/assets/images/blog/blog_img_09.jpg'),
(17, 8, 'short_description', 'This response is important for our ability to from mistakes but it also gives rise to self-criticism imperdiet nulla malesu elit.'),
(18, 8, 'main_description', '<p>One touch of a red-hot stove is usually all we need to avoid that kind of discomfort in future The same is true as we experienc the emotional of stress from our instances. We are quickly learn to fear and thus automatically. Lorem ipsum dolor sit amet.</p><blockquote><p>“Everything is designed.<br>Few things are designed well.\"</p></blockquote><p>Brian Reed, front-end developer</p><h3>Work Harder &amp; Gain Success</h3><p>One touch of a red-hot stove is usually all we need to avoid that kind of discomfort in quis elit future. The same Duis aute irure dolor in reprehenderit .</p><p><br>&nbsp;</p><p>is true as we experience the emotional sensation of stress from our firs social rejec ridicule. We quickly learn to fear and thus automatically. potentially stressful situation of wlir ext quiert all kinds, including the most common of all.</p>'),
(19, 8, 'seo', '{\"title\":\"Boost your business growth with WhatsApp Quality Based Messaging\",\"description\":\"In a world that\\u2019s increasingly getting commoditized, thanks to technology, it\\u2019s an open secret that customer focus is the real differentiator. This Gospel truth is germane to every business function, but in marketing it\\u2019s indispensable. Reason being the constantly changing needs, wants and desires of customers. New age marketing therefore, is all about unique individual experiences through tools that bring brands closer to their customer.\",\"tags\":\"jobi, job, envato\"}'),
(20, 9, 'preview', '/assets/images/blog/blog_img_10.jpg'),
(21, 9, 'short_description', 'ChatGPT is an artificial intelligence (AI) chatbot that uses natural language processing to create humanlike conversational dialogue. The language model can respond to questions and compose various written content, including articles, social media posts, essays, code and emails.'),
(22, 9, 'main_description', '<p>This response is important for our ability to from mistakes but it also gives rise to self-criticism imperdiet nulla malesu elit.</p><p>One touch of a red-hot stove is usually all we need to avoid that kind of discomfort in future The same is true as we experienc the emotional of stress from our instances. We are quickly learn to fear and thus automatically. Lorem ipsum dolor sit amet.</p><blockquote><p>“Everything is designed.<br>Few things are designed well.\"</p></blockquote><p>Brian Reed, front-end developer</p><h3>Work Harder &amp; Gain Success</h3><p>One touch of a red-hot stove is usually all we need to avoid that kind of discomfort in quis elit future. The same Duis aute irure dolor in reprehenderit .</p><p><br>&nbsp;</p><p>is true as we experience the emotional sensation of stress from our firs social rejec ridicule. We quickly learn to fear and thus automatically. potentially stressful situation of wlir ext quiert all kinds, including the most common of all.</p>'),
(23, 9, 'seo', '{\"title\":\"What Is ChatGPT? Everything You Need to Know\",\"description\":\"In the competitive business landscape, if there\\u2019s one thing that has led to the massive growth of internet businesses, it is digital advertising. The $600 billion industry holds an outsized control on customers\\u2014- who buys what and thus to the fortunes of these businesses. An interesting aspect of digital advertising is its dynamic and ever-evolving nature, from search ads to video and voice search with the latest being Click to Chat ads. Click to Chat ads, although at a nascent stage currently,\",\"tags\":\"jobi, job, envato\"}'),
(24, 10, 'preview', '/assets/images/blog/blog_img_08.jpg'),
(25, 10, 'short_description', 'ChatGPT (Conversational Generative Pre-trained Transformer) is a newly released open-source conversational AI platform. It has been praised for its ability to generate natural language responses to user inputs, and many have hailed it as the next step in creating more human-like conversations. However, despite its promise, certain limitations still prevent it from being a viable replacement for other conversational AI platforms. Let’s explore these limitations and how they can be addressed.'),
(26, 10, 'main_description', 'How is ChatGPT different from Conversational AI?\n                  As an AI language model, ChatGPT can provide conversational capabilities that can be helpful for certain use cases, such as answering general questions or providing basic support. However, it is not designed to replace enterprise conversational AI platforms for several reasons:\n          \n                  Fine-tuning and customization: Enterprise conversational AI platforms can be customized to meet specific business needs and integrate with their existing systems of records, providing a more tailored solution. ChatGPT, on the other hand, is a general-purpose AI language model and may not be able to meet the specific needs of every business.\n                  Security and compliance: Enterprise conversational AI platforms often have security and compliance features built-in, ensuring that sensitive data is protected and regulatory requirements are met. ChatGPT is not specifically designed for enterprise-level security and compliance requirements.\n                  Integrations: Enterprise conversational AI platforms can integrate with other systems and applications, allowing for a more seamless experience for users. ChatGPT does not have the same level of integration capabilities.\n                  Support and maintenance: Enterprise conversational AI platforms often provide support and maintenance services to ensure that the system is running smoothly and to address any issues that arise. ChatGPT does not provide this level of support and maintenance.\n                  Scalability: Enterprise conversational AI platforms can be scaled to handle large volumes of user interactions, while ChatGPT may not be able to handle the same level of scalability.\n                  In summary, while ChatGPT can provide conversational capabilities for certain use cases, it is not designed to replace enterprise conversational AI platforms, which offer greater customization, security, integration, support, maintenance, and scalability capabilities to meet the needs of large businesses.'),
(27, 10, 'seo', '{\"title\":\"Designer\\u2019s Checklist for Every UX\\/UI Project.\",\"description\":\"ChatGPT (Conversational Generative Pre-trained Transformer) is a newly released open-source conversational AI platform. It has been praised for its ability to generate natural language responses to user inputs, and many have hailed it as the next step in creating more human-like conversations. However, despite its promise, certain limitations still prevent it from being a viable replacement for other conversational AI platforms. Let\\u2019s explore these limitations and how they can be addressed.\",\"tags\":\"wa, whatsapp, devstation, qserve, whatsserve\"}'),
(30, 12, 'excerpt', 'Seattle opera simplifies Performance planning with jobi eSignature.'),
(31, 12, 'preview', '/uploads/24/01/1qRPkYPgr1wDBk0jNHwD.jpg'),
(32, 13, 'excerpt', 'How DocuSign CLM helps Celonis scale its global business.'),
(33, 13, 'preview', '/uploads/24/01/FpcYS3UICo5z86GtwmGo.jpg'),
(34, 14, 'excerpt', 'Seattle opera simplifies Performance planning with jobi eSignature.'),
(35, 14, 'preview', '/uploads/24/01/dUa8GbxBAy7utmV9PxCD.jpg'),
(36, 15, 'excerpt', 'Boost digital finance adoption with instant balance inquiries, portfolio recommendations, hassle-free claims settlement, cross-sell and more'),
(37, 16, 'excerpt', 'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
(38, 17, 'excerpt', 'Apply & get your preferable jobs with all the requirements and get it.'),
(39, 17, 'main_description', 'Apply & get your preferable jobs with all the requirements and get it.'),
(40, 17, 'preview', '/assets/images/icon/icon_08.svg'),
(41, 17, 'banner', '/demo/1678143446kru2cExnnwONsqF55Nc6.png'),
(42, 18, 'excerpt', 'Complete your profile with all the info to get attention of client.'),
(43, 18, 'main_description', 'Complete your profile with all the info to get attention of client.'),
(44, 18, 'preview', '/assets/images/icon/icon_09.svg'),
(45, 18, 'banner', '/demo/1678177857DqLCX7BJooFwWYFnY3mH.png'),
(46, 19, 'excerpt', 'It’s very easy to open an account and start your journey.'),
(47, 19, 'main_description', 'It’s very easy to open an account and start your journey.'),
(48, 19, 'preview', '/assets/images/icon/icon_10.svg'),
(49, 19, 'banner', '/demo/1678178152NI8xZNWqa96WzC13Aytg.gif'),
(62, 23, 'excerpt', 'Jobi is the best quaint james bond victoria sponge happy days cras.'),
(63, 24, 'excerpt', 'No you can simply register with your email'),
(64, 25, 'excerpt', 'Jobi has supported free 10 days trial. You don\'t need to add credit card information.'),
(65, 26, 'description', '<p>Thank you for using Jobi! These Terms and Conditions (\"Terms\") govern your use of the Jobi website (jobi.nexilate.xyz), a job board marketplace. By accessing or using Jobi, you agree to comply with and be bound by these Terms. If you do not agree with these Terms, please refrain from using our services.</p><p>### 1. Use of Jobi:</p><p>1.1 <strong>Eligibility</strong><br>&nbsp; - You must be at least 18 years old to use Jobi. By using Jobi, you affirm that you are at least 18 years old and capable of forming a binding contract.</p><p>1.2 <strong>User Account:</strong><br>&nbsp; - To access certain features of Jobi, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account information.</p><p>### 2. Job Listings and Applications:</p><p>2.1 <strong>Accuracy of Information:</strong><br>&nbsp; - Employers are responsible for the accuracy of the job listings they post on Jobi. Jobi does not guarantee the accuracy, completeness, or authenticity of job listings.</p><p>2.2 <strong>Application Process:</strong><br>&nbsp; - Job seekers using Jobi may apply to job listings through the platform. Employers are responsible for managing the application process and communicating with applicants.</p><p>### 3. Prohibited Conduct:</p><p>3.1 <strong>Misuse of Jobi:</strong><br>&nbsp; - You agree not to misuse Jobi, including but not limited to engaging in unauthorized access, data scraping, or any activity that may disrupt the functionality of the platform.</p><p>3.2 <strong>False Information:</strong><br>&nbsp; - Providing false information, whether as a job seeker or employer, is strictly prohibited. Jobi reserves the right to suspend or terminate accounts found to be in violation of this policy.</p><p>### 4. Intellectual Property:</p><p>4.1 <strong>Ownership:</strong><br>&nbsp; - All content on Jobi, including but not limited to text, graphics, logos, and software, is the property of Jobi or its licensors and is protected by intellectual property laws.</p><p>4.2 <strong>License:</strong><br>&nbsp; - By submitting content (such as job listings or resumes) to Jobi, you grant Jobi a non-exclusive, worldwide, royalty-free, sublicensable license to use, reproduce, modify, and distribute the content.</p><p>### 5. Privacy:</p><p>5.1 <strong>Privacy Policy:</strong><br>&nbsp; - The collection and use of personal information on Jobi are governed by our Privacy Policy. By using Jobi, you consent to the terms of the Privacy Policy.</p><p>### 6. Termination:</p><p>6.1 <strong>Termination by Jobi:</strong><br>&nbsp; - Jobi reserves the right to terminate or suspend your access to the platform at any time for violations of these Terms or for any other reason.</p><p>### 7. Changes to Terms:</p><p>7.1 <strong>Updates:</strong><br>&nbsp; - Jobi may update or modify these Terms at any time. Any changes will be effective immediately upon posting the revised Terms on Jobi. It is your responsibility to review these Terms periodically.</p><p>### 8. Contact Us:</p><p>If you have any questions or concerns regarding these Terms and Conditions, please contact us at <strong>contact@jobi.nexilate.xyz</strong>.</p><p>Thank you for using Jobi!</p>'),
(66, 26, 'seo', '{\"title\":\"terms and conditions\",\"description\":\"orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, w\",\"tags\":\"jobi, job, envato\"}'),
(67, 27, 'description', '<p>Thank you for using Jobi! This Privacy Policy outlines the types of information collected from users of the Jobi website (jobi.nexilate.xyz) and how that information is used, stored, and protected. By accessing or using Jobi, you agree to the terms of this Privacy Policy.</p><p><strong>Information We Collect:</strong></p><p><strong>Personal Information:</strong></p><ul><li>When you create an account on Jobi, we may collect personal information such as your name, email address, and other relevant details.</li></ul><p><strong>User-Generated Content:</strong></p><ul><li>Jobi allows users to create profiles and submit content such as resumes, job preferences, and other information relevant to job searching.</li></ul><p><strong>Usage Data:</strong></p><ul><li>We collect information about your interactions with Jobi, including your browsing history, search queries, and other usage patterns.</li></ul><p><strong>Device Information:</strong></p><ul><li>We may collect information about the device you are using to access Jobi, including device type, operating system, and browser type.</li></ul><p><strong>How We Use Your Information:</strong></p><p><strong>To Provide Services:</strong></p><ul><li>We use the information collected to provide you with the services offered on Jobi, including job recommendations, communication with employers, and other features.</li></ul><p><strong>Personalization:</strong></p><ul><li>Jobi may use your information to personalize your experience, such as providing tailored job recommendations based on your preferences.</li></ul><p><strong>Communication:</strong></p><ul><li>We may use your email address to send you important updates, newsletters, and other relevant information related to Jobi.</li></ul><p><strong>Improvement of Services:</strong></p><ul><li>We use aggregated and anonymized data to analyze user behavior and improve the functionality and user experience of Jobi.</li></ul><p><strong>How We Protect Your Information:</strong></p><p><strong>Security Measures:</strong></p><ul><li>We implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction.</li></ul><p><strong>Data Access Control:</strong></p><ul><li>Access to your personal information is restricted to authorized personnel who require the information to perform their job functions.</li></ul><p><strong>Third-Party Services:</strong></p><ol><li><strong>External Links:</strong><ul><li>Jobi may contain links to third-party websites. We are not responsible for the privacy practices or content of these external sites.</li></ul></li></ol><p><strong>Your Choices:</strong></p><p><strong>Account Settings:</strong></p><ul><li>You can review and update your account information and privacy settings in the account settings section of Jobi.</li></ul><p><strong>Communication Preferences:</strong></p><ul><li>You can choose to opt-out of promotional emails by following the instructions provided in the emails.</li></ul><p><strong>Changes to Privacy Policy:</strong></p><p>We reserve the right to update and modify this Privacy Policy. Any changes will be effective immediately upon posting the revised Privacy Policy on Jobi. It is your responsibility to review this Privacy Policy periodically.</p><p><strong>Contact Us:</strong></p><p>If you have any questions or concerns regarding this Privacy Policy, please contact us at <strong>contact@jobi.nexilate.xyz</strong>.</p><p>Thank you for choosing Jobi for your job search needs!</p>'),
(68, 27, 'seo', '{\"title\":\"Privacy Policy\",\"description\":\"Privacy Policy Page\",\"tags\":\"policy, privacy\"}'),
(71, 14, 'banner', '/uploads/24/01/ZVLfxYynFSpXxGeDJe8m.png'),
(72, 13, 'banner', '/uploads/24/01/K4i1rDcKfztcc3PNIxLf.png'),
(73, 12, 'banner', '/uploads/24/01/rri6rsr3hiigpgvcXtBt.png');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'blog',
  `status` int(11) NOT NULL DEFAULT 1,
  `featured` int(11) NOT NULL DEFAULT 1,
  `lang` varchar(191) NOT NULL DEFAULT 'en',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `type`, `status`, `featured`, `lang`, `created_at`, `updated_at`) VALUES
(1, 'Do you recommend Pay as you go or Pre pay?', 'do-you-recommend-pay-as-you-go-or-pre-pay', 'faq', 1, 1, 'en', '2023-03-06 04:47:03', '2024-01-09 10:29:29'),
(2, 'What do I get for $0 with my plan?', 'what-do-i-get-for-0-with-my-plan', 'faq', 1, 1, 'en', '2023-03-06 04:47:50', '2024-01-09 10:29:00'),
(3, 'Do you offer a 30 day money-back guarantee?', 'do-you-offer-a-30-day-money-back-guarantee', 'faq', 1, 1, 'en', '2023-03-06 04:48:16', '2023-03-06 04:48:16'),
(4, 'Darlene Robertson', 'Product Manager', 'team', 1, 1, 'en', '2023-03-06 12:23:17', '2023-03-06 12:23:17'),
(5, 'Bessie Cooper', 'Vp People', 'team', 1, 1, 'en', '2023-03-06 12:24:06', '2023-03-06 12:24:06'),
(6, 'Eleanor Pena', 'Head of Design', 'team', 1, 1, 'en', '2023-03-06 12:24:44', '2023-03-06 12:24:44'),
(7, 'Rhonda Ortiz', 'Founder & CO', 'team', 1, 1, 'en', '2023-03-06 12:25:23', '2023-03-06 12:25:23'),
(8, 'Medieval origins to the digital era, everything there is to know', 'medieval-origins-to-the-digital-era-everything-there-is-to-know', 'blog', 1, 1, 'en', '2023-03-06 13:20:45', '2024-01-09 10:18:06'),
(9, 'What Is ChatGPT? Everything You Need to Know', 'what-is-chatgpt-everything-you-need-to-know', 'blog', 1, 1, 'en', '2023-03-06 13:27:44', '2024-01-09 10:19:56'),
(10, 'Designer’s Checklist for Every UX/UI Project', 'designers-checklist-for-every-uxui-project', 'blog', 1, 1, 'en', '2023-03-06 13:30:52', '2024-01-09 10:16:49'),
(12, 'Jhone Doe', 'Lead Designer', 'testimonial', 1, 1, '5', '2023-03-06 13:53:24', '2023-10-07 03:40:05'),
(13, 'Mark Joge', 'Marketing Chief', 'testimonial', 1, 1, '4', '2023-03-06 13:54:12', '2023-10-07 03:40:12'),
(14, 'Jhone Doe', 'Lead Designer', 'testimonial', 1, 1, '5', '2023-03-06 13:54:59', '2023-10-07 03:37:16'),
(15, 'Financial Services', 'financial-services', 'faq', 1, 1, 'en', '2023-03-06 14:00:09', '2023-03-06 14:00:09'),
(16, 'How do you find different criteria in your process?', 'how-do-you-find-different-criteria-in-your-process', 'faq', 1, 1, 'en', '2023-03-06 14:01:09', '2024-01-09 10:28:05'),
(17, 'Apply job or hire', 'apply-job-or-hire', 'feature', 1, 1, 'en', '2023-03-06 16:54:43', '2023-10-07 03:55:49'),
(18, 'Complete your profile', 'complete-your-profile', 'feature', 1, 1, 'en', '2023-03-06 17:45:36', '2023-10-07 03:54:57'),
(19, 'Create Account', 'create-account', 'feature', 1, 1, 'en', '2023-03-06 18:02:24', '2023-10-07 03:54:08'),
(23, 'Automatically sync in real time', 'automatically-sync-in-real-time', 'faq', 1, 1, 'en', '2023-04-09 14:09:14', '2024-01-09 10:27:30'),
(24, 'Do I need a credit card to sign up?', 'do-i-need-a-credit-card-to-sign-up', 'faq', 1, 1, 'en', '2023-04-09 14:09:50', '2024-01-09 10:27:15'),
(25, 'How does the free trial work?', 'how-does-the-free-trial-work', 'faq', 1, 1, 'en', '2023-04-09 14:10:59', '2024-01-09 10:26:58'),
(26, 'Terms and conditions', 'terms-and-conditions', 'page', 1, 1, 'en', '2023-04-09 14:10:59', '2023-04-09 14:10:59'),
(27, 'Privacy Policy', 'privacy-policy', 'page', 1, 1, 'en', '2023-10-08 00:25:19', '2023-10-08 00:25:19');

-- --------------------------------------------------------

--
-- Table structure for table `profile_visitors`
--

CREATE TABLE `profile_visitors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `visitor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qualifications`
--

CREATE TABLE `qualifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `gpa` tinyint(4) NOT NULL COMMENT 'out of 4 or 5',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `qualifications`
--

INSERT INTO `qualifications` (`id`, `title`, `gpa`, `created_at`, `updated_at`) VALUES
(1, 'Business', 4, '2025-03-01 02:15:40', '2025-03-01 02:15:40');

-- --------------------------------------------------------

--
-- Table structure for table `replies`
--

CREATE TABLE `replies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `body` longtext DEFAULT NULL,
  `read_at` datetime DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `meta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', '2025-03-01 00:00:18', '2025-03-01 00:00:18');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1);

-- --------------------------------------------------------

--
-- Table structure for table `supportlogs`
--

CREATE TABLE `supportlogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_admin` int(11) NOT NULL DEFAULT 0,
  `seen` int(11) NOT NULL DEFAULT 0,
  `comment` text NOT NULL,
  `support_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supports`
--

CREATE TABLE `supports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_no` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usercategories`
--

CREATE TABLE `usercategories` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usercategories`
--

INSERT INTO `usercategories` (`user_id`, `category_id`) VALUES
(2, 42),
(8, 24);

-- --------------------------------------------------------

--
-- Table structure for table `userjobs`
--

CREATE TABLE `userjobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `opening_id` bigint(20) UNSIGNED NOT NULL,
  `seen_at` datetime DEFAULT NULL,
  `is_hired` tinyint(1) NOT NULL DEFAULT 0,
  `meta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userlocations`
--

CREATE TABLE `userlocations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `country_id` bigint(20) UNSIGNED NOT NULL,
  `state_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `userlocations`
--

INSERT INTO `userlocations` (`id`, `user_id`, `country_id`, `state_id`) VALUES
(2, 2, 6, 7),
(3, 8, 6, 7);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `username` varchar(191) DEFAULT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `role` varchar(191) NOT NULL DEFAULT 'user',
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `credits` double NOT NULL DEFAULT 0,
  `category_id` int(11) DEFAULT NULL,
  `meta` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `employment` text DEFAULT NULL,
  `provider` varchar(191) DEFAULT NULL,
  `provider_id` varchar(191) DEFAULT NULL,
  `plan` text DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `kyc_verified_at` timestamp NULL DEFAULT NULL,
  `is_star` tinyint(1) NOT NULL DEFAULT 0,
  `will_expire` date DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `avatar`, `role`, `email`, `phone`, `address`, `credits`, `category_id`, `meta`, `status`, `employment`, `provider`, `provider_id`, `plan`, `plan_id`, `email_verified_at`, `kyc_verified_at`, `is_star`, `will_expire`, `password`, `deleted_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin', NULL, 'admin', 'admin@admin.com', NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$gDO1UzAcwyimRF9McNFq5e9lDCLefbpgINljeL0KcVPSOeHLmdgk6', NULL, NULL, '2025-03-01 00:00:18', '2025-03-01 00:00:18'),
(2, 'siva', 'siva', NULL, 'user', 'siva.frontdev@gmail.com', '95783509834', 'l;sdfj;lsdfasfd', 0, 31, '{\"overview\":\"jksdfas\",\"gender\":\"male\",\"date_of_birth\":\"2025-02-23\",\"step_completed\":\"5\",\"country_id\":6,\"state_id\":7,\"address\":\"l;sdfj;lsdfasfd\",\"expert_level\":2,\"expected_salary\":20000,\"currency\":\"USD\",\"work_experiences\":[],\"service_id\":31,\"category_id\":24,\"skills\":[42],\"resume\":\"http:\\/\\/127.0.0.1:8000\\/uploads\\/25\\/03\\/ujdLzdBEXzcoVu3T9rkI.pdf\",\"education_qualifications\":[],\"avatar\":null}', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$bVL8CmHkkgs7GzaMWjJpIeSKK02/Gf697Dqym2AcOvb5sLoM7FO2G', NULL, NULL, '2025-03-01 00:30:37', '2025-03-01 02:05:37'),
(3, 'benchmarkadmin', 'benchmarkadmin', NULL, 'user', 'siva.frontdev2@gmail.com', NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$kUkhBs1D.oEIGgNwwBiiAOcY4emNXSJmi/KTCntSvxq7QFXQVs0qm', NULL, NULL, '2025-03-01 00:42:34', '2025-03-01 00:42:34'),
(4, 'benchmarkadmin', 'benchmarkadmin1dd', NULL, 'user', 'siva.frontdev4@gmail.com', NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$sd9JTvv7cHbK2pbFaggTXuowgNjVhJR0Wj/oILjJoBrK9r0Hd6zmW', NULL, NULL, '2025-03-01 00:55:30', '2025-03-01 00:55:30'),
(5, 'Test User', 'testuser', NULL, 'user', 'test@example.com', NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$.7KECa7jt12G57dBvbypwOAhuBArs4s4QExuS1ZiX/8nk6OgaHTxG', NULL, NULL, '2025-03-01 00:58:00', '2025-03-01 00:58:00'),
(6, 'Test Employer', 'testemployer', NULL, 'employer', 'employer@example.com', NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$KW7tZnRLoMj.H6y./FjezO7DxlWqElrd.l.dgSb9j3NvxmUmsy7fG', NULL, NULL, '2025-03-01 00:58:59', '2025-03-01 00:58:59'),
(7, 'benchmarkadmin', 'benchmarkadmin2tb', NULL, 'user', 'siva.frontdev8@gmail.com', NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$1OAzmCr6ApLJKrf5Uksb2ePCHu9gzBncIgkSl6Kox9iPYLU3hpfnm', NULL, NULL, '2025-03-01 01:02:56', '2025-03-01 01:02:56'),
(8, 'employer', 'employer', NULL, 'employer', 'siva.employer@gamil.com', NULL, NULL, 0, 31, '{\"company\":{\"name\":\"employer\",\"size\":\"1-15\",\"year_of_establishment\":\"2025-02-26\",\"address\":\"dsdfasdASD\",\"intro\":null,\"teams\":[\"http:\\/\\/127.0.0.1:8000\\/uploads\\/25\\/03\\/1740814766LtmWrSrvzoTr8MZOpY27.jpg\",\"http:\\/\\/127.0.0.1:8000\\/uploads\\/25\\/03\\/1740814766fdhHO8PrEbUMhwsbb56E.jpg\",\"http:\\/\\/127.0.0.1:8000\\/uploads\\/25\\/03\\/1740814766c2F0wgZflvinnMKU87kW.jpg\"]},\"contact\":{\"name\":\"Siva Jothi B\",\"designation\":\"Siva Jothi B\",\"email\":\"siva.frontdev@gmail.com\",\"mobile\":\"09344853263\"},\"business\":{\"description\":\"dsafdasd\",\"license_no\":\"SDFEERW2342S\",\"rl_no\":\"12\",\"site_url\":null},\"social\":{\"linkedin\":null,\"twitter\":null,\"facebook\":null,\"instagram\":null}}', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '$2y$10$LzJ7wrQgGxxvzVKx/QrZ0uyW3IwBiy8sgN0rmtP5ceSudA2dqZCwm', NULL, NULL, '2025-03-01 02:07:41', '2025-03-01 02:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `user_education_qualifications`
--

CREATE TABLE `user_education_qualifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `qualification_id` bigint(20) UNSIGNED NOT NULL,
  `meta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `opening_id` bigint(20) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `websockets_statistics_entries`
--

CREATE TABLE `websockets_statistics_entries` (
  `id` int(10) UNSIGNED NOT NULL,
  `app_id` varchar(191) NOT NULL,
  `peak_connection_count` int(11) NOT NULL,
  `websocket_message_count` int(11) NOT NULL,
  `api_message_count` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_generates`
--
ALTER TABLE `ai_generates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_generates_user_id_foreign` (`user_id`),
  ADD KEY `ai_generates_ai_template_id_foreign` (`ai_template_id`);

--
-- Indexes for table `ai_templates`
--
ALTER TABLE `ai_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ai_template_user`
--
ALTER TABLE `ai_template_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_template_user_user_id_foreign` (`user_id`),
  ADD KEY `ai_template_user_ai_template_id_foreign` (`ai_template_id`);

--
-- Indexes for table `candidatebookmarks`
--
ALTER TABLE `candidatebookmarks`
  ADD KEY `candidatebookmarks_user_id_foreign` (`user_id`),
  ADD KEY `candidatebookmarks_candidate_id_foreign` (`candidate_id`),
  ADD KEY `candidatebookmarks_opening_id_foreign` (`opening_id`);

--
-- Indexes for table `candidate_reviews`
--
ALTER TABLE `candidate_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `candidate_reviews_user_id_foreign` (`user_id`),
  ADD KEY `candidate_reviews_company_id_foreign` (`company_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `categorymetas`
--
ALTER TABLE `categorymetas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorymetas_category_id_foreign` (`category_id`);

--
-- Indexes for table `category_opening`
--
ALTER TABLE `category_opening`
  ADD KEY `category_opening_opening_id_foreign` (`opening_id`),
  ADD KEY `category_opening_category_id_foreign` (`category_id`);

--
-- Indexes for table `category_templates`
--
ALTER TABLE `category_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_templates_category_id_foreign` (`category_id`),
  ADD KEY `category_templates_template_id_foreign` (`template_id`);

--
-- Indexes for table `company_reviews`
--
ALTER TABLE `company_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_reviews_user_id_foreign` (`user_id`),
  ADD KEY `company_reviews_company_id_foreign` (`company_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversation_user`
--
ALTER TABLE `conversation_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_user_conversation_id_foreign` (`conversation_id`),
  ADD KEY `conversation_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `credit_logs`
--
ALTER TABLE `credit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `credit_logs_user_id_foreign` (`user_id`),
  ADD KEY `credit_logs_gateway_id_foreign` (`gateway_id`);

--
-- Indexes for table `description_templates`
--
ALTER TABLE `description_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expert_levels`
--
ALTER TABLE `expert_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobbookmarks`
--
ALTER TABLE `jobbookmarks`
  ADD KEY `jobbookmarks_user_id_foreign` (`user_id`),
  ADD KEY `jobbookmarks_opening_id_foreign` (`opening_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `kyc_methods`
--
ALTER TABLE `kyc_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kyc_method_user`
--
ALTER TABLE `kyc_method_user`
  ADD KEY `kyc_method_user_kyc_method_id_foreign` (`kyc_method_id`),
  ADD KEY `kyc_method_user_user_id_foreign` (`user_id`),
  ADD KEY `kyc_method_user_kyc_request_id_foreign` (`kyc_request_id`);

--
-- Indexes for table `kyc_requests`
--
ALTER TABLE `kyc_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kyc_requests_user_id_foreign` (`user_id`),
  ADD KEY `kyc_requests_kyc_method_id_foreign` (`kyc_method_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `locations_location_id_foreign` (`location_id`);

--
-- Indexes for table `location_opening`
--
ALTER TABLE `location_opening`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_opening_opening_id_foreign` (`opening_id`),
  ADD KEY `location_opening_country_id_foreign` (`country_id`),
  ADD KEY `location_opening_state_id_foreign` (`state_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `openings`
--
ALTER TABLE `openings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `openings_user_id_foreign` (`user_id`),
  ADD KEY `openings_category_id_foreign` (`category_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_plan_id_foreign` (`plan_id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_gateway_id_foreign` (`gateway_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD KEY `password_reset_tokens_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portfolios`
--
ALTER TABLE `portfolios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portfolios_user_id_foreign` (`user_id`);

--
-- Indexes for table `postcategories`
--
ALTER TABLE `postcategories`
  ADD KEY `postcategories_post_id_foreign` (`post_id`),
  ADD KEY `postcategories_category_id_foreign` (`category_id`);

--
-- Indexes for table `postmetas`
--
ALTER TABLE `postmetas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `postmetas_post_id_foreign` (`post_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profile_visitors`
--
ALTER TABLE `profile_visitors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_visitors_user_id_foreign` (`user_id`);

--
-- Indexes for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `replies_conversation_id_foreign` (`conversation_id`),
  ADD KEY `replies_user_id_foreign` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `supportlogs`
--
ALTER TABLE `supportlogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supportlogs_support_id_foreign` (`support_id`),
  ADD KEY `supportlogs_user_id_foreign` (`user_id`);

--
-- Indexes for table `supports`
--
ALTER TABLE `supports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supports_user_id_foreign` (`user_id`);

--
-- Indexes for table `usercategories`
--
ALTER TABLE `usercategories`
  ADD KEY `usercategories_user_id_foreign` (`user_id`),
  ADD KEY `usercategories_category_id_foreign` (`category_id`);

--
-- Indexes for table `userjobs`
--
ALTER TABLE `userjobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userjobs_user_id_foreign` (`user_id`),
  ADD KEY `userjobs_opening_id_foreign` (`opening_id`);

--
-- Indexes for table `userlocations`
--
ALTER TABLE `userlocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userlocations_user_id_foreign` (`user_id`),
  ADD KEY `userlocations_country_id_foreign` (`country_id`),
  ADD KEY `userlocations_state_id_foreign` (`state_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_education_qualifications`
--
ALTER TABLE `user_education_qualifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_education_qualifications_user_id_foreign` (`user_id`),
  ADD KEY `user_education_qualifications_qualification_id_foreign` (`qualification_id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `visitors_user_id_foreign` (`user_id`),
  ADD KEY `visitors_opening_id_foreign` (`opening_id`);

--
-- Indexes for table `websockets_statistics_entries`
--
ALTER TABLE `websockets_statistics_entries`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_generates`
--
ALTER TABLE `ai_generates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ai_templates`
--
ALTER TABLE `ai_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ai_template_user`
--
ALTER TABLE `ai_template_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `candidate_reviews`
--
ALTER TABLE `candidate_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `categorymetas`
--
ALTER TABLE `categorymetas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_templates`
--
ALTER TABLE `category_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `company_reviews`
--
ALTER TABLE `company_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversation_user`
--
ALTER TABLE `conversation_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credit_logs`
--
ALTER TABLE `credit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `description_templates`
--
ALTER TABLE `description_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `expert_levels`
--
ALTER TABLE `expert_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kyc_methods`
--
ALTER TABLE `kyc_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kyc_requests`
--
ALTER TABLE `kyc_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `location_opening`
--
ALTER TABLE `location_opening`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `openings`
--
ALTER TABLE `openings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `portfolios`
--
ALTER TABLE `portfolios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `postmetas`
--
ALTER TABLE `postmetas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `profile_visitors`
--
ALTER TABLE `profile_visitors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qualifications`
--
ALTER TABLE `qualifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `replies`
--
ALTER TABLE `replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supportlogs`
--
ALTER TABLE `supportlogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supports`
--
ALTER TABLE `supports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userjobs`
--
ALTER TABLE `userjobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userlocations`
--
ALTER TABLE `userlocations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_education_qualifications`
--
ALTER TABLE `user_education_qualifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `websockets_statistics_entries`
--
ALTER TABLE `websockets_statistics_entries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_generates`
--
ALTER TABLE `ai_generates`
  ADD CONSTRAINT `ai_generates_ai_template_id_foreign` FOREIGN KEY (`ai_template_id`) REFERENCES `ai_templates` (`id`),
  ADD CONSTRAINT `ai_generates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `ai_template_user`
--
ALTER TABLE `ai_template_user`
  ADD CONSTRAINT `ai_template_user_ai_template_id_foreign` FOREIGN KEY (`ai_template_id`) REFERENCES `ai_templates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ai_template_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `candidatebookmarks`
--
ALTER TABLE `candidatebookmarks`
  ADD CONSTRAINT `candidatebookmarks_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidatebookmarks_opening_id_foreign` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidatebookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `candidate_reviews`
--
ALTER TABLE `candidate_reviews`
  ADD CONSTRAINT `candidate_reviews_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidate_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categorymetas`
--
ALTER TABLE `categorymetas`
  ADD CONSTRAINT `categorymetas_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_opening`
--
ALTER TABLE `category_opening`
  ADD CONSTRAINT `category_opening_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_opening_opening_id_foreign` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_templates`
--
ALTER TABLE `category_templates`
  ADD CONSTRAINT `category_templates_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_templates_template_id_foreign` FOREIGN KEY (`template_id`) REFERENCES `description_templates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `company_reviews`
--
ALTER TABLE `company_reviews`
  ADD CONSTRAINT `company_reviews_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `company_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `conversation_user`
--
ALTER TABLE `conversation_user`
  ADD CONSTRAINT `conversation_user_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversation_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `credit_logs`
--
ALTER TABLE `credit_logs`
  ADD CONSTRAINT `credit_logs_gateway_id_foreign` FOREIGN KEY (`gateway_id`) REFERENCES `gateways` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `credit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jobbookmarks`
--
ALTER TABLE `jobbookmarks`
  ADD CONSTRAINT `jobbookmarks_opening_id_foreign` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jobbookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kyc_method_user`
--
ALTER TABLE `kyc_method_user`
  ADD CONSTRAINT `kyc_method_user_kyc_method_id_foreign` FOREIGN KEY (`kyc_method_id`) REFERENCES `kyc_methods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kyc_method_user_kyc_request_id_foreign` FOREIGN KEY (`kyc_request_id`) REFERENCES `kyc_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kyc_method_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kyc_requests`
--
ALTER TABLE `kyc_requests`
  ADD CONSTRAINT `kyc_requests_kyc_method_id_foreign` FOREIGN KEY (`kyc_method_id`) REFERENCES `kyc_methods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kyc_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `location_opening`
--
ALTER TABLE `location_opening`
  ADD CONSTRAINT `location_opening_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `location_opening_opening_id_foreign` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `location_opening_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `openings`
--
ALTER TABLE `openings`
  ADD CONSTRAINT `openings_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `openings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_gateway_id_foreign` FOREIGN KEY (`gateway_id`) REFERENCES `gateways` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `portfolios`
--
ALTER TABLE `portfolios`
  ADD CONSTRAINT `portfolios_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `postcategories`
--
ALTER TABLE `postcategories`
  ADD CONSTRAINT `postcategories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `postcategories_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `postmetas`
--
ALTER TABLE `postmetas`
  ADD CONSTRAINT `postmetas_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profile_visitors`
--
ALTER TABLE `profile_visitors`
  ADD CONSTRAINT `profile_visitors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `replies`
--
ALTER TABLE `replies`
  ADD CONSTRAINT `replies_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supportlogs`
--
ALTER TABLE `supportlogs`
  ADD CONSTRAINT `supportlogs_support_id_foreign` FOREIGN KEY (`support_id`) REFERENCES `supports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supportlogs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supports`
--
ALTER TABLE `supports`
  ADD CONSTRAINT `supports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `usercategories`
--
ALTER TABLE `usercategories`
  ADD CONSTRAINT `usercategories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usercategories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userjobs`
--
ALTER TABLE `userjobs`
  ADD CONSTRAINT `userjobs_opening_id_foreign` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userjobs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userlocations`
--
ALTER TABLE `userlocations`
  ADD CONSTRAINT `userlocations_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userlocations_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userlocations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_education_qualifications`
--
ALTER TABLE `user_education_qualifications`
  ADD CONSTRAINT `user_education_qualifications_qualification_id_foreign` FOREIGN KEY (`qualification_id`) REFERENCES `qualifications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_education_qualifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `visitors`
--
ALTER TABLE `visitors`
  ADD CONSTRAINT `visitors_opening_id_foreign` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `visitors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
