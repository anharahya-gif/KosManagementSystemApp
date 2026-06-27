# Database Schema Specification
## Kos Management System (KMS)

Dokumen ini mendefinisikan skema database relasional secara detail. Skema ini dirancang agar kompatibel dengan **SQLite (via Drift)** untuk fase lokal-first Android, sekaligus mempermudah migrasi ke **PostgreSQL (Supabase/Cloud)** di masa mendatang.

---

## 1. Strategi Kompatibilitas SQLite & PostgreSQL

Untuk memastikan migrasi berjalan mulus tanpa merombak total kode aplikasi, aturan pemetaan tipe data berikut diterapkan:

| Tipe Data PostgreSQL | Representasi SQLite (Drift) | Penjelasan |
| :--- | :--- | :--- |
| `UUID` | `TEXT` | Disimpan sebagai string UUID standar (36 karakter). |
| `TIMESTAMP WITH TIME ZONE` | `TEXT` | Disimpan sebagai format string ISO 8601 (`YYYY-MM-DDTHH:MM:SS.SSSZ`). |
| `DATE` | `TEXT` | Disimpan sebagai string tanggal ISO 8601 (`YYYY-MM-DD`). |
| `NUMERIC(12, 2)` | `INTEGER` (Sen) / `REAL` | Disimpan sebagai nilai Sen (dikali 100) dalam tipe data Integer untuk mencegah floating-point inaccuracy di SQLite, atau menggunakan Drift TypeConverter ke double. |
| `BOOLEAN` | `INTEGER` | Disimpan sebagai `0` (false) atau `1` (true) sesuai standar SQLite. |

---

## 2. Definisi Tabel (DDL Specification)

### 2.1 Tabel `organizations`
Menyimpan entitas organisasi penyewa sistem (SaaS Tenant).
```sql
CREATE TABLE organizations (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    name TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    updated_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
);
```

### 2.2 Tabel `user_profiles`
Profil pengguna sistem dengan peran (role) Pemilik, Pengelola, atau Penghuni.
```sql
CREATE TABLE user_profiles (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    full_name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT NOT NULL, -- CHECK (role IN ('owner', 'manager', 'resident'))
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE
);
```

### 2.3 Tabel `properties`
Properti sewa yang dimiliki oleh organisasi.
```sql
CREATE TABLE properties (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    type TEXT NOT NULL, -- CHECK (type IN ('kos', 'kontrakan', 'apartment', 'guesthouse'))
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE
);
```

### 2.4 Tabel `property_managers`
Junction table untuk menugaskan Manager ke satu atau beberapa properti.
```sql
CREATE TABLE property_managers (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    user_id TEXT NOT NULL, -- FK to user_profiles.id
    property_id TEXT NOT NULL, -- FK to properties.id
    assigned_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (user_id) REFERENCES user_profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE,
    UNIQUE (user_id, property_id) -- Mencegah duplikasi penugasan
);
```

### 2.5 Tabel `rooms`
Kamar yang disewakan di bawah properti tertentu.
```sql
CREATE TABLE rooms (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    property_id TEXT NOT NULL, -- FK to properties.id
    room_number TEXT NOT NULL,
    building_name TEXT, -- Opsional, misal: 'Gedung A'
    floor_name TEXT, -- Opsional, misal: 'Lantai 1'
    price_per_month INTEGER NOT NULL, -- Harga sewa dalam satuan Sen (dikali 100)
    status TEXT NOT NULL DEFAULT 'vacant', -- CHECK (status IN ('vacant', 'occupied', 'reserved', 'maintenance', 'inactive'))
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);
```

### 2.6 Tabel `residents`
Profil penghuni beserta riwayat status siklus hidupnya. Terhubung ke akun user jika penghuni sudah mendaftar di portal.
```sql
CREATE TABLE residents (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    user_id TEXT, -- FK to user_profiles.id (Nullable, dihubungkan jika resident memiliki akun login)
    full_name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    email TEXT, -- Opsional
    id_card_number TEXT, -- No KTP/Passport (Opsional)
    status TEXT NOT NULL DEFAULT 'prospective', -- CHECK (status IN ('prospective', 'active', 'moved', 'checked_out', 'inactive'))
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user_profiles(id) ON DELETE SET NULL
);
```

### 2.7 Tabel `contracts`
Pusat relasi sewa yang mengikat Penghuni dan Kamar.
```sql
CREATE TABLE contracts (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    resident_id TEXT NOT NULL, -- FK to residents.id
    room_id TEXT NOT NULL, -- FK to rooms.id
    start_date TEXT NOT NULL, -- YYYY-MM-DD
    end_date TEXT NOT NULL, -- YYYY-MM-DD
    billing_cycle TEXT NOT NULL DEFAULT 'monthly', -- CHECK (billing_cycle IN ('monthly', 'yearly'))
    price_per_cycle INTEGER NOT NULL, -- Harga sewa dalam satuan Sen
    deposit_amount INTEGER NOT NULL DEFAULT 0, -- Uang deposit dalam satuan Sen
    status TEXT NOT NULL DEFAULT 'active', -- CHECK (status IN ('active', 'completed', 'terminated'))
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (resident_id) REFERENCES residents(id) ON DELETE RESTRICT,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE RESTRICT
);
```

