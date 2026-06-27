# Usecase Specification
## Kos Management System (KMS)

Dokumen ini menjelaskan diagram usecase dan spesifikasi detail dari setiap usecase utama pada sistem KMS dengan mendukung tiga peran: **Pemilik (Owner)**, **Pengelola (Manager)**, dan **Penghuni (Resident)**.

---

## 1. Diagram Usecase

```mermaid
left_to_right_direction
actor "Pemilik (Owner)" as Owner
actor "Pengelola (Manager)" as Manager
actor "Penghuni (Resident)" as Resident

rectangle "Kos Management System (KMS)" {
    %% Usecase untuk Pengelola / Owner
    usecase "UC-01: Switch Profile / Login" as UC01
    usecase "UC-02: Kelola Organisasi" as UC02
    usecase "UC-03: Kelola Akun Manager" as UC03
    usecase "UC-04: Kelola Properti" as UC04
    usecase "UC-05: Kelola Kamar" as UC05
    usecase "UC-06: Kelola Penghuni" as UC06
    usecase "UC-07: Buat Kontrak Baru" as UC07
    usecase "UC-08: Pindah Kamar" as UC08
    usecase "UC-09: Perpanjangan Kontrak" as UC09
    usecase "UC-10: Verifikasi Pembayaran & Cicilan" as UC10
    usecase "UC-11: Lihat Laporan & Dashboard" as UC11
    
    %% Usecase khusus Penghuni (Resident Portal)
    usecase "UC-12: Lihat Tagihan & Sewa Mandiri" as UC12
    usecase "UC-13: Kirim Konfirmasi Pembayaran" as UC13
    usecase "UC-14: Buat Aduan Perbaikan (Maintenance)" as UC14
    usecase "UC-15: Lihat Status Tiket Perbaikan" as UC15
}

%% Hubungan Aktor Owner
Owner --> UC01
Owner --> UC02
Owner --> UC03
Owner --> UC04
Owner --> UC05
Owner --> UC06
Owner --> UC07
Owner --> UC08
Owner --> UC09
Owner --> UC10
Owner --> UC11

%% Hubungan Aktor Manager
Manager --> UC01
Manager --> UC05
Manager --> UC06
Manager --> UC07
Manager --> UC08
Manager --> UC09
Manager --> UC10
Manager --> UC11

%% Hubungan Aktor Resident
Resident --> UC01
Resident --> UC12
Resident --> UC13
Resident --> UC14
Resident --> UC15
```

---

## 2. Spesifikasi Usecase Utama (Tambahan untuk Penghuni)

### UC-12: Lihat Tagihan & Sewa Mandiri
* **Deskripsi**: Memungkinkan Penghuni melihat rincian kamar yang ia sewa, kontrak aktif, riwayat invoice (yang lunas maupun tertunggak), serta riwayat pembayaran yang terverifikasi.
* **Aktor**: Penghuni.
* **Alur Utama**:
  1. Penghuni masuk ke Portal Aplikasi.
  2. Aplikasi memuat profil penghuni yang terhubung ke akun user tersebut.
  3. Aplikasi menampilkan informasi kamar saat ini, tanggal jatuh tempo berikutnya, dan daftar invoice aktif beserta sisa tagihannya.

### UC-13: Kirim Konfirmasi Pembayaran
* **Deskripsi**: Memungkinkan Penghuni mengunggah bukti pembayaran transfer agar diverifikasi oleh Manager/Owner.
* **Aktor**: Penghuni.
* **Alur Utama**:
  1. Penghuni membuka halaman tagihan (invoice) yang belum lunas.
  2. Penghuni memilih satu atau beberapa invoice yang ingin dikonfirmasi bayar.
  3. Penghuni menginput nominal transfer, tanggal pembayaran, dan mengunggah foto bukti transfer.
  4. Penghuni mengirim data.
  5. **Sistem secara otomatis**:
     - Membuat record pembayaran baru dengan status `verified = 0` (Belum diverifikasi).
     - Menghubungkan record tersebut ke invoice terkait di tabel detail.
     - Mengirimkan alert notifikasi ke Manager/Owner properti bahwa ada pembayaran baru yang menunggu verifikasi.

### UC-14: Buat Aduan Perbaikan (Maintenance)
* **Deskripsi**: Memungkinkan Penghuni melaporkan kerusakan fasilitas di kamar atau areanya untuk segera ditangani.
* **Aktor**: Penghuni.
* **Alur Utama**:
  1. Penghuni membuka menu "Aduan Perbaikan".
  2. Penghuni menginput judul masalah (misal: "Keran Bocor"), detail deskripsi, tingkat urgensi, serta mengunggah foto kerusakan.
  3. Penghuni mengirim laporan aduan.
  4. **Sistem secara otomatis**:
     - Membuat tiket perbaikan baru dikaitkan dengan ID Resident dan ID Kamar aktifnya.
     - Mengubah status tiket menjadi `Pending`.
     - Mengirimkan alert aduan baru ke Dashboard Manager/Owner.

### UC-15: Lihat Status Tiket Perbaikan
* **Deskripsi**: Memungkinkan Penghuni memantau progress penanganan kerusakan yang dia laporkan.
* **Aktor**: Penghuni.
* **Alur Utama**:
  1. Penghuni membuka daftar aduan perbaikannya.
  2. Sistem menampilkan progress status dari tiket-tiket tersebut:
     - `Pending`: Baru diajukan.
     - `In Progress`: Staff perbaikan telah ditugaskan dan pengerjaan sedang berjalan.
     - `Completed`: Kerusakan telah diperbaiki dan diverifikasi selesai.
     - `Cancelled`: Aduan dibatalkan (disertai alasan dari pengelola).
