# 🔧 **Dependency Injection Guide - Preventing "Not Found" Errors**

## 🚨 **Common Error: "StorageRepository not found"**

This error occurs when you try to use `Get.find<ServiceType>()` before the service has been registered with GetX.

## ✅ **Correct Pattern: Use Get.put() in Controllers**

### **❌ WRONG - Using Get.find()**
```dart
class MyController extends GetxController {
  // This will cause "Service not found" error if service isn't registered
  final StorageRepository _storageRepository = Get.find<StorageRepository>();
}
```

### **✅ CORRECT - Using Get.put()**
```dart
class MyController extends GetxController {
  late final StorageRepository _storageRepository;

  @override
  void onInit() {
    super.onInit();
    // This ensures the service is available
    _storageRepository = Get.put(StorageRepository());
  }
}
```

## 🏗️ **Service Registration Architecture**

### **1. Dependency Injection Setup (main.dart)**
```dart
import 'services/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies BEFORE running the app
  await DependencyInjection.init();
  
  runApp(const MyCleanupApp());
}
```

### **2. Service Registration (dependency_injection.dart)**
```dart
class DependencyInjection {
  static Future<void> init() async {
    // Register services as singletons (permanent: true)
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<StorageRepository>(StorageRepository(), permanent: true);
    
    // Add more services here as needed
    // Get.put<AnalyticsService>(AnalyticsService(), permanent: true);
    // Get.put<NotificationService>(NotificationService(), permanent: true);
  }
}
```

### **3. Controller Implementation**
```dart
class MyController extends GetxController {
  // Declare as late final
  late final StorageRepository _storageRepository;
  late final SecureStorageService _secureStorage;

  @override
  void onInit() {
    super.onInit();
    
    // Use Get.put() to ensure services are available
    _storageRepository = Get.put(StorageRepository());
    _secureStorage = Get.put(SecureStorageService());
    
    // Initialize controller logic
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await _storageRepository.getData();
      // Process data
    } catch (e) {
      // Handle errors
    }
  }
}
```

## 🔄 **Alternative Patterns**

### **Pattern 1: Lazy Registration**
```dart
class MyController extends GetxController {
  late final StorageRepository _storageRepository;

  @override
  void onInit() {
    super.onInit();
    // Lazy put - only creates if not already exists
    _storageRepository = Get.lazyPut(() => StorageRepository());
  }
}
```

### **Pattern 2: Conditional Registration**
```dart
class MyController extends GetxController {
  late final StorageRepository _storageRepository;

  @override
  void onInit() {
    super.onInit();
    
    // Check if service exists, if not create it
    if (!Get.isRegistered<StorageRepository>()) {
      _storageRepository = Get.put(StorageRepository());
    } else {
      _storageRepository = Get.find<StorageRepository>();
    }
  }
}
```

### **Pattern 3: View-Level Registration**
```dart
class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Register controller and dependencies at view level
    final controller = Get.put(MyController());
    
    return Scaffold(
      // View content
    );
  }
}
```

## 📋 **Services That Must Be Registered**

### **Core Services (Always Register)**
- `StorageRepository` - Storage management
- `SecureStorageService` - Security and encryption
- `PermissionService` - Device permissions
- `AnalyticsService` - App analytics

### **Optional Services (Register as Needed)**
- `NotificationService` - Push notifications
- `CacheService` - Data caching
- `NetworkService` - API communication
- `LocalizationService` - Multi-language support

## 🚫 **Common Mistakes to Avoid**

### **1. Using Get.find() Before Registration**
```dart
// ❌ WRONG - Service not registered yet
class MyController extends GetxController {
  final service = Get.find<MyService>(); // Will crash
}
```

### **2. Missing Dependency Injection Call**
```dart
// ❌ WRONG - main.dart doesn't call DependencyInjection.init()
void main() {
  runApp(const MyApp()); // Services not registered!
}
```

### **3. Circular Dependencies**
```dart
// ❌ WRONG - Circular dependency
class ServiceA {
  final ServiceB _serviceB = Get.put(ServiceB());
}

class ServiceB {
  final ServiceA _serviceA = Get.put(ServiceA()); // Circular!
}
```

### **4. Forgetting to Call super.onInit()**
```dart
// ❌ WRONG - Missing super.onInit()
@override
void onInit() {
  // Missing: super.onInit();
  _service = Get.put(MyService());
}
```

## ✅ **Best Practices Checklist**

- [ ] Always call `DependencyInjection.init()` in `main()`
- [ ] Use `Get.put()` instead of `Get.find()` in controllers
- [ ] Declare services as `late final` in controllers
- [ ] Initialize services in `onInit()` method
- [ ] Call `super.onInit()` in all controllers
- [ ] Register services as `permanent: true` if they should persist
- [ ] Handle errors gracefully when services fail to load
- [ ] Test dependency injection on app startup

## 🔍 **Debugging Dependency Issues**

### **Check if Service is Registered**
```dart
if (Get.isRegistered<StorageRepository>()) {
  print('Service is registered');
} else {
  print('Service is NOT registered');
}
```

### **List All Registered Services**
```dart
print('Registered services: ${Get.keys}');
```

### **Force Service Registration**
```dart
// Emergency fix - force register service
if (!Get.isRegistered<StorageRepository>()) {
  Get.put<StorageRepository>(StorageRepository(), permanent: true);
}
```

## 📚 **Example Implementation**

### **Complete Controller Example**
```dart
import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../repositories/data_repository.dart';

class ExampleController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final data = <String>[].obs;
  
  // Services
  late final StorageService _storageService;
  late final DataRepository _dataRepository;

  @override
  void onInit() {
    super.onInit();
    
    // Initialize services
    _storageService = Get.put(StorageService());
    _dataRepository = Get.put(DataRepository());
    
    // Load initial data
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    try {
      final result = await _dataRepository.getData();
      data.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
```

## 🎯 **Summary**

1. **Always use `Get.put()`** instead of `Get.find()` in controllers
2. **Call `DependencyInjection.init()`** in `main()` before `runApp()`
3. **Register services as singletons** with `permanent: true`
4. **Initialize services in `onInit()`** method
5. **Handle errors gracefully** when services fail
6. **Test dependency injection** on app startup

Following these patterns will prevent the "Service not found" errors and ensure your app runs smoothly! 🚀