### 2.8 Tabel `invoices`
Tagihan sewa yang dihitung otomatis berdasarkan Kontrak.
```sql
CREATE TABLE invoices (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    contract_id TEXT NOT NULL, -- FK to contracts.id
    invoice_number TEXT UNIQUE NOT NULL, -- Contoh: INV-202606-001
    due_date TEXT NOT NULL, -- YYYY-MM-DD
    amount_due INTEGER NOT NULL, -- Total tagihan (dalam Sen)
    amount_paid INTEGER NOT NULL DEFAULT 0, -- Total terbayar (dalam Sen)
    status TEXT NOT NULL DEFAULT 'unpaid', -- CHECK (status IN ('unpaid', 'partially_paid', 'paid', 'overdue'))
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (contract_id) REFERENCES contracts(id) ON DELETE RESTRICT
);
```

### 2.9 Tabel `payments`
Pencatatan uang masuk pembayaran tagihan. Mendukung status verifikasi oleh manager.
```sql
CREATE TABLE payments (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    payment_date TEXT NOT NULL, -- ISO 8601
    amount INTEGER NOT NULL, -- Nominal pembayaran (dalam Sen)
    payment_method TEXT NOT NULL, -- CHECK (payment_method IN ('transfer', 'cash', 'qris'))
    proof_url TEXT, -- Path file bukti transfer lokal di device
    verified INTEGER NOT NULL DEFAULT 0, -- Boolean: 0 = False, 1 = True
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE
);
```

### 2.10 Tabel `payment_items`
Alokasi pembagian dana pembayaran ke satu atau beberapa Invoice (Mendukung cicilan & akumulasi).
```sql
CREATE TABLE payment_items (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    payment_id TEXT NOT NULL, -- FK to payments.id
    invoice_id TEXT NOT NULL, -- FK to invoices.id
    amount_allocated INTEGER NOT NULL, -- Nominal alokasi (dalam Sen)
    FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE CASCADE,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE RESTRICT
);
```

### 2.11 Tabel `maintenance_tickets`
Mencatat aduan kerusakan fasilitas yang dilaporkan oleh penghuni dan dikelola oleh staff/manager.
```sql
CREATE TABLE maintenance_tickets (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL, -- FK to organizations.id
    resident_id TEXT NOT NULL, -- FK to residents.id (siapa pelapornya)
    room_id TEXT NOT NULL, -- FK to rooms.id (lokasi perbaikan)
    title TEXT NOT NULL, -- Judul aduan
    description TEXT NOT NULL, -- Detail kerusakan
    urgency TEXT NOT NULL DEFAULT 'medium', -- CHECK (urgency IN ('low', 'medium', 'high'))
    status TEXT NOT NULL DEFAULT 'pending', -- CHECK (status IN ('pending', 'in_progress', 'completed', 'cancelled'))
    cost INTEGER, -- Biaya perbaikan (dalam sen), opsional diisi pengelola saat selesai
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (resident_id) REFERENCES residents(id) ON DELETE RESTRICT,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE RESTRICT
);
```

### 2.12 Tabel `audit_logs`
Mencatat seluruh aktivitas perubahan penting untuk kebutuhan audit.
```sql
CREATE TABLE audit_logs (
    id TEXT PRIMARY KEY NOT NULL, -- UUID
    organization_id TEXT NOT NULL,
    user_id TEXT NOT NULL, -- Siapa yang melakukan (FK to user_profiles.id)
    action TEXT NOT NULL, -- Misal: 'CREATE_CONTRACT', 'PAY_INVOICE', 'CHANGE_ROOM'
    description TEXT NOT NULL, -- Penjelasan naratif detail
    ip_address TEXT, -- Kosong untuk SQLite offline
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user_profiles(id) ON DELETE RESTRICT
);
```

---

## 3. Indeks Database untuk Optimasi Query

Untuk mempercepat query SQLite saat data bertambah banyak, indeks berikut wajib dibuat:
1. `idx_rooms_property_id` pada tabel `rooms(property_id)`
2. `idx_contracts_resident_id` pada tabel `contracts(resident_id)`
3. `idx_contracts_room_id` pada tabel `contracts(room_id)`
4. `idx_invoices_contract_id` pada tabel `invoices(contract_id)`
5. `idx_payment_items_payment_id` pada tabel `payment_items(payment_id)`
6. `idx_payment_items_invoice_id` pada tabel `payment_items(invoice_id)`
7. `idx_property_managers_user_id` on `property_managers(user_id)`
8. `idx_maintenance_tickets_resident_id` on `maintenance_tickets(resident_id)`
9. `idx_maintenance_tickets_room_id` on `maintenance_tickets(room_id)`
