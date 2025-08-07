-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Agu 2025 pada 08.38
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_ta`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `announcements`
--

INSERT INTO `announcements` (`id`, `message`, `created_at`, `updated_at`) VALUES
(1, 'Kelola data barang, peminjaman, dan laporan kerusakan dengan lebih efisien.', '2025-07-02 13:01:26', '2025-07-02 13:05:35'),
(2, 'Kelola data barang, peminjaman, dan laporan kerusakan dengan lebih efisien.', '2025-07-02 13:03:13', '2025-07-02 13:03:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `slug`, `thumbnail`, `content`, `user_id`, `created_at`, `updated_at`) VALUES
(3, 'Masalah Potensial & Antisipasi Sistem Peminjaman', 'masalah-potensial-antisipasi-sistem-peminjaman', 'thumbnails/531sLUohFkChxIsuzajuzVIsTvh9PKckT6M72cVy.jpg', '<p><strong>Berdasarkan</strong> analisis controller Anda, saya melihat sudah ada validasi stok berdasarkan overlap tanggal yang cukup bagus. Namun masih ada beberapa area yang bisa diperkuat untuk mencegah persilangan data dan masalah peminjaman. Masalah Potensial yang Saya Temukan: Race Condition - Dua user bisa submit bersamaan untuk barang yang sama Tidak ada validasi batas waktu peminjaman - User bisa meminjam terlalu lama Tidak ada cooldown period - User bisa langsung meminjam barang yang sama berulang kali Missing unique constraints pada database level Rekomendasi Prioritas Tinggi: Implementasi Database Locking untuk mencegah race condition Real-time availability checker dengan AJAX Enhanced date validation dengan business rules Duplicate prevention dengan unique constraints Apakah Anda ingin saya buatkan implementasi konkret untuk salah satu fitur ini? Misalnya, saya bisa buatkan kode untuk real-time availability checker atau sistem database locking yang robust.</p>', 1, '2025-07-20 17:37:14', '2025-07-21 05:43:35');

-- --------------------------------------------------------

--
-- Struktur dari tabel `borrowings`
--

CREATE TABLE `borrowings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('Pending','Approved','Waiting Approval','Rejected','Returned') NOT NULL,
  `returned_by` bigint(20) UNSIGNED DEFAULT NULL,
  `borrow_date` date NOT NULL,
  `return_date` date NOT NULL,
  `returned_at` timestamp NULL DEFAULT NULL,
  `approved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `penalty` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `penalty_status` enum('Unpaid','Paid') NOT NULL DEFAULT 'Unpaid',
  `penalty_proof` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `borrowings`
--

INSERT INTO `borrowings` (`id`, `user_id`, `status`, `returned_by`, `borrow_date`, `return_date`, `returned_at`, `approved_by`, `approved_at`, `penalty`, `created_at`, `updated_at`, `penalty_status`, `penalty_proof`) VALUES
(84, 27, 'Returned', NULL, '2025-07-20', '2025-07-22', NULL, 1, '2025-07-20 08:44:44', NULL, '2025-07-20 08:44:05', '2025-07-20 11:12:11', 'Unpaid', NULL),
(85, 27, 'Rejected', NULL, '2025-07-20', '2025-07-22', NULL, NULL, NULL, NULL, '2025-07-20 11:13:37', '2025-07-20 11:14:02', 'Unpaid', NULL),
(86, 1, 'Rejected', NULL, '2025-07-20', '2025-07-22', NULL, NULL, NULL, NULL, '2025-07-20 11:13:45', '2025-07-20 11:14:10', 'Unpaid', NULL),
(87, 1, 'Rejected', NULL, '2025-07-21', '2025-07-24', NULL, NULL, NULL, NULL, '2025-07-21 04:17:51', '2025-07-21 04:18:26', 'Unpaid', NULL),
(88, 1, 'Returned', NULL, '2025-07-22', '2025-07-23', NULL, 1, '2025-07-22 13:52:00', NULL, '2025-07-22 13:51:30', '2025-07-22 14:28:48', 'Unpaid', NULL),
(89, 1, 'Returned', NULL, '2025-07-24', '2025-07-27', NULL, 1, '2025-07-22 15:02:48', NULL, '2025-07-22 15:02:38', '2025-07-22 15:03:06', 'Unpaid', NULL),
(90, 1, 'Returned', NULL, '2025-07-26', '2025-07-27', NULL, 1, '2025-07-22 15:06:22', NULL, '2025-07-22 15:06:14', '2025-07-22 15:06:36', 'Unpaid', NULL),
(91, 1, 'Returned', NULL, '2025-07-30', '2025-08-01', NULL, 1, '2025-07-22 15:08:11', NULL, '2025-07-22 15:08:00', '2025-07-22 15:09:03', 'Unpaid', NULL),
(92, 27, 'Returned', NULL, '2025-08-08', '2025-08-09', NULL, 1, '2025-08-05 02:39:29', NULL, '2025-08-05 02:38:06', '2025-08-06 02:58:24', 'Unpaid', NULL),
(93, 27, 'Rejected', NULL, '2025-08-06', '2025-08-08', NULL, NULL, NULL, NULL, '2025-08-06 02:50:42', '2025-08-06 02:58:11', 'Unpaid', NULL),
(94, 27, 'Returned', NULL, '2025-08-06', '2025-08-07', NULL, NULL, NULL, NULL, '2025-08-06 02:54:43', '2025-08-06 02:58:35', 'Unpaid', NULL),
(95, 28, 'Rejected', NULL, '2025-08-06', '2025-08-08', NULL, NULL, NULL, NULL, '2025-08-06 03:26:51', '2025-08-06 03:30:22', 'Unpaid', NULL),
(96, 28, 'Rejected', NULL, '2025-08-06', '2025-08-08', NULL, NULL, NULL, NULL, '2025-08-06 03:27:50', '2025-08-06 03:28:46', 'Unpaid', NULL),
(97, 27, 'Returned', NULL, '2025-08-06', '2025-08-07', NULL, 1, '2025-08-06 03:40:02', NULL, '2025-08-06 03:31:52', '2025-08-07 02:43:03', 'Unpaid', NULL),
(98, 28, 'Rejected', NULL, '2025-08-06', '2025-08-07', NULL, NULL, NULL, NULL, '2025-08-06 03:32:10', '2025-08-06 03:41:09', 'Unpaid', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `borrowing_items`
--

CREATE TABLE `borrowing_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `borrowing_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `return_photo` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `borrowing_items`
--

INSERT INTO `borrowing_items` (`id`, `borrowing_id`, `item_id`, `quantity`, `return_photo`, `condition`, `created_at`, `updated_at`) VALUES
(104, 92, 12, 50, NULL, 'Baik', NULL, NULL),
(105, 92, 13, 50, NULL, 'Baik', NULL, NULL),
(106, 92, 14, 5, NULL, 'Baik', NULL, NULL),
(107, 93, 16, 4, NULL, NULL, NULL, NULL),
(108, 94, 12, 25, NULL, NULL, NULL, NULL),
(109, 94, 13, 25, NULL, NULL, NULL, NULL),
(110, 95, 12, 50, NULL, NULL, NULL, NULL),
(111, 95, 13, 50, NULL, NULL, NULL, NULL),
(112, 96, 12, 50, NULL, NULL, NULL, NULL),
(113, 96, 13, 50, NULL, NULL, NULL, NULL),
(114, 97, 12, 50, NULL, NULL, NULL, NULL),
(115, 97, 13, 50, NULL, NULL, NULL, NULL),
(116, 98, 12, 50, NULL, NULL, NULL, NULL),
(117, 98, 13, 50, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('m_inventory_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}', 1754552749);

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'Pecah Belah', '2025-06-04 00:17:33', '2025-06-04 00:17:33'),
(4, 'Elektronik', '2025-06-04 01:19:51', '2025-06-04 01:19:51'),
(5, 'Tikar', '2025-06-09 21:35:27', '2025-06-09 21:35:27');

-- --------------------------------------------------------

--
-- Struktur dari tabel `damage_reports`
--

CREATE TABLE `damage_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text NOT NULL,
  `report_date` date NOT NULL DEFAULT curdate(),
  `status` enum('Reported','In Progress','Resolved') NOT NULL DEFAULT 'Reported',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
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
-- Struktur dari tabel `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `year_of_purchase` year(4) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `specifications` text DEFAULT NULL,
  `condition` enum('Baik','Rusak Ringan','Rusak Berat','Dalam Perbaikan') NOT NULL DEFAULT 'Baik',
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `items`
--

INSERT INTO `items` (`id`, `code`, `name`, `stock`, `category_id`, `brand`, `model`, `year_of_purchase`, `price`, `specifications`, `condition`, `location_id`, `created_at`, `updated_at`) VALUES
(12, 'P3S-1', 'Gelas', 100, 3, 'gelas', 'gelas kecil', '2018', 5000.00, NULL, 'Baik', 19, '2025-07-23 07:01:55', '2025-08-07 02:43:03'),
(13, 'P3S-2', 'Piring', 100, 3, 'piring', 'piring standar', '2018', 5000.00, NULL, 'Baik', 19, '2025-07-23 07:02:28', '2025-08-07 02:43:03'),
(14, 'P3S-3', 'Tikar terpal', 30, 5, 'Tikar', 'Ukuran Sedang', '2015', 3000.00, NULL, 'Baik', 19, '2025-07-23 07:03:23', '2025-08-06 02:55:40'),
(15, 'P3S-4', 'Meja', 50, 3, 'meja', 'Meja kayu', '2015', 1000.00, NULL, 'Baik', 19, '2025-07-23 07:04:20', '2025-07-23 07:04:20'),
(16, 'SP-01', 'Jagrak', 4, 3, 'jagrak', 'tenda', '2012', 4000000.00, NULL, 'Baik', 20, '2025-07-23 07:06:04', '2025-07-23 07:06:04'),
(17, 'SK-01', 'Kompor', 2, 3, 'sanyo', 'dua tungku', '2012', 400000.00, NULL, 'Baik', 22, '2025-07-23 07:07:01', '2025-07-23 07:07:01'),
(18, 'MI-01', 'Kursi', 50, 3, 'Kursi', 'Kursi plastik', '2025', 2000000.00, NULL, 'Baik', 21, '2025-07-23 07:08:21', '2025-08-06 15:05:43'),
(19, 'GM-01', 'Baki', 4, 3, 'baki kayu', 'baki kayu', '2024', 50000.00, NULL, 'Baik', 23, '2025-07-23 07:09:24', '2025-07-23 07:09:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `item_histories`
--

CREATE TABLE `item_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `activity` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `locations`
--

