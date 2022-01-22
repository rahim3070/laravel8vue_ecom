-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2022 at 05:03 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_lara_vue`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(6, 'Fruit', 'fruit', '2022-01-19 06:48:43', '2022-01-19 06:51:31'),
(7, 'Fish', 'fish', '2022-01-19 06:48:50', '2022-01-19 06:48:50'),
(8, 'Vegetable', 'vegetable', '2022-01-19 06:51:42', '2022-01-19 06:51:42');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(63, '2014_10_12_000000_create_users_table', 1),
(64, '2014_10_12_100000_create_password_resets_table', 1),
(65, '2019_08_19_000000_create_failed_jobs_table', 1),
(66, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(67, '2021_10_12_134309_create_orders_table', 1),
(68, '2021_10_12_134325_create_order_details_table', 1),
(69, '2022_01_18_181527_create_categories_table', 1),
(70, '2022_01_18_200338_create_products_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `subtotal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_id`, `user_id`, `subtotal`, `total`, `payment_type`, `status`, `created_at`, `updated_at`) VALUES
(1, '270671', 1, '220.00', '220.00', 'Cash on Delivery', 5, NULL, NULL),
(2, '383997', 1, '220.00', '220.00', 'Cash on Delivery', 0, NULL, NULL),
(3, '197604', 1, '300.00', '300.00', 'Cash on Delivery', 1, NULL, NULL),
(4, '387138', 2, '160.00', '160.00', 'Cash on Delivery', 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `single_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `product_name`, `quantity`, `single_price`, `subtotal_price`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 'Vendi', '1', '60', '60', NULL, NULL),
(2, 2, 2, 'Apple', '1', '160', '160', NULL, NULL),
(3, 3, 3, 'Telapiya', '1', '140', '140', NULL, NULL),
(4, 3, 2, 'Apple', '1', '160', '160', NULL, NULL),
(5, 4, 26, 'Apple4', '1', '160', '160', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `qty` decimal(18,2) NOT NULL DEFAULT 0.00,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `slug`, `price`, `qty`, `image`, `description`, `category_id`, `created_at`, `updated_at`) VALUES
(2, 'Apple', 'apple', 160, '1.00', '/storage/product/1642618168_61e85d3808bae.jpg', 'Apple Description', 6, '2022-01-19 06:49:27', '2022-01-19 06:49:28'),
(3, 'Telapiya', 'telapiya', 140, '132.00', '/storage/product/1642618268_61e85d9c9caeb.jpeg', 'Telapiya Description', 7, '2022-01-19 06:51:08', '2022-01-19 06:51:08'),
(4, 'Vendi', 'vendi', 60, '160.00', '/storage/product/1642618408_61e85e281296e.jfif', 'Vendi Description', 8, '2022-01-19 06:53:27', '2022-01-19 06:53:28'),
(5, 'Apple 2', 'apple-2', 130, '120.00', '/storage/product/1642792761_61eb0739eb8e3.png', 'Apple 2 Description', 6, '2022-01-21 13:19:21', '2022-01-21 13:19:21'),
(6, 'Fish 2', 'fish-2', 150, '140.00', '/storage/product/1642792823_61eb077768232.jpeg', 'Fish 2 Description', 7, '2022-01-21 13:20:23', '2022-01-21 13:20:23'),
(7, 'Vendi 2', 'vendi-2', 80, '140.00', '/storage/product/1642792879_61eb07afc1665.jpg', 'Vendi 2 Description', 8, '2022-01-21 13:21:19', '2022-01-21 13:21:19'),
(26, 'Apple4', 'apple-4', 160, '10.00', '/storage/product/1642618168_61e85d3808bae.jpg', 'Apple Description', 6, '2022-01-19 06:49:27', '2022-01-19 06:49:28'),
(27, 'Telapiya4', 'telapiya-4', 140, '132.00', '/storage/product/1642618268_61e85d9c9caeb.jpeg', 'Telapiya Description', 7, '2022-01-19 06:51:08', '2022-01-19 06:51:08'),
(28, 'Vendi4', 'vendi-4', 60, '160.00', '/storage/product/1642618408_61e85e281296e.jfif', 'Vendi Description', 8, '2022-01-19 06:53:27', '2022-01-19 06:53:28'),
(29, 'Apple 3', 'apple-3', 130, '120.00', '/storage/product/1642792761_61eb0739eb8e3.png', 'Apple 2 Description', 6, '2022-01-21 13:19:21', '2022-01-21 13:19:21'),
(30, 'Fish 3', 'fish-3', 150, '140.00', '/storage/product/1642792823_61eb077768232.jpeg', 'Fish 2 Description', 7, '2022-01-21 13:20:23', '2022-01-21 13:20:23'),
(31, 'Vendi 3', 'vendi-3', 80, '140.00', '/storage/product/1642792879_61eb07afc1665.jpg', 'Vendi 2 Description', 8, '2022-01-21 13:21:19', '2022-01-21 13:21:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_admin` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password_hint` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `is_admin`, `name`, `email`, `email_verified_at`, `password_hint`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'Md. Abdur Rahim', 'rahim3070@gmail.com', NULL, '12345678', '$2y$10$Ce6SCaQqMktXX6etB2B9L.lA8FehuzMZQXS3s.DYd/CCobiQ94B36', NULL, '2022-01-20 10:00:11', '2022-01-20 10:00:11'),
(2, 0, 'Arr', 'rahim@gmail.com', NULL, '12345678', '$2y$10$xt5rWvNg8cAyl9QY/gVeTusKdEcQS9YU/8JBNnyhKgRk8NAf9kMQ2', NULL, '2022-01-20 10:02:53', '2022-01-20 10:02:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

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
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_title_unique` (`title`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_category_id_foreign` (`category_id`);

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
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
