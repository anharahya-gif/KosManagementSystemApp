# Entity Relationship Diagram (ERD)
## Kos Management System (KMS)

Berikut adalah diagram hubungan entitas (ERD) untuk sistem manajemen kos (KMS) yang mendukung multi-tenancy dan tiga peran utama: Pemilik (Owner), Pengelola (Manager), dan Penghuni (Resident).

```mermaid
erDiagram
    ORGANIZATIONS ||--o{ USER_PROFILES : "has"
    ORGANIZATIONS ||--o{ PROPERTIES : "owns"
    ORGANIZATIONS ||--o{ RESIDENTS : "manages"
    ORGANIZATIONS ||--o{ CONTRACTS : "manages"
    ORGANIZATIONS ||--o{ INVOICES : "issues"
    ORGANIZATIONS ||--o{ PAYMENTS : "receives"
    ORGANIZATIONS ||--o{ MAINTENANCE_TICKETS : "tracks"

    USER_PROFILES ||--o{ PROPERTY_MANAGERS : "assigned as"
    PROPERTIES ||--o{ PROPERTY_MANAGERS : "managed by"
    USER_PROFILES |o--o| RESIDENTS : "linked to"

    PROPERTIES ||--o{ ROOMS : "contains"
    ROOMS ||--o{ CONTRACTS : "rented in"
    RESIDENTS ||--o{ CONTRACTS : "signs"

    CONTRACTS ||--o{ INVOICES : "generates"
    PAYMENTS ||--o{ PAYMENT_ITEMS : "details"
    INVOICES ||--o{ PAYMENT_ITEMS : "settled by"
    
    RESIDENTS ||--o{ MAINTENANCE_TICKETS : "reports"
    ROOMS ||--o{ MAINTENANCE_TICKETS : "has issue in"
    
    ORGANIZATIONS {
        uuid id PK
        varchar name
        timestamp created_at
        timestamp updated_at
    }

    USER_PROFILES {
        uuid id PK "auth.users ref"
        uuid organization_id FK
        varchar full_name
        varchar role "owner | manager | resident"
        timestamp created_at
    }

    PROPERTIES {
        uuid id PK
        uuid organization_id FK
        varchar name
        text address
        varchar type "kos | kontrakan | apartment"
        timestamp created_at
    }

    PROPERTY_MANAGERS {
        uuid id PK
        uuid user_id FK "user_profiles.id"
        uuid property_id FK "properties.id"
        timestamp assigned_at
    }

    ROOMS {
        uuid id PK
        uuid property_id FK
        varchar room_number
        varchar building_name "optional"
        varchar floor_name "optional"
        numeric price_per_month
        varchar status "vacant | occupied | reserved | maintenance"
        timestamp created_at
    }

    RESIDENTS {
        uuid id PK
        uuid organization_id FK
        uuid user_id FK "user_profiles.id (nullable)"
        varchar full_name
        varchar phone_number
        varchar email "optional"
        varchar id_card_number "optional"
        varchar status "prospective | active | moved | checked_out | inactive"
        timestamp created_at
    }

    CONTRACTS {
        uuid id PK
        uuid organization_id FK
        uuid resident_id FK
        uuid room_id FK
        date start_date
        date end_date
        varchar billing_cycle "monthly | yearly"
        numeric price_per_cycle
        numeric deposit_amount
        varchar status "active | completed | terminated"
        timestamp created_at
    }

    INVOICES {
        uuid id PK
        uuid organization_id FK
        uuid contract_id FK
        varchar invoice_number "unique"
        date due_date
        numeric amount_due
        numeric amount_paid
        varchar status "unpaid | partially_paid | paid | overdue"
        timestamp created_at
    }

    PAYMENTS {
        uuid id PK
        uuid organization_id FK
        timestamp payment_date
        numeric amount
        varchar payment_method "transfer | cash"
        text proof_url "optional"
        boolean verified
        timestamp created_at
    }

    PAYMENT_ITEMS {
        uuid id PK
        uuid payment_id FK
        uuid invoice_id FK
        numeric amount_allocated
    }

    MAINTENANCE_TICKETS {
        uuid id PK
        uuid organization_id FK
        uuid resident_id FK
        uuid room_id FK
        varchar title
        text description
        varchar urgency "low | medium | high"
        varchar status "pending | in_progress | completed | cancelled"
        numeric cost "optional"
        timestamp created_at
    }
```

---

## Deskripsi Relasi Tambahan (Role Penghuni)

1. **Link Akun Penghuni (`user_profiles` <-> `residents`)**:
   - Kolom `user_id` di tabel `residents` bersifat nullable. Ketika penghuni mendaftar di portal aplikasi, akun penggunanya (`user_profiles` dengan role `resident`) dihubungkan ke record data `residents` yang sudah diinput oleh Manager. Ini mengamankan agar penghuni hanya dapat melihat data sewa mereka sendiri.
2. **Tiket Pemeliharaan (`maintenance_tickets`)**:
   - Menghubungkan langsung `residents` (pelapor) dan `rooms` (lokasi kerusakan) agar mempermudah pengelola melacak di kamar mana perbaikan harus dilakukan dan siapa yang harus dihubungi.
   - Biaya perbaikan (`cost`) bersifat opsional, dapat diinput oleh pengelola untuk diakumulasikan sebagai pengeluaran properti.
