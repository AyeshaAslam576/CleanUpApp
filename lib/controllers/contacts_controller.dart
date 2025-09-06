import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  final hasPermission = false.obs;
  final isLoading = false.obs;
  final contactSelected = false.obs;
  final selectedContacts = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  void toggleContactSelection() {
    try {
      print('Toggling contact selection');
      contactSelected.value = !contactSelected.value;
    } catch (e) {
      print('Error toggling contact selection: $e');
    }
  }

  void goToSettings() {
    try {
      print('Attempting to go to settings');
      // Simulate permission granted
      hasPermission.value = true;
      Get.snackbar(
        'Permission Granted',
        'Contacts access has been granted',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF02A4FF),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error going to settings: $e');
      Get.snackbar(
        'Error',
        'Failed to go to settings: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void goBack() {
    try {
      print('Attempting to go back from contacts screen');
      if (hasPermission.value) {
        // If we have permission, go back to permission screen
        hasPermission.value = false;
      } else {
        // If no permission, go back to previous screen
        Get.back();
      }
    } catch (e) {
      print('Error going back: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to go back: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void checkPermission() async {
    try {
      isLoading.value = true;
      // Simulate permission check
      await Future.delayed(const Duration(seconds: 1));
      // hasPermission.value = false; // Keep false to show permission screen first
      isLoading.value = false;
    } catch (e) {
      print('Error checking permission: $e');
      isLoading.value = false;
    }
  }

  void selectContact(int contactId) {
    try {
      if (selectedContacts.contains(contactId)) {
        selectedContacts.remove(contactId);
      } else {
        selectedContacts.add(contactId);
      }
    } catch (e) {
      print('Error selecting contact: $e');
    }
  }

  void selectAllContacts() {
    try {
      // Simulate selecting all 37 contacts
      selectedContacts.clear();
      for (int i = 0; i < 37; i++) {
        selectedContacts.add(i);
      }
      Get.snackbar(
        'All Contacts Selected',
        '37 contacts have been selected',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF02A4FF),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error selecting all contacts: $e');
    }
  }

  void shareSelectedContacts() {
    try {
      if (selectedContacts.isEmpty) {
        Get.snackbar(
          'No Contacts Selected',
          'Please select contacts to share',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      
      Get.snackbar(
        'Sharing Contacts',
        'Sharing ${selectedContacts.length} contacts...',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF02A4FF),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error sharing contacts: $e');
      Get.snackbar(
        'Error',
        'Failed to share contacts: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
