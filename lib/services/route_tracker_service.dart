import 'package:get/get.dart';

/// Singleton service to track the current route source for navigation
/// This eliminates the need to pass arguments through multiple screens
class RouteTrackerService extends GetxService {
  static RouteTrackerService get instance => Get.find<RouteTrackerService>();

  // Observable variables to track the current route source
  final _currentSource = ''.obs;
  final _setupType = ''.obs;
  final _lockType = ''.obs;

  // Getters
  String get currentSource => _currentSource.value;
  String get setupType => _setupType.value;
  String get lockType => _lockType.value;

  // Observable getters for reactive UI
  RxString get currentSourceRx => _currentSource;
  RxString get setupTypeRx => _setupType;
  RxString get lockTypeRx => _lockType;

  /// Set the route source when navigating to lock setup
  void setRouteSource({
    required String source,
    String setupType = '',
    String lockType = '',
  }) {
    _currentSource.value = source;
    _setupType.value = setupType;
    _lockType.value = lockType;

    print(
      'RouteTracker: Set source=$source, setupType=$setupType, lockType=$lockType',
    );
  }

  /// Check if coming from a specific source
  bool isFromSource(String source) {
    return _currentSource.value == source;
  }

  /// Check if coming from intruder snap
  bool get isFromIntruderSnap => isFromSource('intruder_snap');

  /// Check if coming from private vault
  bool get isFromPrivateVault => isFromSource('private_vault');

  /// Check if coming from app lock
  bool get isFromAppLock => isFromSource('app_lock');

  /// Clear the current route tracking
  void clearRoute() {
    _currentSource.value = '';
    _setupType.value = '';
    _lockType.value = '';
    print('RouteTracker: Cleared route tracking');
  }

  /// Get navigation arguments for passing to other screens
  Map<String, dynamic> getNavigationArguments() {
    return {
      'source': _currentSource.value,
      'setupType': _setupType.value,
      'lockType': _lockType.value,
    };
  }

  @override
  void onInit() {
    super.onInit();
    print('RouteTracker: Service initialized');
  }

  @override
  void onClose() {
    clearRoute();
    super.onClose();
  }
}
