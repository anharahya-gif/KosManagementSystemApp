import 'package:drift/drift.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:uuid/uuid.dart';

class DbSeeder {
  static Future<void> seed(AppDatabase db) async {
    // 1. Cek apakah database sudah memiliki organisasi
    final orgs = await db.select(db.organizations).get();
    if (orgs.isNotEmpty) {
      return; // Sudah di-seed sebelumnya
    }

    const uuid = Uuid();
    final orgId = uuid.v4();

    // A. Seed Organisasi
    await db.into(db.organizations).insert(
          OrganizationsCompanion.insert(
            id: orgId,
            name: 'KMS Pratama Properti',
          ),
        );

    // B. Seed User Profiles (Owner & Managers)
    final ownerId = uuid.v4();
    final mgr1Id = uuid.v4();
    final mgr2Id = uuid.v4();

    await db.into(db.userProfiles).insert(
          UserProfilesCompanion.insert(
            id: ownerId,
            organizationId: orgId,
            fullName: 'Anhar Ahya (Owner)',
            phoneNumber: '081122334455',
            email: 'owner@kosms.com',
            role: 'owner',
          ),
        );

    await db.into(db.userProfiles).insert(
          UserProfilesCompanion.insert(
            id: mgr1Id,
            organizationId: orgId,
            fullName: 'Budi Hartono (Manager Kos Mawar)',
            phoneNumber: '085566778899',
            email: 'budi@kosms.com',
            role: 'manager',
          ),
        );

    await db.into(db.userProfiles).insert(
          UserProfilesCompanion.insert(
            id: mgr2Id,
            organizationId: orgId,
            fullName: 'Siti Rahma (Manager Paviliun Flamboyan)',
            phoneNumber: '089988776655',
            email: 'siti@kosms.com',
            role: 'manager',
          ),
        );

    // C. Seed Properti
    final prop1Id = uuid.v4();
    final prop2Id = uuid.v4();

    await db.into(db.properties).insert(
          PropertiesCompanion.insert(
            id: prop1Id,
            organizationId: orgId,
            name: 'Kos Mawar Indah',
            address: 'Jl. Melati No. 12, Jakarta Selatan',
            type: 'kos',
          ),
        );

    await db.into(db.properties).insert(
          PropertiesCompanion.insert(
            id: prop2Id,
            organizationId: orgId,
            name: 'Paviliun Flamboyan',
            address: 'Jl. Flamboyan Raya No. 45, Bandung',
            type: 'apartment',
          ),
        );

    // D. Seed Penugasan Manager (Property Managers)
    await db.into(db.propertyManagers).insert(
          PropertyManagersCompanion.insert(
            id: uuid.v4(),
            userId: mgr1Id,
            propertyId: prop1Id,
          ),
        );

    await db.into(db.propertyManagers).insert(
          PropertyManagersCompanion.insert(
            id: uuid.v4(),
            userId: mgr2Id,
            propertyId: prop2Id,
          ),
        );

    // E. Seed Kamar
    // Kamar Properti 1 (Kos Mawar Indah)
    final room101Id = uuid.v4();
    final room102Id = uuid.v4();
    final room103Id = uuid.v4();

    await db.into(db.rooms).insert(
          RoomsCompanion.insert(
            id: room101Id,
            propertyId: prop1Id,
            roomNumber: 'Kamar 101',
            buildingName: const Value('Gedung A'),
            floorName: const Value('Lantai 1'),
            pricePerMonth: 150000000, // Rp 1.500.000 (Stored in Cents)
            status: const Value('vacant'),
          ),
        );

    await db.into(db.rooms).insert(
          RoomsCompanion.insert(
            id: room102Id,
            propertyId: prop1Id,
            roomNumber: 'Kamar 102',
            buildingName: const Value('Gedung A'),
            floorName: const Value('Lantai 1'),
            pricePerMonth: 150000000,
            status: const Value('vacant'),
          ),
        );

    await db.into(db.rooms).insert(
          RoomsCompanion.insert(
            id: room103Id,
            propertyId: prop1Id,
            roomNumber: 'Kamar 201',
            buildingName: const Value('Gedung A'),
            floorName: const Value('Lantai 2'),
            pricePerMonth: 175000000, // Rp 1.750.000
            status: const Value('vacant'),
          ),
        );

    // Kamar Properti 2 (Paviliun Flamboyan)
    final roomPav1Id = uuid.v4();
    final roomPav2Id = uuid.v4();

    await db.into(db.rooms).insert(
          RoomsCompanion.insert(
            id: roomPav1Id,
            propertyId: prop2Id,
            roomNumber: 'Paviliun 01',
            buildingName: const Value('Utama'),
            floorName: const Value('Lantai 1'),
            pricePerMonth: 250000000, // Rp 2.500.000
            status: const Value('vacant'),
          ),
        );

    await db.into(db.rooms).insert(
          RoomsCompanion.insert(
            id: roomPav2Id,
            propertyId: prop2Id,
            roomNumber: 'Paviliun 02',
            buildingName: const Value('Utama'),
            floorName: const Value('Lantai 1'),
            pricePerMonth: 250000000,
            status: const Value('vacant'),
          ),
        );

    // F. Seed Residents (Calon Penghuni Awal)
    final res1Id = uuid.v4();
    final res2Id = uuid.v4();

    await db.into(db.residents).insert(
          ResidentsCompanion.insert(
            id: res1Id,
            organizationId: orgId,
            fullName: 'Rian Hidayat',
            phoneNumber: '081234567890',
            email: const Value('rian.hidayat@gmail.com'),
            idCardNumber: const Value('3201234567890001'),
            status: const Value('prospective'),
          ),
        );

    await db.into(db.residents).insert(
          ResidentsCompanion.insert(
            id: res2Id,
            organizationId: orgId,
            fullName: 'Dewi Lestari',
            phoneNumber: '089876543210',
            email: const Value('dewi.lestari@yahoo.com'),
            idCardNumber: const Value('3209876543210002'),
            status: const Value('prospective'),
          ),
        );
  }
}