INSERT INTO `locations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(19, 'Gudang Pemuda', '2025-07-23 06:58:35', '2025-07-23 06:58:35'),
(20, 'Gudang Senin Pahing', '2025-07-23 06:58:47', '2025-07-23 06:59:52'),
(21, 'Gudang Mijen', '2025-07-23 06:59:03', '2025-07-23 06:59:03'),
(22, 'Gudang Seloso Kliwon', '2025-07-23 06:59:37', '2025-07-23 06:59:37'),
(23, 'Gudang Masjid', '2025-07-23 07:00:31', '2025-07-23 07:00:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_06_01_170945_add_role_to_users_table', 2),
(5, '2025_06_02_023642_create_categories_table', 2),
(6, '2025_06_02_023748_create_locations_table', 2),
(7, '2025_06_02_023821_create_items_table', 2),
(8, '2025_06_02_023902_create_borrowings_table', 2),
(9, '2025_06_02_023946_create_borrowing_items_table', 2),
(10, '2025_06_02_024016_create_item_histories_table', 2),
(11, '2025_06_02_024053_create_damage_reports_table', 2),
(14, '2025_06_02_063246_create_permission_tables', 3),
(15, '2025_06_02_064127_create_personal_access_tokens_table', 3),
(16, '2025_06_04_084102_add_return_photo_to_borrowing_items_table', 4),
(17, '2025_06_10_035233_remove_role_from_users_table', 5),
(18, '2025_06_10_055615_add_stock_to_items_table', 6),
(19, '2025_06_10_121957_add_user_id_to_damage_reports_table', 7),
(20, '2025_06_11_072738_add_phone_number_to_users_table', 8),
(21, '2025_06_11_115041_add_last_seen_at_to_users_table', 9),
(22, '2025_06_15_022202_add_profile_photo_to_users_table', 10),
(24, '2025_06_19_062145_add_returned_by_to_borrowings_table', 11),
(25, '2025_06_19_070330_add_returned_at_to_borrowings_table', 12),
(26, '2025_06_30_061537_create_notifications_table', 13),
(27, '2025_07_02_194409_create_announcements_table', 14),
(28, '2025_07_07_213737_add_penalty_payment_to_borrowings_table', 15),
(29, '2025_07_19_144722_add_otp_to_users_table', 16),
(30, '2025_07_20_215540_create_blogs_table', 17),
(31, '2025_07_21_113606_add_thumbnail_to_blogs_table', 18),
(32, '2025_07_22_215847_add_condition_to_borrowing_items_table', 19);

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(2, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 29),
(3, 'App\\Models\\User', 27),
(3, 'App\\Models\\User', 28);

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('03f10b5f-33cd-420b-a176-d3b8de62a9e5', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Approved\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/84\"}', NULL, '2025-07-20 08:44:44', '2025-07-20 08:44:44'),
('04c6bae8-40ac-431a-8fd4-6ada7b654700', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Mahasiswa yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/95\"}', NULL, '2025-08-06 03:26:54', '2025-08-06 03:26:54'),
('078c31df-badc-495a-9fc5-98bcfab562fa', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/90\"}', NULL, '2025-07-22 15:06:15', '2025-07-22 15:06:15'),
('10d5c697-3dfd-400a-8515-617434c2c385', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/92\"}', NULL, '2025-08-05 02:38:13', '2025-08-05 02:38:13'),
('1936903b-7cc3-4186-9c33-7d19d048aafa', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Rejected\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/85\"}', NULL, '2025-07-20 11:14:02', '2025-07-20 11:14:02'),
('1eb0428a-9e63-41d2-9a8f-4da99b664bf9', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Returned\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/97\"}', NULL, '2025-08-07 02:43:09', '2025-08-07 02:43:09'),
('3bc1f3d9-0036-4962-a7d0-01fd8b40a136', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 27, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/88\"}', NULL, '2025-07-22 13:51:35', '2025-07-22 13:51:35'),
('3c613fb3-4c54-4728-aeef-e8b779a16a5d', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Returned\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/84\"}', NULL, '2025-07-20 11:12:12', '2025-07-20 11:12:12'),
('4493736b-bc8e-446e-b5e1-f4ecfba538be', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/87\"}', NULL, '2025-07-21 04:17:55', '2025-07-21 04:17:55'),
('59b6b8d3-0537-4f47-87d8-b0de12afb7af', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/88\"}', NULL, '2025-07-22 13:51:34', '2025-07-22 13:51:34'),
('81a6ef34-12e2-4e71-a4ec-e28ff24d97d8', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 28, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Rejected\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/96\"}', NULL, '2025-08-06 03:28:49', '2025-08-06 03:28:49'),
('82fc32a8-70df-495f-8eea-b341d75c988a', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Mahasiswa yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/96\"}', NULL, '2025-08-06 03:27:51', '2025-08-06 03:27:51'),
('8a1283d0-ba4e-4cdd-a192-c39c8582ad08', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/94\"}', NULL, '2025-08-06 02:54:45', '2025-08-06 02:54:45'),
('90c96e23-019b-470f-af8f-02f5a408bdcc', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Returned\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/94\"}', NULL, '2025-08-06 02:58:36', '2025-08-06 02:58:36'),
('9271059c-611d-48f1-b603-44e36d98593a', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Rejected\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/93\"}', NULL, '2025-08-06 02:58:12', '2025-08-06 02:58:12'),
('a0f71fae-ce35-4754-b493-91f8aaa86840', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 28, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Rejected\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/95\"}', NULL, '2025-08-06 03:30:23', '2025-08-06 03:30:23'),
('aad6c08e-472d-4bf2-9153-aea34a65f8dd', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/91\"}', NULL, '2025-07-22 15:08:01', '2025-07-22 15:08:01'),
('abbf8754-dc82-41a3-bbbc-afaabf11587b', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Approved\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/97\"}', NULL, '2025-08-06 03:40:05', '2025-08-06 03:40:05'),
('b436d02c-549a-4d41-9ef5-fb701fccb160', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Returned\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/92\"}', NULL, '2025-08-06 02:58:25', '2025-08-06 02:58:25'),
('b51ee99a-6fa3-442d-99d0-859a6158d57e', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 27, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Approved\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/92\"}', NULL, '2025-08-05 02:39:30', '2025-08-05 02:39:30'),
('b7196e35-f799-4748-b2ed-0f366f34aa14', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/85\"}', NULL, '2025-07-20 11:13:38', '2025-07-20 11:13:38'),
('b9186213-58a3-4ccd-80c9-14636a1e2d7c', 'App\\Notifications\\BorrowingStatusUpdated', 'App\\Models\\User', 28, '{\"message\":\"Status peminjaman Anda diperbarui menjadi Rejected\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/98\"}', NULL, '2025-08-06 03:41:10', '2025-08-06 03:41:10'),
('c08f10b4-27b5-4d45-bee2-942b6ab415ce', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/84\"}', NULL, '2025-07-20 08:44:09', '2025-07-20 08:44:09'),
('daa8fa8d-f4c9-42c0-862a-129827224245', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/89\"}', NULL, '2025-07-22 15:02:39', '2025-07-22 15:02:39'),
('ec99716d-29d5-427e-8785-fac1015671ae', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/97\"}', NULL, '2025-08-06 03:31:53', '2025-08-06 03:31:53'),
('f2d2b334-c074-4b11-b201-5700ff77e38b', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Mahasiswa yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/98\"}', NULL, '2025-08-06 03:32:11', '2025-08-06 03:32:11'),
('f7730fcb-425c-43d2-be4b-70306fdac5be', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Yulfan\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/93\"}', NULL, '2025-08-06 02:50:49', '2025-08-06 02:50:49'),
('ff5c3b8d-ecce-41f4-a2a7-4fc9bbc71a1b', 'App\\Notifications\\NewBorrowingNotification', 'App\\Models\\User', 1, '{\"message\":\"Permintaan peminjaman baru dari Maheswara\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/borrowings\\/86\"}', NULL, '2025-07-20 11:13:46', '2025-07-20 11:13:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('mahesvaranirwataka@gmail.com', '$2y$12$LFlS2kFI/mvZuMJDT5QR6OMHychCyff98hvbixQ61TK/sp0TRcwOe', '2025-06-29 20:59:15'),
('yulfan61@gmail.com', '$2y$12$bLVaBfwdQp4QKIGdprfgVeUqTj49bGakgRM5vP.ZlC7djAYhrWiOC', '2025-07-09 07:32:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(2, 'Admin', 'web', '2025-06-08 20:45:08', '2025-06-08 20:45:08'),
(3, 'Peminjam', 'web', '2025-06-08 20:45:18', '2025-06-08 20:45:18'),
(4, 'Staff', 'web', '2025-06-08 20:45:49', '2025-06-08 20:45:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('6AyqGk4XqIaeiG3KhpM9zvL8Wh5ixh7RYANdrCDs', 29, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUjhqSWVZWFBkNjFRODEzY1JWRmMzUThXVnR4aXFtdXIzbUpFVmFuOCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQ1OiJodHRwOi8vNGM0Mzg1ZmYwMWY3Lm5ncm9rLWZyZWUuYXBwL2JvcnJvd2luZ3MiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyOTt9', 1754547953),
('x3CMasAzp4PSYmLL0EOcmhZuxsckfxbyMX2Zu2NP', NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2NaZkF3MksycTVVeXpaRm5ycTZqS044WklKSDRhZFlRbW0yZHVFYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly80YzQzODVmZjAxZjcubmdyb2stZnJlZS5hcHAvP3BhZ2U9MiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1754545458),
('Xj4yqS355iY96RmhT08VF8UPlhk0H0ymJCjSkUGr', 27, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSGtBV2EzZldoejl5Qnh3NWtMNlJ5Sm11TzFkVkhKVkxHV0FmUGFrMCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTI6Imh0dHA6Ly80YzQzODVmZjAxZjcubmdyb2stZnJlZS5hcHAvYm9ycm93aW5ncy9jcmVhdGUiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyNzt9', 1754546883);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `otp_code` varchar(255) DEFAULT NULL,
  `otp_expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone_number`, `email_verified_at`, `last_seen_at`, `password`, `remember_token`, `created_at`, `updated_at`, `profile_photo`, `otp_code`, `otp_expires_at`) VALUES
(1, 'Maheswara', 'mahesvaranirwataka@gmail.com', '6288225415700', NULL, '2025-08-07 04:54:21', '$2y$12$PYSWcYgw50NCal8dVd9OmOqQ4IgK30l6X6gsxHUXZHgURalynX5Ba', 'XrFSGnV8HmpnzDwO649SIx0Q1Cd3FgJpKywO1qaeiKekUUuXt2mpdSB4gINm', '2025-06-02 22:34:31', '2025-08-07 04:54:21', 'profile-photos/mf87NWYueBB4934PVJcEthNv5TCBRxRx84l1alUi.jpg', NULL, NULL),
(27, 'Yulfan', 'yulfan61@gmail.com', '6288225415700', NULL, '2025-08-07 06:08:03', '$2y$12$FEmzHT2X5FFswdhe5H8iae/nj0ogCW1AIYGxb/3dK/SopODJWrgsO', NULL, '2025-07-20 06:48:49', '2025-08-07 06:08:03', NULL, NULL, NULL),
(28, 'Mahasiswa yulfan', 'yulfan61@students.amikom.ac.id', '6282230132780', NULL, '2025-08-06 03:42:06', '$2y$12$SKrzUUrz2Xnf/4wWlgI7auvywJ.VTHFWCvxUUr66AdhI8RPXb/vjW', NULL, '2025-07-22 02:56:47', '2025-08-06 03:42:06', NULL, NULL, NULL),
(29, 'Martin', 'riskymartinsaputra@gmail.com', '6289676008332', NULL, '2025-08-07 06:25:53', '$2y$12$S7ZKSPTBCeKsOFAa/IGvJeEjUYdfbJ7zMTaAlJNtZaWvvXJwBfCrO', NULL, '2025-08-06 14:07:57', '2025-08-07 06:25:53', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blogs_slug_unique` (`slug`),
  ADD KEY `blogs_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrowings_user_id_foreign` (`user_id`),
  ADD KEY `borrowings_approved_by_foreign` (`approved_by`),
  ADD KEY `borrowings_returned_by_foreign` (`returned_by`);

