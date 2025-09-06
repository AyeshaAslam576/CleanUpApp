import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScanningController extends GetxController {
  final contactCount = 37.obs;
  final isLoading = false.obs;
  final selectedContacts = <int>{}.obs;
  final isSelectionMode = false.obs; // Track selection mode

  // Simulated contacts data - 28 contacts as shown in design
  final contacts = List.generate(
    28,
    (index) => {
      'id': index,
      'name': 'Contact ${index + 1}',
      'phone': '+1 555-${(1000 + index).toString().padLeft(4, '0')}',
    },
  ).obs;

  @override
  void onInit() {
    super.onInit();
    _loadContacts();
  }

  void _loadContacts() async {
    isLoading.value = true;

    // Simulate loading contacts
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;
  }

  void toggleContactSelection(int contactId) {
    // Immediate selection toggle without delays
    if (selectedContacts.contains(contactId)) {
      selectedContacts.remove(contactId);
    } else {
      selectedContacts.add(contactId);
    }

    // Update selection mode immediately
    isSelectionMode.value = selectedContacts.isNotEmpty;
  }

  void selectAllContacts() {
    selectedContacts.clear();
    for (var contact in contacts) {
      selectedContacts.add(contact['id'] as int);
    }
    isSelectionMode.value = true;
  }

  void clearSelection() {
    selectedContacts.clear();
    isSelectionMode.value = false;
  }

  void selectContacts() {
    if (selectedContacts.isEmpty) {
      Get.snackbar(
        'No Contacts Selected',
        'Please select contacts to share',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Contacts Selected',
      '${selectedContacts.length} contacts selected for sharing',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void shareAllContacts() {
    Get.snackbar(
      'Sharing All Contacts',
      'Sharing ${contactCount.value} contacts',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void goBack() {
    // Navigate back to the previous screen
    Get.back();
  }
}
