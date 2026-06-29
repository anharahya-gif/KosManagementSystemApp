# KMS — Kos Management System

KMS (Kos Management System) adalah aplikasi manajemen properti kos-kosan, kontrakan, apartemen, dan guest house premium berbasis Flutter. Aplikasi ini dirancang dengan arsitektur bersih (**Clean Architecture**), manajemen state menggunakan **Bloc/Cubit**, dan penyimpanan lokal performa tinggi **Drift (SQLite)** secara *offline-first*.

---

## 🚀 Fitur Utama

### 1. Manajemen Properti & Kamar
* **Multi-Properti**: Kelola properti kos-kosan, kontrakan, apartemen skala kecil, atau guest house secara bersamaan.
* **Integrasi Peta (GPS)**: Dilengkapi dengan pemilih lokasi presisi berbasis OpenStreetMap (FlutterMap).
* **Status Kamar Dinamis**: Pantau kamar kosong (*vacant*), terisi (*occupied*), dipesan (*reserved*), atau sedang dalam perbaikan (*maintenance*).
* **Fasilitas CRUD Kamar**: Kelola inventaris fasilitas per kamar secara detail (AC, Wifi, TV, Kasur, dll.) beserta kondisi fisiknya (Bagus, Rusak, Perlu Perbaikan).
* **Foto Kondisi Kamar**: Simpan foto kondisi fisik kamar untuk dokumentasi inventarisasi aset.

### 2. Penghuni & Kontrak Sewa Dinamis
* **Kelola Data Penghuni**: Simpan informasi identitas (KTP, Email, No. Telepon) dan riwayat keterisian.
* **Kontrak Sewa Dinamis**: Tambah durasi kontrak secara fleksibel yang dihitung otomatis berdasarkan tanggal masuk/check-in penghuni.

### 3. Keuangan & Pembayaran Massal
* **Auto-Invoice**: Tagihan bulanan atau tahunan otomatis terbuat berdasarkan kontrak aktif penghuni.
* **Pembayaran Massal**: Fitur pembayaran tagihan ganda secara sekaligus untuk efisiensi transaksi.
* **Verifikasi Pembayaran**: Kelola pencatatan pembayaran (Cash, Transfer, QRIS) lengkap dengan bukti transfer dan proses verifikasi admin.

### 4. Sistem Kemitraan & Bagi Hasil Bersih (Profit Sharing)
* **Kalkulator Profit Sharing**: Hitung otomatis pembagian hak pendapatan bersih antara **Pemilik Kos (Owner)** dan **Pengelola Kos (Manager)** secara real-time.
* **Perhitungan Bersih**:
  $$\text{Pemasukan Bersih} = \text{Total Sewa Masuk (Lunas)} - \text{Total Pengeluaran}$$
* **Pencatatan Biaya Rutin**: Input cepat biaya bulanan rutin seperti listrik (PLN), internet/wifi, air (PAM), maupun biaya operasional tak terduga lainnya.
* **Integrasi Tiket Kerusakan**: Biaya tiket perbaikan (*maintenance tickets*) yang selesai otomatis terakumulasi sebagai beban pengeluaran properti pada bulan berjalan.

### 5. Smart Dashboard & Recycle Bin
* **Menu Pintar**: Peringatan otomatis penghuni yang akan segera jatuh tempo atau siap check-out dalam waktu dekat.
* **Recycle Bin (Kotak Sampah)**: Amankan data properti, kamar, maupun penghuni yang tidak sengaja terhapus dengan fitur pemulihan (*restore*) satu kali klik.

### 6. Ekspor & Impor Backup Data dengan Auto-Migrator
* **Skema Backup Aman**: Ekspor seluruh data aplikasi ke dalam format file JSON tunggal yang tersimpan di direktori Downloads.
* **JSON Schema Transformers**: Saat impor data, aplikasi otomatis mendeteksi versi data backup lama dan memigrasikan strukturnya agar kompatibel dengan skema database versi terbaru aplikasi (V2 $\rightarrow$ V3 $\rightarrow$ V4) tanpa merusak atau menghilangkan data yang ada.

---

## 🛠️ Arsitektur Proyek

Proyek ini menerapkan pola **Clean Architecture** yang terbagi menjadi 3 lapisan utama:

```
lib/
├── core/                       # Berisi database, tema, utilitas, dan service umum
│   ├── database/               # Drift SQLite schema & migrator
│   ├── services/               # Backup & restore data JSON
│   └── theme/                  # Desain sistem & skema warna premium
└── features/                   # Setiap modul fungsional terbagi per fitur
    ├── auth/                   # Modul autentikasi pengguna
    ├── dashboard/              # Halaman beranda, menu pintar & recycle bin
    ├── property/               # Manajemen properti, kamar, & fasilitas CRUD
    ├── contract/               # Manajemen kontrak sewa, invoice, & bagi hasil
    └── resident/               # Manajemen data penghuni kos
```

---

## 💻 Cara Menjalankan Aplikasi

### Persyaratan Awal
* Flutter SDK (Versi terbaru direkomendasikan)
* Dart SDK
* Android Studio / VS Code

### Langkah Instalasi

1. **Unduh Dependensi**:
   ```bash
   flutter pub get
   ```

2. **Jalankan Code Generator (Drift/SQLite)**:
   Karena Drift menggunakan generator kode compile-time untuk efisiensi kueri database, jalankan perintah ini sebelum memulai:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Jalankan Aplikasi**:
   ```bash
   flutter run
   ```

4. **Kompilasi ke APK Produksi**:
   ```bash
   flutter build apk --release
   ```

---

## 📄 Lisensi
Hak Cipta milik **KMS (Kos Management System) App Team**. Segala bentuk duplikasi dan redistribusi kode tanpa izin tertulis dilarang keras.
