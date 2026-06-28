enum PropertyExpenseCategory {
  electricity,
  wifi,
  water,
  other;

  static PropertyExpenseCategory fromString(String value) {
    switch (value) {
      case 'electricity':
        return PropertyExpenseCategory.electricity;
      case 'wifi':
        return PropertyExpenseCategory.wifi;
      case 'water':
        return PropertyExpenseCategory.water;
      case 'other':
      default:
        return PropertyExpenseCategory.other;
    }
  }

  String toDbValue() {
    switch (this) {
      case PropertyExpenseCategory.electricity:
        return 'electricity';
      case PropertyExpenseCategory.wifi:
        return 'wifi';
      case PropertyExpenseCategory.water:
        return 'water';
      case PropertyExpenseCategory.other:
      default:
        return 'other';
    }
  }

  String toReadableString() {
    switch (this) {
      case PropertyExpenseCategory.electricity:
        return 'Listrik';
      case PropertyExpenseCategory.wifi:
        return 'Wifi / Internet';
      case PropertyExpenseCategory.water:
        return 'Air';
      case PropertyExpenseCategory.other:
      default:
        return 'Lain-Lain';
    }
  }
}

class PropertyExpenseEntity {
  final String id;
  final String propertyId;
  final String name;
  final PropertyExpenseCategory category;
  final double amount; // in Rupiah
  final DateTime expenseDate;
  final DateTime createdAt;

  const PropertyExpenseEntity({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.category,
    required this.amount,
    required this.expenseDate,
    required this.createdAt,
  });
}
