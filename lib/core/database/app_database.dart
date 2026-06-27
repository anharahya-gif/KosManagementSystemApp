import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// 1. Organizations Table
class Organizations extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 2. User Profiles Table
class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get email => text()();
  TextColumn get role => text()(); // 'owner', 'manager', 'resident'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. Properties Table
class Properties extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get type => text()(); // 'kos', 'kontrakan', 'apartment', 'guesthouse'
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 4. Property Managers Junction Table
class PropertyManagers extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(UserProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get propertyId => text().references(Properties, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get assignedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 5. Rooms Table
class Rooms extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id, onDelete: KeyAction.cascade)();
  TextColumn get roomNumber => text()();
  TextColumn get buildingName => text().nullable()();
  TextColumn get floorName => text().nullable()();
  IntColumn get pricePerMonth => integer()(); // in Cents
  TextColumn get status => text().withDefault(const Constant('vacant'))(); // 'vacant', 'occupied', 'reserved', 'maintenance', 'inactive'
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 6. Residents Table
class Residents extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().nullable().references(UserProfiles, #id, onDelete: KeyAction.setNull)();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get email => text().nullable()();
  TextColumn get idCardNumber => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('prospective'))(); // 'prospective', 'active', 'moved', 'checked_out', 'inactive'
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 7. Contracts Table
class Contracts extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get residentId => text().references(Residents, #id, onDelete: KeyAction.restrict)();
  TextColumn get roomId => text().references(Rooms, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get billingCycle => text().withDefault(const Constant('monthly'))(); // 'monthly', 'yearly'
  IntColumn get pricePerCycle => integer()(); // in Cents
  IntColumn get depositAmount => integer().withDefault(const Constant(0))(); // in Cents
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'completed', 'terminated'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 8. Invoices Table
class Invoices extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get contractId => text().references(Contracts, #id, onDelete: KeyAction.restrict)();
  TextColumn get invoiceNumber => text().customConstraint('UNIQUE NOT NULL')();
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get amountDue => integer()(); // in Cents
  IntColumn get amountPaid => integer().withDefault(const Constant(0))(); // in Cents
  TextColumn get status => text().withDefault(const Constant('unpaid'))(); // 'unpaid', 'partially_paid', 'paid', 'overdue'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 9. Payments Table
class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get paymentDate => dateTime().withDefault(currentDateAndTime)();
  IntColumn get amount => integer()(); // in Cents
  TextColumn get paymentMethod => text()(); // 'transfer', 'cash', 'qris'
  TextColumn get proofUrl => text().nullable()();
  BoolColumn get verified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 10. Payment Items Table
class PaymentItems extends Table {
  TextColumn get id => text()();
  TextColumn get paymentId => text().references(Payments, #id, onDelete: KeyAction.cascade)();
  TextColumn get invoiceId => text().references(Invoices, #id, onDelete: KeyAction.restrict)();
  IntColumn get amountAllocated => integer()(); // in Cents

  @override
  Set<Column> get primaryKey => {id};
}

// 11. Maintenance Tickets Table
class MaintenanceTickets extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get residentId => text().references(Residents, #id, onDelete: KeyAction.restrict)();
  TextColumn get roomId => text().references(Rooms, #id, onDelete: KeyAction.restrict)();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get urgency => text().withDefault(const Constant('medium'))(); // 'low', 'medium', 'high'
  TextColumn get status => text().withDefault(const Constant('pending'))(); // 'pending', 'in_progress', 'completed', 'cancelled'
  IntColumn get cost => integer().nullable()(); // in Cents
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 12. Audit Logs Table
class AuditLogs extends Table {
  TextColumn get id => text()();
  TextColumn get organizationId => text().references(Organizations, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().references(UserProfiles, #id, onDelete: KeyAction.restrict)();
  TextColumn get action => text()(); // 'CREATE_CONTRACT', 'PAY_INVOICE', 'CHANGE_ROOM', etc.
  TextColumn get description => text()();
  TextColumn get ipAddress => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 13. App Database Class
@DriftDatabase(tables: [
  Organizations,
  UserProfiles,
  Properties,
  PropertyManagers,
  Rooms,
  Residents,
  Contracts,
  Invoices,
  Payments,
  PaymentItems,
  MaintenanceTickets,
  AuditLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Recreate database tables on schema change during development
          final tables = [
            'organizations',
            'user_profiles',
            'properties',
            'property_managers',
            'rooms',
            'residents',
            'contracts',
            'invoices',
            'payments',
            'payment_items',
            'maintenance_tickets',
            'audit_logs',
          ];
          for (final table in tables) {
            await m.deleteTable(table);
          }
          await m.createAll();
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'kms_database.db'));
    return NativeDatabase.createInBackground(file);
  });
}