--
-- Indeks untuk tabel `borrowing_items`
--
ALTER TABLE `borrowing_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrowing_items_borrowing_id_foreign` (`borrowing_id`),
  ADD KEY `borrowing_items_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `damage_reports`
--
ALTER TABLE `damage_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `damage_reports_item_id_foreign` (`item_id`),
  ADD KEY `damage_reports_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `items_code_unique` (`code`),
  ADD KEY `items_category_id_foreign` (`category_id`),
  ADD KEY `items_location_id_foreign` (`location_id`);

--
-- Indeks untuk tabel `item_histories`
--
ALTER TABLE `item_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_histories_item_id_foreign` (`item_id`),
  ADD KEY `item_histories_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `borrowings`
--
ALTER TABLE `borrowings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT untuk tabel `borrowing_items`
--
ALTER TABLE `borrowing_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `damage_reports`
--
ALTER TABLE `damage_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `item_histories`
--
ALTER TABLE `item_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT untuk tabel `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `blogs`
--
ALTER TABLE `blogs`
  ADD CONSTRAINT `blogs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `borrowings`
--
ALTER TABLE `borrowings`
  ADD CONSTRAINT `borrowings_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `borrowings_returned_by_foreign` FOREIGN KEY (`returned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `borrowings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `borrowing_items`
--
ALTER TABLE `borrowing_items`
  ADD CONSTRAINT `borrowing_items_borrowing_id_foreign` FOREIGN KEY (`borrowing_id`) REFERENCES `borrowings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `borrowing_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `damage_reports`
--
ALTER TABLE `damage_reports`
  ADD CONSTRAINT `damage_reports_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `damage_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `items_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `item_histories`
--
ALTER TABLE `item_histories`
  ADD CONSTRAINT `item_histories_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
