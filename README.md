# 🧹 **My Cleanup App**

A comprehensive Flutter mobile application for device optimization, storage management, and privacy protection.

## 🚀 **Quick Start**

### **Prerequisites**
- Flutter SDK: ^3.8.1
- Dart SDK: ^3.8.1
- Android Studio / VS Code
- Android SDK (API 21+) / Xcode (iOS 12+)

### **Installation**
```bash
# Clone the repository
git clone <repository-url>
cd mycleanupapp

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📱 **Features**

### ✅ **Core Features**
- **Storage Optimization** - Clean up junk files and optimize storage
- **App Lock System** - PIN, Pattern, and Fingerprint security
- **Private Vault** - Secure file storage with encryption
- **Media Management** - File organization and compression
- **Contact Management** - Contact scanning and organization
- **Charging Animation** - Custom charging screen styles
- **Email Cleaner** - Email management and cleanup
- **Settings** - Comprehensive app configuration

### 🔄 **Navigation**
- **Bottom Navigation Bar** - Home, Features, Settings
- **Smooth Transitions** - Fade-in animations (300ms)
- **Route Management** - Centralized routing with GetX
- **Deep Linking** - Support for direct navigation

## 🏗️ **Project Structure**

```
lib/
├── main.dart                 # App entry point
├── routes/                   # Routing configuration
│   ├── app_routes.dart      # Route constants
│   └── app_pages.dart       # GetPage configurations
├── controllers/              # GetX controllers
├── views/                    # UI screens
├── widgets/                  # Reusable components
├── services/                 # Business logic
├── models/                   # Data models
├── utils/                    # Utilities
└── config/                   # Configuration
```

## 🎨 **Design System**

### **Colors**
- **Primary**: `#02A4FF` (Blue)
- **Secondary**: `#FF6B35` (Orange)
- **Background**: `#F8FAFF` (Light Blue)
- **Yellow Gradient**: `#FFC72D00` to `#FFC72D33`

### **Typography**
- **Font**: Google Fonts - Poppins
- **Weights**: 400, 500, 600, 700

## 📋 **Asset Requirements**

### **Images to Add**
- `assets/images/robot.png` - Settings unlock banner
- `assets/images/instagram.png` - Social media section
- `assets/images/faq.png` - FAQ section
- `assets/images/charging1.png` through `assets/images/charging4.png` - Charging animations
- `assets/images/privatevault.png` - Private vault setup
- `assets/images/mainvault.png` - Main vault screen
- `assets/images/intruder.png` - Intruder snaps

### **Icons to Add**
- `assets/icons/apple.png` - Apple sign-in
- `assets/icons/google.png` - Google sign-in
- `assets/icons/lock.png` - Security features

## 🔧 **Adding New Features**

### **1. Create View & Controller**
```bash
# Create view file
touch lib/views/new_feature_view.dart

# Create controller file
touch lib/controllers/new_feature_controller.dart
```

### **2. Add Route**
```dart
// In app_routes.dart
static const String newFeature = '/new-feature';

// In app_pages.dart
GetPage(name: '/new-feature', page: () => const NewFeatureView()),
```

### **3. Navigate**
```dart
Get.toNamed(AppRoutes.newFeature);
```

## 📱 **Platform Support**

- **Android**: API 21+ (Android 5.0+)
- **iOS**: iOS 12.0+
- **Features**: Material Design 3, Dark Mode, Biometric Auth

## 🚀 **Build & Deploy**

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## 📚 **Dependencies**

- **GetX**: State management & routing
- **Google Fonts**: Typography
- **Shared Preferences**: Local storage
- **Permission Handler**: Device permissions
- **Local Auth**: Biometric authentication

## 🤝 **Contributing**

1. Fork the repository
2. Create feature branch
3. Follow coding standards
4. Submit pull request

## 📄 **License**

This project is licensed under the MIT License.

---

**Version**: 1.0.0  
**Last Updated**: December 2024
