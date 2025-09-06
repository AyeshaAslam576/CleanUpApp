import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SecureStorageService {
  static const String _pinKey = 'user_pin_hash';
  static const String _patternKey = 'user_pattern';
  static const String _biometricEnabledKey = 'biometric_enabled';

  // Hash PIN for storage (basic security - in production use proper encryption)
  String _hashPin(String pin) {
    var bytes = utf8.encode(pin);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Store PIN securely
  Future<void> savePin(String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hashedPin = _hashPin(pin);
      await prefs.setString(_pinKey, hashedPin);
    } catch (e) {
      throw Exception('Failed to save PIN: $e');
    }
  }

  // Verify PIN
  Future<bool> verifyPin(String inputPin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedHash = prefs.getString(_pinKey);

      if (storedHash == null) {
        return false; // No PIN set
      }

      final inputHash = _hashPin(inputPin);
      return storedHash == inputHash;
    } catch (e) {
      return false;
    }
  }

  // Check if PIN is set
  Future<bool> isPinSet() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_pinKey) != null;
    } catch (e) {
      return false;
    }
  }

  // Store pattern
  Future<void> savePattern(List<int> pattern) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_patternKey, pattern.join(','));
    } catch (e) {
      throw Exception('Failed to save pattern: $e');
    }
  }

  // Get stored pattern
  Future<List<int>?> getPattern() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final patternString = prefs.getString(_patternKey);

      if (patternString == null) return null;

      return patternString.split(',').map(int.parse).toList();
    } catch (e) {
      return null;
    }
  }

  // Verify pattern
  Future<bool> verifyPattern(List<int> inputPattern) async {
    try {
      final storedPattern = await getPattern();
      if (storedPattern == null) return false;

      return inputPattern.join(',') == storedPattern.join(',');
    } catch (e) {
      return false;
    }
  }

  // Biometric settings
  Future<void> setBiometricEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_biometricEnabledKey, enabled);
    } catch (e) {
      throw Exception('Failed to save biometric setting: $e');
    }
  }

  Future<bool> isBiometricEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_biometricEnabledKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  // Clear all security data
  Future<void> clearAllSecurityData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pinKey);
      await prefs.remove(_patternKey);
      await prefs.remove(_biometricEnabledKey);
    } catch (e) {
      throw Exception('Failed to clear security data: $e');
    }
  }
}

