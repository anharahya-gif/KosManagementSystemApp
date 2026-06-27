# Development Plan & Roadmap
## Kos Management System (KMS)

Dokumen ini merinci rencana pengembangan sistem KMS yang dibagi ke dalam **Fase 1 (MVP)** dan **Fase 2 (Resident Portal & Maintenance Expansion)** menggunakan database lokal SQLite (Drift) dan Flutter.

---

## FASE 1: Core System & Pengelolaan (Owner & Manager)

**Tujuan**: Membangun fondasi sistem Clean Architecture, database lokal Drift (SQLite), simulasi multi-role, serta seluruh modul utama untuk mengelola properti, kamar, kontrak, tagihan otomatis, dan pencatatan pembayaran langsung oleh Owner/Manager.

### Paket Kerja Fase 1

#### 1. Inisialisasi & Arsitektur Core
* **Aktivitas**:
  - Inisialisasi project Flutter baru.
  - Setup struktur folder Clean Architecture (`core/`, `features/`).
  - Desain sistem tema (Premium Dark Mode & Light Mode, font modern Google Fonts, Glassmorphism UI elements).
  - Setup Drift Database: mendefinisikan seluruh tabel dasar (`organizations`, `user_profiles`, `properties`, `rooms`, `residents`, `contracts`, `invoices`, `payments`, `payment_items`, `audit_logs`).
  - Menyiapkan generator database (`build_runner`).

#### 2. Autentikasi & Simulasi Multi-Role (Lokal)
* **Aktivitas**:
  - Membuat dev-drawer / menu switch profil di dalam aplikasi.
  - Seeding data awal otomatis (1 Organisasi, 1 Profil Owner, 2 Profil Manager, 2 Properti) agar aplikasi langsung bisa diuji tanpa input manual dari awal.
  - Implementasi pembatasan data (SaaS Tenant-Scoping) di level repository menggunakan `organization_id` dan penugasan properti untuk Manager.

#### 3. Manajemen Properti & Kamar (Owner & Manager)
* **Aktivitas**:
  - **Screen Kelola Properti (Owner)**: Tambah, edit, dan hapus properti.
  - **Screen Penugasan Manager (Owner)**: Menghubungkan akun Manager ke properti tertentu.
  - **Screen Kelola Kamar (Owner & Manager)**: Tambah, edit kamar (pengaturan nomor kamar, harga sewa bulanan, gedung/lantai).
  - **Status Kamar Dinamis**: Implementasi logika perubahan status kamar otomatis (`vacant` / `occupied` / `maintenance`).

#### 4. Manajemen Penghuni & Kontrak (Domain Utama)
* **Aktivitas**:
  - **Screen Profil Penghuni**: Pendaftaran data calon penghuni baru.
  - **Screen Kontrak Sewa Baru**: Form pembuatan kontrak sewa (memilih kamar vacant, penghuni, tanggal mulai/berakhir, deposit, harga).
  - **Domain Logic (Trigger)**:
    - Saat kontrak disimpan, status kamar ter-update otomatis menjadi `Occupied`.
    - Status penghuni berubah menjadi `Active`.
    - Sistem menghitung jadwal penagihan dan men-generate data `invoices` awal otomatis sesuai tanggal kontrak.
  - **Screen Ganti Kamar (Change Room)**: Form memindahkan penghuni ke kamar vacant lain di tengah masa sewa dengan mencatat log perpindahan tanpa merusak histori kontrak/invoice.
  - **Screen Perpanjangan Kontrak (Renewal)**: Form perpanjangan masa sewa kontrak.

#### 5. Sistem Invoice & Pembayaran (Finansial)
* **Aktivitas**:
  - **Screen Daftar Tagihan (Invoices)**: Menampilkan tagihan tertunggak, jatuh tempo, cicilan, dan lunas.
  - **Screen Catat Pembayaran**: Form pencatatan uang masuk oleh pengelola.
  - **Logika Alokasi Pembayaran**:
    - **Cicilan**: Jika uang kurang, status invoice terupdate menjadi `partially_paid` dan piutang otomatis berkurang.
    - **Akumulasi**: Jika bayar lebih/sekaligus, dana dialokasikan otomatis dari invoice terlama hingga terbaru.
  - **Logika Deposit**: Pengembalian uang jaminan saat check-out, atau pemotongan deposit untuk denda/tunggakan sewa.

