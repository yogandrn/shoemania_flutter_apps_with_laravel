-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 19, 2022 at 03:55 PM
-- Server version: 10.3.37-MariaDB-log-cll-lve
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sipalin3_shoemania`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `postal_code` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Sneakers', '2022-08-23 16:18:33', '2022-08-23 16:18:33', NULL),
(2, 'Boots', '2022-08-23 16:18:33', '2022-08-23 16:18:33', NULL),
(3, 'Sports', '2022-08-23 16:18:33', '2022-08-23 16:18:33', NULL),
(4, 'Formal', '2022-08-23 16:18:33', '2022-08-23 16:18:33', NULL),
(5, 'Slip On', '2022-08-23 16:18:33', '2022-08-23 16:18:33', NULL),
(6, 'Heels', '2022-08-23 16:18:33', '2022-08-23 16:18:33', NULL),
(7, 'Loafers', '2022-08-26 15:49:53', '2022-08-26 15:49:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `galleries`
--

INSERT INTO `galleries` (`id`, `product_id`, `image_url`, `created_at`, `updated_at`) VALUES
(2, 1, 'assets/products/2022//3X6pOEglHBLlppWdXNfDYT3C4v27Z1aMvEIrPwiO.png', '2022-08-27 05:45:36', '2022-08-27 05:45:36'),
(3, 2, 'assets/products/2022//jwXeIH9Ezevm2UrybZfWadbAwDgEAfHlzfq41s5r.png', '2022-08-27 05:46:29', '2022-08-27 05:46:29'),
(4, 1, 'assets/products/2022//gRZNyVKJffcDARq7BgNdKiWUqCC7OE6MqzKHuGQx.png', '2022-08-27 05:46:55', '2022-08-27 05:46:55'),
(5, 12, 'assets/products/2022//1glzs2T7ewpB7TXiT5HpFW0y7ZHDjgJimZwIFG0F.jpg', '2022-09-03 02:54:39', '2022-09-03 02:54:39'),
(6, 12, 'assets/products/2022//5YwbbRdKQubrGikSk7vfvUrqvD4zCV9hkqiiI1oS.jpg', '2022-09-03 02:54:55', '2022-09-03 02:54:55'),
(7, 12, 'assets/products/2022//Xm1RKcKk7xO29Qil3xbZH7n1GruMzYGxCCSZK9yB.jpg', '2022-09-03 02:55:06', '2022-09-03 02:55:06'),
(8, 12, 'assets/products/2022//XnvaRTthZdSr1BcjxO16wQSRX5lFHGwbglMI9t4q.jpg', '2022-09-03 02:55:18', '2022-09-03 02:55:18'),
(9, 7, 'assets/products/2022//F7MFj8jvGWKvKTtjCn5TIkKAE5MufGUuhBcx0Lez.jpg', '2022-09-03 02:55:48', '2022-09-03 02:55:48'),
(10, 7, 'assets/products/2022//CUFSRb6tJj5JzbUcMWlw6shH6FTBaD6AYIYkZVKO.jpg', '2022-09-03 02:56:45', '2022-09-03 02:56:45'),
(11, 7, 'assets/products/2022//QgfDfOGoVarXnXM5hYF33S0dt4gUez9M6CXx7qob.jpg', '2022-09-03 02:57:06', '2022-09-03 02:57:06'),
(12, 7, 'assets/products/2022//u5EqdYrOuOY47qdQh8XWxHJwRxrIuVt1gW8Bzyni.jpg', '2022-09-03 02:57:21', '2022-09-03 02:57:21'),
(13, 11, 'assets/products/2022//qj0L8gJGVVCU7VrHj8VkNhkwVcA1aALznFs2UL1q.jpg', '2022-09-03 02:58:13', '2022-09-03 02:58:13'),
(14, 11, 'assets/products/2022//ZfO7sjv113ModOapli31ZHWN8DULaKb1W0HtvpJD.jpg', '2022-09-03 02:58:27', '2022-09-03 02:58:27'),
(15, 11, 'assets/products/2022//17xF5uxGGJyyFN7ICxZSCcIL4kcxVLkqPULhFj3i.jpg', '2022-09-03 02:58:40', '2022-09-03 02:58:40'),
(16, 11, 'assets/products/2022//7JY8sUNRbfLEdSkDVSOTSJ3RNClj72ikp5FrmmPL.jpg', '2022-09-03 02:58:56', '2022-09-03 02:58:56'),
(17, 3, 'assets/products/2022//HJmKJ5T00lKQx6I33DiaHKfPI8qCq7wHN0ZqDFxS.jpg', '2022-09-03 03:00:02', '2022-09-03 03:00:02'),
(18, 3, 'assets/products/2022//rUw4KHVo91eucxqcOfqxdArvpxrKdYS37GskFz8r.jpg', '2022-09-03 03:00:30', '2022-09-03 03:00:30'),
(19, 3, 'assets/products/2022//c0IeCOfey6CIrOP8eIdtpR4dPwYzWLbOa17GOO7z.jpg', '2022-09-03 03:00:47', '2022-09-03 03:00:47'),
(20, 3, 'assets/products/2022//uRsYuhNocw5EqrkV68y0r3jsTfvdKD4VPFpWPjlk.jpg', '2022-09-03 03:01:04', '2022-09-03 03:01:04'),
(21, 9, 'assets/products/2022//xrS9yEdKcmiU0Dvk4VQgp8M0g3lr7u24h1VOP3gE.jpg', '2022-09-03 03:01:32', '2022-09-03 03:10:46'),
(22, 9, 'assets/products/2022//1o0mc6B5FfDXxH7pULfhsD8wfcivmRv7XON9q2se.jpg', '2022-09-03 03:01:47', '2022-09-03 03:10:50'),
(23, 9, 'assets/products/2022//v41EsgBbvL5Pla0JbCb2qkx0FrRo6hfEDwoydWli.jpg', '2022-09-03 03:02:05', '2022-09-03 03:10:53'),
(24, 9, 'assets/products/2022//295kALyN9gBqIffS7DDusFUHgJ2TfjlD62s2ndt8.jpg', '2022-09-03 03:02:31', '2022-09-03 03:10:57'),
(25, 5, 'assets/products/2022//AQD7eCjB4GXCKYKYPHT0676VDCzlukrzhoFcUbqF.jpg', '2022-09-03 03:03:13', '2022-09-03 03:03:13'),
(26, 5, 'assets/products/2022//yfhorXl7moIOLMgtwQn94fUO2PHxIsqLpRs3C5C8.jpg', '2022-09-03 03:03:27', '2022-09-03 03:03:27'),
(27, 5, 'assets/products/2022//JXvOVOSugFFXSh6ooROpBWDatFlOQAqEyiN9MRQN.jpg', '2022-09-03 03:03:37', '2022-09-03 03:03:37'),
(28, 6, 'assets/products/2022//5IDRbSRaMWMFzObczhB9Y9J4JMtlqUpKg3dSifmp.jpg', '2022-09-03 03:04:54', '2022-09-03 03:04:54'),
(29, 6, 'assets/products/2022//VQNpLf2cmzgWgraXNMbEQICB1iuHQtqFsmkNfDzb.jpg', '2022-09-03 03:05:09', '2022-09-03 03:05:09'),
(30, 6, 'assets/products/2022//30cdDDPhBBbNncVwmjRhKSeqXJsTt46tFfxiRWro.jpg', '2022-09-03 03:05:53', '2022-09-03 03:05:53'),
(31, 6, 'assets/products/2022//f4YcrZ2USuPihAwuFkqhlJPR7YnZpUpZpmclVwtZ.jpg', '2022-09-03 03:06:10', '2022-09-03 03:06:10'),
(32, 6, 'assets/products/2022//7tuERXyLRq53N5BbYkeksBe8NcfJA1HJDVNsHKR6.jpg', '2022-09-03 03:06:19', '2022-09-03 03:06:19'),
(33, 8, 'assets/products/2022//DyUTQssBKWEkzmkBFR6QV3Uvpn94fgSd7Ef7FTcj.jpg', '2022-09-03 03:12:28', '2022-09-03 03:12:28'),
(34, 8, 'assets/products/2022//LLQEJtnDCRKXnngc4FMvRICGVgewhYLCq21APF1P.jpg', '2022-09-03 03:13:00', '2022-09-03 03:13:00'),
(35, 8, 'assets/products/2022//riP7dupmwg2VFDixgpODprE276m9ChPD3rvu3QRB.jpg', '2022-09-03 03:13:13', '2022-09-03 03:13:13'),
(36, 4, 'assets/products/2022//ptzHxU5xmx05rbBpEspFr0EaqL77NDpnJF7ZkfrH.jpg', '2022-09-03 03:13:54', '2022-09-03 03:13:54'),
(37, 4, 'assets/products/2022//eiD2UWFcM0aWahqsDoBk1NwUmXulhrfdCY1JbQDp.jpg', '2022-09-03 03:14:16', '2022-09-03 03:14:16'),
(38, 4, 'assets/products/2022//A7Iglm5rvTxCFeYgoSUtHMUXlaCGLxzDKIrU0JBz.jpg', '2022-09-03 03:14:39', '2022-09-03 03:14:39'),
(39, 4, 'assets/products/2022//yu1kjkFf128UDvW3xwPLpWoCRMOmGimj2AKYVpQ8.jpg', '2022-09-03 03:14:57', '2022-09-03 03:14:57'),
(40, 10, 'assets/products/2022//aGZTp8llzbTW28afEvvk7Gi2IbvOOcg0hb7n350F.jpg', '2022-09-03 03:15:52', '2022-09-03 03:15:52'),
(41, 10, 'assets/products/2022//iebssyjldeZVL71CdWCP9ZrZokmc90qp3HGj8RNs.jpg', '2022-09-03 03:16:07', '2022-09-03 03:16:07'),
(42, 10, 'assets/products/2022//mSsCEOCsFRh3c3PY1Tb8doWo4EvIP2mKxEj1r1X9.jpg', '2022-09-03 03:16:24', '2022-09-03 03:17:48'),
(43, 13, 'assets/products/2022//RBfL1td10VtKmBO5vljfyEBmZNKm2n9Udp8ycz2m.jpg', '2022-09-03 03:23:07', '2022-09-03 03:23:07'),
(44, 13, 'assets/products/2022//yaCyr4tWgVYavcFlytixad8mmsQCftgqTHlkC8CC.jpg', '2022-09-03 03:23:22', '2022-09-03 03:23:22'),
(45, 13, 'assets/products/2022//9DFa7t3JtpqFDxrB6nNT7ke0R2aLYceaT6UBw07S.jpg', '2022-09-03 03:23:38', '2022-09-03 03:23:38'),
(46, 13, 'assets/products/2022//xlxZfM7y47bsTzeGHqmgvRnoqxpRdPgHporzJitq.jpg', '2022-09-03 03:25:13', '2022-09-03 03:25:13');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2022_08_22_084037_create_sessions_table', 1),
(7, '2022_08_22_125133_create_categories_table', 1),
(8, '2022_08_22_125325_create_products_table', 1),
(9, '2022_08_22_125811_create_galleries_table', 1),
(10, '2022_08_22_130009_create_transactions_table', 1),
(11, '2022_08_22_130357_create_transaction_items_table', 1),
(12, '2022_08_22_151415_create_carts_table', 1),
(13, '2022_08_22_230501_create_addresses_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `tags` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `sold` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `tags`, `price`, `stock`, `weight`, `sold`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Ventela Retro ZX02', 'Lorem ipsum', 'Sneakers', 209000, 3, 900, 3, '2022-08-25 02:08:27', '2022-09-15 03:25:17', '2022-09-15 03:25:17'),
(2, 1, 'Converse All Star', 'Lorem ipsum dolor sit ammet', 'Casual', 500000, 2, 800, 0, '2022-08-27 02:52:59', '2022-09-15 03:25:24', '2022-09-15 03:25:24'),
(3, 1, 'Aerostreet Hoops - Putih Hitam', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Sporty, Casual', 149000, 2, 800, 6, '2022-09-03 01:16:37', '2022-10-15 15:04:41', NULL),
(4, 1, 'Aerostreet Massive Low - Hitam', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Casual', 129000, 5, 800, 1, '2022-09-03 01:17:46', '2022-12-19 08:39:55', NULL),
(5, 5, 'TIMEBOMB Vulcanized CheckerBoard', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Fashion', 135000, 3, 700, 0, '2022-09-03 01:21:04', '2022-09-03 01:21:04', NULL),
(6, 1, 'Mavelin Classic Andro Low - Black', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Retro, Casual', 139000, 7, 700, 0, '2022-09-03 02:45:14', '2022-09-03 02:45:14', NULL),
(7, 3, 'Aerostreet Rin - Abu Toska', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Sporty, Casual', 125000, 10, 900, 0, '2022-09-03 02:46:11', '2022-09-03 02:46:11', NULL),
(8, 5, 'ThunderBear Voltaire BW', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Casual', 122500, 5, 700, 2, '2022-09-03 02:47:05', '2022-10-15 15:04:41', NULL),
(9, 1, 'Aerostreet Hoops Low - Hitam Putih', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores quia met libero, quia fugit, nihil dolorem natus sit possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse dolor voluptatem quis eos ut!', 'Sporty, Casual, Formal', 139000, 12, 900, 0, '2022-09-03 02:48:54', '2022-09-03 02:48:54', NULL),
(10, 1, 'Aerostreet Massive Low - Navy', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Retro, Casual', 128000, 5, 800, 9, '2022-09-03 02:49:37', '2022-10-11 04:10:17', NULL),
(11, 1, 'Aerostreet Classic - Putih Hijau Tua', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Sporty, Casual', 132000, 3, 800, 3, '2022-09-03 02:50:30', '2022-10-12 15:49:39', NULL),
(12, 4, 'Prodigo Bima Black', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Formal', 120000, 11, 800, 0, '2022-09-03 02:52:42', '2022-10-11 04:06:52', NULL),
(13, 1, 'Aerostreet Hoops Low - Putih Abu', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur asperiores qui libero, quia fugit, nihil dolorem natus possimus quisquam laudantium eum, deleniti vero. Sapiente nostrum libero est esse voluptatem quis eos ut!', 'Sporty, Casual', 129000, 7, 800, 2, '2022-09-03 03:20:25', '2022-10-12 15:49:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `subtotal` int(11) NOT NULL,
  `shipping` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `payment_url` varchar(255) DEFAULT NULL,
  `receipt` varchar(255) NOT NULL DEFAULT '-',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `order_id`, `user_id`, `subtotal`, `shipping`, `total`, `status`, `payment_url`, `receipt`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '202212191005', 7, 149000, 7000, 158500, 'PENDING', 'https://app.sandbox.midtrans.com/snap/v3/redirection/5465258c-c48d-4785-8134-dbd8f0d13b12', '-', '2022-12-19 08:39:55', '2022-12-19 08:39:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_addresses`
--

CREATE TABLE `transaction_addresses` (
  `id` bigint(20) NOT NULL,
  `transaction_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_items`
--

CREATE TABLE `transaction_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) NOT NULL DEFAULT 'assets/user/default_user.png',
  `roles` varchar(255) NOT NULL DEFAULT 'USER',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_order_id_unique` (`order_id`);

--
-- Indexes for table `transaction_addresses`
--
ALTER TABLE `transaction_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_number_unique` (`phone_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaction_addresses`
--
ALTER TABLE `transaction_addresses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_items`
--
ALTER TABLE `transaction_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
