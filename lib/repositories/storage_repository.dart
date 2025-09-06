import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/storage_info.dart';

class StorageRepository {
  static const String _storageKey = 'storage_info';
  static const String _isFirstTimeKey = 'is_first_time';

  // Get storage information
  Future<StorageInfo> getStorageInfo() async {
    try {
      // Simulate getting storage info from device
      // In a real app, you would use platform channels or native code
      await Future.delayed(const Duration(milliseconds: 500));

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
    } catch (e) {
      // Log error and return default values
      print('Error getting storage info: $e');
      return StorageInfo(
        usedGB: 0,
        totalGB: 128,
        usedPercentage: 0.0,
        categoryUsage: {},
      );
    }
  }

  // Save storage info to local storage
  Future<void> saveStorageInfo(StorageInfo storageInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(storageInfo.toJson());
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save storage info: $e');
    }
  }

  // Load storage info from local storage
  Future<StorageInfo?> loadStorageInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return StorageInfo.fromJson(json);
    } catch (e) {
      print('Error loading storage info: $e');
      return null;
    }
  }

  // Check if it's the first time opening the app
  Future<bool> isFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isFirstTimeKey) ?? true;
    } catch (e) {
      return true;
    }
  }

  // Mark app as not first time
  Future<void> markAsNotFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isFirstTimeKey, false);
    } catch (e) {
      print('Error marking as not first time: $e');
    }
  }

  // Simulate duplicate photos scan
  Future<int> scanDuplicatePhotos() async {
    try {
      // Simulate scanning process
      await Future.delayed(const Duration(seconds: 2));
      return 42; // Return number of duplicates found
    } catch (e) {
      return 0;
    }
  }

  // Simulate email cleaning
  Future<int> getSpamEmailCount() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return 6524; // Return number of spam emails
    } catch (e) {
      return 0;
    }
  }
}
