# wanigo_nasabah

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 📁 Struktur Folder Flutter Project

Struktur proyek ini mengikuti pendekatan modular yang memisahkan konfigurasi inti, data, dan fitur aplikasi, sehingga mudah dipelihara dan dikembangkan.

---

## 🔹 lib/

Folder utama yang menyimpan seluruh kode sumber aplikasi Flutter.

---

## 🔹 core/

Berisi komponen inti dan konfigurasi dasar aplikasi.

### 📁 config/

Berisi konfigurasi aplikasi secara global.

- `main_app.dart`: Entry point logika aplikasi. Mengatur tema, routing, dependency injection, dll.

### 📁 constants/

Berisi nilai-nilai konstan (seperti warna, teks, dan padding) yang digunakan secara global di aplikasi.

### 📁 helpers/

Fungsi-fungsi pembantu (utility functions) yang reusable.

### 📁 services/

Layer yang bertanggung jawab untuk komunikasi dengan API eksternal.

- `endpoints.dart`: Mendefinisikan endpoint-endpoint API.
- `http_network_manager.dart`: Menangani request dan response HTTP.

### 📁 utils/

Fungsi utilitas umum yang mendukung logika aplikasi.

- `route_utils.dart`: Berisi helper untuk routing/navigation.

---

## 🔹 data/

Folder ini ditujukan untuk menyimpan model, repository, dan data layer lainnya. Saat ini belum terisi file.

---

## 🔹 features/

Folder utama untuk menyimpan fitur berdasarkan fungsionalitas.

### 📁 login/

Fitur login aplikasi.

### 📁 register/

Fitur register pengguna.

### 📁 splash/

Berisi fitur splash screen aplikasi.

- `controller/`: Menyimpan logic/state management splash screen.
- `splash_screen.dart`: File tampilan UI dari splash screen.

---

## 📄 main.dart

File utama aplikasi Flutter yang menjalankan fungsi `runApp()` dan memulai aplikasi.

---

## ✅ Kesimpulan

Struktur folder ini menerapkan prinsip clean architecture secara ringan dengan pemisahan `core`, `data`, dan `features`, yang cocok untuk aplikasi menengah hingga besar agar lebih terorganisir, scalable, dan mudah di-maintain.
