# Functional Specification Document (FSD)
## Kos Management System (KMS)

Dokumen ini menjelaskan spesifikasi fungsional untuk aplikasi Kos Management System (KMS) versi MVP hingga pengembangan lanjutan berbasis Flutter, dengan fokus pada tiga peran utama: **Pemilik (Owner)**, **Pengelola (Manager)**, dan **Penghuni (Resident)**.

---

## 1. Peran & Hak Akses (Role & Permissions)

Sistem membatasi akses fitur berdasarkan peran pengguna berikut:

| Fitur / Modul | Pemilik (Owner) | Pengelola (Manager) | Penghuni (Resident) | Keterangan |
| :--- | :---: | :---: | :---: | :--- |
| **Manajemen Organisasi** | ya | tidak | tidak | Mengubah nama organisasi & pengaturan umum. |
| **Manajemen Staff/Manager** | ya | tidak | tidak | Owner mengelola akses pengelola properti. |
| **Manajemen Properti** | ya | tidak | tidak | Membuat & mengedit properti (Kos, Kontrakan, dll). |
| **Manajemen Kamar** | ya | ya | tidak | Mengelola nomor kamar, harga, dan status perbaikan. |
| **Manajemen Penghuni** | ya | ya | tidak | Mendaftarkan profil penghuni oleh pengelola. |
| **Manajemen Kontrak** | ya | ya | tidak | Membuat, mengubah, memperpajang, atau mengakhiri kontrak. |
| **Invoice & Piutang** | ya | ya | lihat saja | Pengelola mengelola tagihan. Penghuni hanya melihat tagihan miliknya. |
| **Pencatatan Pembayaran** | ya | ya | tidak | Pengelola memverifikasi dan mencatat pembayaran formal. |
| **Konfirmasi Pembayaran** | tidak | tidak | ya | Penghuni mengirimkan bukti transfer pembayaran mandiri. |
| **Tiket Maintenance** | ya | ya | ya | Penghuni mengajukan tiket kerusakan, Pengelola memprosesnya. |
| **Dashboard & Laporan** | ya (Semua) | ya (Filtered) | ya (Ringkasan) | Owner/Manager melihat laporan bisnis. Resident melihat tagihan & status hunian. |

---

## 2. Spesifikasi Fungsional per Modul

### 2.1 Modul 1: Autentikasi & Manajemen Pengguna (Simulasi Lokal)
* **F-1.1 Pilihan Profil Masuk**: Di halaman awal, pengguna dapat memilih masuk sebagai **Pemilik (Owner)**, salah satu **Pengelola (Manager)**, atau **Penghuni (Resident)** yang aktif.
* **F-1.2 Kelola Pengelola (Owner Only)**: Owner mendaftarkan nama, no HP, email Manager, dan menentukan properti yang dikelola.
* **F-1.3 Akun Penghuni (Self-Service Link)**: Saat Manager mendaftarkan penghuni, sistem membuat record data penghuni. Ketika penghuni "login", data akun user-nya dihubungkan dengan data penghuni tersebut agar ia dapat melihat data sewa pribadinya.

### 2.2 Modul 2: Properti & Kamar (Property & Room Management)
* **F-2.1 Properti (Owner Only)**: Membuat properti dengan nama, alamat, dan tipe.
* **F-2.2 Kamar (Owner & Manager)**: Mengelola kamar (nomor, lantai, harga sewa, fasilitas).
* **F-2.3 Status Kamar Otomatis**:
  * `Vacant` (Kosong), `Occupied` (Terisi), `Reserved` (Dipesan), `Maintenance` (Perbaikan), `Inactive` (Nonaktif).

### 2.3 Modul 3: Manajemen Penghuni & Siklus Hidup (Resident Management)
* **F-3.1 Data Profil**: Nama, No. HP, Email, KTP, Kontak Darurat.
* **F-3.2 Siklus Hidup Penghuni**:
  * `Prospective` (Calon), `Active` (Aktif), `Moved` (Pindah Kamar), `Checked Out` (Sudah keluar tapi masih ada piutang/deposit belum selesai), `Inactive` (Mantan penghuni tanpa tunggakan).

### 2.4 Modul 4: Manajemen Kontrak & Perpindahan (Contract Management)
* **F-4.1 Pembuatan Kontrak**: Menghubungkan Penghuni & Kamar. Menentukan tanggal mulai/selesai, harga, deposit, dan siklus tagihan (bulanan). Otomatis generate Invoice pertama & ubah status kamar menjadi `Occupied`.
* **F-4.2 Pindah Kamar (Change Room)**: Memindahkan kamar di tengah kontrak. Mengupdate penugasan kamar pada kontrak, mengubah status kamar lama (`Vacant`) dan kamar baru (`Occupied`), tanpa menghapus histori pembayaran kontrak.
* **F-4.3 Perpanjangan Kontrak (Renewal)**: Membuat kontrak baru untuk perpanjangan tanpa menghapus riwayat sewa sebelumnya.

### 2.5 Modul 5: Tagihan & Piutang Otomatis (Billing & Accounts Receivable)
* **F-5.1 Auto-Invoice**: Invoice di-generate sistem berdasarkan kontrak. Tiap jatuh tempo siklus baru, invoice baru dibuat otomatis.
* **F-5.2 Piutang Otomatis**: Menghitung sisa tunggakan per invoice dan total piutang penghuni secara real-time.

### 2.6 Modul 6: Pembayaran (Payment Management)
* **F-6.1 Konfirmasi Pembayaran Mandiri (Resident)**: Penghuni dapat mengunggah bukti transfer, nominal yang ditransfer, bank asal, dan memilih invoice mana saja yang ingin dibayarkan melalui portal penghuni.
* **F-6.2 Verifikasi & Catat Pembayaran (Owner/Manager)**: Pengelola melihat daftar konfirmasi pembayaran dari penghuni, memeriksa mutasi rekening bank, lalu melakukan verifikasi. Sistem akan secara otomatis mengalokasikan uang pembayaran ke invoice terkait dan memperbarui sisa piutang.
* **F-6.3 Alokasi Pembayaran**: Mendukung pembayaran sebagian (cicilan) dan pembayaran akumulasi (banyak invoice sekaligus).

### 2.7 Modul 7: Tiket Pemeliharaan (Maintenance Tickets)
* **F-7.1 Pengajuan Kerusakan (Resident)**: Penghuni mengirim aduan kerusakan (misal: AC rusak, wastafel bocor) beserta deskripsi, foto kerusakan, dan tingkat urgensi (Rendah/Sedang/Tinggi).
* **F-7.2 Pengelolaan Tiket (Owner/Manager)**: Pengelola menerima aduan, mengubah status tiket (`Pending`, `In Progress`, `Completed`), menentukan staff yang memperbaiki, serta mengupdate catatan biaya perbaikan jika ada.

### 2.8 Modul 8: Dashboard & Laporan (Dashboard & Reporting)
* **F-8.1 Dashboard Pemilik/Pengelola**: Occupancy rate, total omset pendapatan, total tunggakan piutang, daftar tagihan jatuh tempo, aduan perbaikan aktif.
* **F-8.2 Portal/Dashboard Penghuni**: Ringkasan tagihan yang belum dibayar, riwayat sewa (nomor kamar & kontrak aktif), daftar aduan perbaikan milik pribadi, dan riwayat konfirmasi pembayaran yang dikirimkan.
