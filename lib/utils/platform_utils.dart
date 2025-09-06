import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static String get platformName {
    if (isIOS) return 'iPhone';
    if (isAndroid) return 'Android';
    return 'Device';
  }

  static String get platformNameShort {
    if (isIOS) return 'iPhone';
    if (isAndroid) return 'Android';
    return 'Device';
  }
}