#### 6. Dashboard & Laporan Keuangan (Owner & Manager)
* **Aktivitas**:
  - **Visualisasi Metrik**: Occupancy rate, pendapatan berjalan, sisa piutang outstanding, kamar kosong.
  - **Filter Hak Akses**: Owner dapat melihat grafik konsol semua properti. Manager hanya dapat melihat statistik properti yang ditugaskan kepadanya.

---

## FASE 2: Portal Penghuni & Ekspansi Pemeliharaan (Resident & Maintenance)

**Tujuan**: Membuka akses interaksi mandiri bagi Penghuni (Resident Portal) untuk melakukan konfirmasi bukti transfer pembayaran, melaporkan kerusakan kamar (maintenance tickets), serta menyajikan laporan keuangan lanjutan bagi Owner/Manager.

### Paket Kerja Fase 2

#### 1. Portal & Autentikasi Penghuni (Resident Portal)
* **Aktivitas**:
  - Membuat alur registrasi mandiri bagi Penghuni untuk menghubungkan akun loginnya ke record `residents` yang diinput pengelola (validasi via email/nomor HP).
  - Merancang UI dashboard khusus Penghuni yang bersih dan informatif (melihat detail sewa aktif, sisa deposit, tagihan jatuh tempo terdekat).

#### 2. Konfirmasi Pembayaran Mandiri (Self-Service Confirmation)
* **Aktivitas**:
  - **Screen Konfirmasi Bayar (Resident)**: Penghuni dapat memilih invoice yang ingin dibayar, mengisi tanggal bayar, nominal transfer, nama bank pengirim, dan mengunggah foto bukti transfer. Status pembayaran tersimpan sebagai `unverified`.
  - **Screen Verifikasi Pembayaran (Manager/Owner)**: Dashboard untuk mengelola antrean bukti transfer masuk. Pengelola memvalidasi kesesuaian data dengan mutasi bank asli, lalu melakukan approval/rejection.
  - **Logika Approval**: Jika disetujui, status record pembayaran berubah menjadi `verified`, invoice terkait ter-update menjadi `paid` / `partially_paid`, dan total piutang disesuaikan secara otomatis.

#### 3. Tiket Pemeliharaan Kamar (Maintenance & Repair Tickets)
* **Aktivitas**:
  - **Screen Ajukan Tiket (Resident)**: Form pengaduan kerusakan di kamar (judul masalah, detail deskripsi, tingkat urgensi `low`/`medium`/`high`, dan upload foto kerusakan).
  - **Screen Kelola Tiket (Manager/Owner)**: Daftar aduan kerusakan kamar terurut berdasarkan tingkat urgensi. Pengelola dapat menetapkan staff perbaikan, mengubah status progress kerja (`pending` -> `in_progress` -> `completed` / `cancelled`), serta mencatat nominal biaya perbaikan.
  - **Domain Logic (Status Kamar)**: Kamar yang memiliki aduan kategori kritis otomatis dapat ditandai berstatus `Maintenance` di database.

#### 4. Laporan Aging Piutang (Accounts Receivable Aging Report)
* **Aktivitas**:
  - Menyajikan data tunggakan piutang dalam kategori umur piutang (Aging): belum jatuh tempo, tunggakan 1-30 hari, 31-60 hari, 61-90 hari, dan di atas 90 hari.
  - Fitur ini krusial bagi Owner untuk melacak kesehatan cash flow organisasi.

#### 5. Sistem Notifikasi Pengingat (Reminder Notifications)
* **Aktivitas**:
  - Notifikasi lokal di perangkat handphone untuk:
    - Penghuni: Pengingat tagihan sewa H-3 jatuh tempo, alert aduan perbaikan telah diselesaikan.
    - Pengelola: Alert kontrak penghuni akan segera berakhir dalam 30 hari, alert aduan kerusakan baru dari kamar.
