class StorageInfo {
  final int usedGB;
  final int totalGB;
  final double usedPercentage;
  final Map<String, int> categoryUsage;

  StorageInfo({
    required this.usedGB,
    required this.totalGB,
    required this.usedPercentage,
    required this.categoryUsage,
  }) {
    // Validate data in constructor
    if (usedGB < 0) throw ArgumentError('Used GB cannot be negative');
    if (totalGB <= 0) throw ArgumentError('Total GB must be positive');
    if (usedPercentage < 0 || usedPercentage > 1) {
      throw ArgumentError('Used percentage must be between 0 and 1');
    }
  }

  // Validation getter
  bool get isValid =>
      usedGB >= 0 &&
      totalGB > 0 &&
      usedPercentage >= 0 &&
      usedPercentage <= 1 &&
      usedGB <= totalGB;

  // Get available space
  int get availableGB => totalGB - usedGB;

  // Get available percentage
  double get availablePercentage => 1.0 - usedPercentage;

  factory StorageInfo.fromJson(Map<String, dynamic> json) {
    return StorageInfo(
      usedGB: json['usedGB'] ?? 0,
      totalGB: json['totalGB'] ?? 128,
      usedPercentage: (json['usedPercentage'] ?? 0.0).toDouble(),
      categoryUsage: Map<String, int>.from(json['categoryUsage'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usedGB': usedGB,
      'totalGB': totalGB,
      'usedPercentage': usedPercentage,
      'categoryUsage': categoryUsage,
    };
  }

  // Factory for mock data
  factory StorageInfo.mock() {
    return StorageInfo(
      usedGB: 7,
      totalGB: 128,
      usedPercentage: 7 / 128,
      categoryUsage: {
        'Apps': 3,
        'DC': 2,
        'Media': 1,
        'System Data': 1,
        'Unused': 0,
      },
    );
  }

  StorageInfo copyWith({
    int? usedGB,
    int? totalGB,
    double? usedPercentage,
    Map<String, int>? categoryUsage,
  }) {
    return StorageInfo(
      usedGB: usedGB ?? this.usedGB,
      totalGB: totalGB ?? this.totalGB,
      usedPercentage: usedPercentage ?? this.usedPercentage,
      categoryUsage: categoryUsage ?? this.categoryUsage,
    );
  }

  @override
  String toString() {
    return 'StorageInfo(usedGB: $usedGB, totalGB: $totalGB, usedPercentage: ${(usedPercentage * 100).toStringAsFixed(1)}%, availableGB: $availableGB)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StorageInfo &&
        other.usedGB == usedGB &&
        other.totalGB == totalGB &&
        other.usedPercentage == usedPercentage &&
        _mapEquals(other.categoryUsage, categoryUsage);
  }

  @override
  int get hashCode {
    return usedGB.hashCode ^
        totalGB.hashCode ^
        usedPercentage.hashCode ^
        categoryUsage.hashCode;
  }

  bool _mapEquals(Map<String, int>? a, Map<String, int>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}
