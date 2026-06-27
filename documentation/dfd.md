# Data Flow Diagram (DFD)
## Kos Management System (KMS)

Dokumen ini memetakan aliran data pada sistem manajemen kos (KMS) dari level konteks (Level 0) hingga diagram aliran data level 1 yang mendukung peran Pemilik, Pengelola, dan Penghuni.

---

## 1. DFD Level 0 (Context Diagram)

Context diagram menunjukkan interaksi sistem KMS secara keseluruhan dengan entitas luar, yaitu **Pemilik (Owner)**, **Pengelola (Manager)**, dan **Penghuni (Resident)**.

```mermaid
graph TD
    Owner[Pemilik - Owner]
    Manager[Pengelola - Manager]
    Resident[Penghuni - Resident]
    System((Kos Management System - KMS))
    
    %% Aliran Data Owner
    Owner -->|1. Setup Org & Properti<br>2. Kelola Akses Manager<br>3. Monitor Laporan Keuangan| System
    System -->|1. Laporan Finansial Konsolidasi<br>2. Log Aktivitas Organisasi| Owner

    %% Aliran Data Manager
    Manager -->|1. Kelola Kamar & Penghuni<br>2. Buat Kontrak Sewa<br>3. Verifikasi Pembayaran<br>4. Kelola Perbaikan Kamar| System
    System -->|1. Status Kamar & Tagihan Jatuh Tempo<br>2. Alert Konfirmasi Bayar Masuk<br>3. Alert Aduan Baru| Manager

    %% Aliran Data Resident
    Resident -->|1. Kirim Konfirmasi Bayar & Foto Bukti<br>2. Kirim Aduan Kerusakan Kamar| System
    System -->|1. Detail Invoice Tagihan & Riwayat Kontrak<br>2. Status Tiket Perbaikan<br>3. Notifikasi Pengumuman| Resident
```

---

## 2. DFD Level 1 (Process Breakdown)

Diagram ini merinci proses internal sistem KMS ke dalam beberapa modul utama beserta aliran datanya ke media penyimpanan (Database SQLite).

```mermaid
graph TD
    %% Entitas Luar
    Owner[Pemilik / Owner]
    Manager[Pengelola / Manager]
    Resident[Penghuni / Resident]

    %% Proses-Proses Utama
    P1((1.0 Auth &<br>Akses Pengguna))
    P2((2.0 Kelola Properti<br>& Kamar))
    P3((3.0 Kelola Kontrak<br>& Penghuni))
    P4((4.0 Generate Invoice<br>Otomatis))
    P5((5.0 Proses Pembayaran<br>& Piutang))
    P6((6.0 Laporan & Dashboard))
    P7((7.0 Tiket Pemeliharaan<br>& Perbaikan))

    %% Data Stores
    D1[(D1: User & Tenant Profiles)]
    D2[(D2: Properties & Rooms)]
    D3[(D3: Residents & Contracts)]
    D4[(D4: Invoices)]
    D5[(D5: Payments & Items)]
    D6[(D6: Maintenance Tickets)]

    %% Aliran Data Proses 1.0 (Auth)
    Owner -->|Input Profil Manager| P1
    Resident -->|Pendaftaran Akun Penghuni| P1
    P1 -->|Simpan Profil User| D1
    Manager -->|Login / Switch Profil| P1
    Resident -->|Login / Switch Profil| P1
    P1 -->|Kirim Hak Akses & Profil Terhubung| D1

    %% Aliran Data Proses 2.0 (Property & Room)
    Owner -->|Input Properti Baru| P2
    Manager -->|Update Status Kamar| P2
    P2 -->|Simpan data Properti/Kamar| D2

    %% Aliran Data Proses 3.0 (Contract & Resident)
    Manager -->|Buat Kontrak Baru| P3
    P3 -->|Simpan Penghuni/Kontrak| D3
    P3 -->|Update Kamar -> Occupied| D2
    P3 -->|Trigger Tagihan Awal| P4

    %% Aliran Data Proses 4.0 (Billing)
    D3 -->|Baca Parameter Sewa Kontrak| P4
    P4 -->|Simpan Invoice Otomatis| D4

    %% Aliran Data Proses 5.0 (Payment)
    Resident -->|Kirim Konfirmasi Bayar & Bukti| P5
    Manager -->|Verifikasi & Catat Pembayaran| P5
    P5 -->|Baca Invoice Tertunggak| D4
    P5 -->|Simpan Pembayaran & Alokasi Cicilan| D5
    P5 -->|Update Sisa Tagihan & Status Invoice| D4

    %% Aliran Data Proses 6.0 (Dashboard & Reports)
    D2 -.->|Baca Okupansi Kamar| P6
    D4 -.->|Baca Piutang Outstanding| P6
    D5 -.->|Baca Pendapatan Finansial| P6
    P6 -->|Kirim Laporan Konsolidasi| Owner
    P6 -->|Kirim Laporan Properti Terfilter| Manager
    P6 -->|Kirim Detail Tagihan & Riwayat| Resident

    %% Aliran Data Proses 7.0 (Maintenance)
    Resident -->|Input Aduan Kerusakan Kamar| P7
    Manager -->|Update Status Kerja & Input Biaya| P7
    P7 -->|Simpan Tiket Perbaikan| D6
    P7 -.->|Update Status Kamar -> Maintenance| D2
```
