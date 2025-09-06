import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaManagerController extends GetxController {
  final selectedTabIndex = 0.obs; // Photos tab is selected by default
  final expandedSections = <String>{}.obs; // Set of expanded section dates
  final isSelectionMode = false.obs;
  final selectedFiles = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initially expand all sections
    _expandAllSections();
  }

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;
  }

  void toggleSection(String date) {
    if (expandedSections.contains(date)) {
      expandedSections.remove(date);
    } else {
      expandedSections.add(date);
    }
  }

  void _expandAllSections() {
    // Add all dates to expanded sections
    final allDates = <String>{};
    allDates.addAll(getPhotosData().map((e) => e['date'] as String));
    allDates.addAll(getVideosData().map((e) => e['date'] as String));
    expandedSections.addAll(allDates);
  }

  void goBack() {
    Get.back();
  }

  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedFiles.clear();
    }
  }

  void toggleFileSelection(String fileId) {
    if (selectedFiles.contains(fileId)) {
      selectedFiles.remove(fileId);
    } else {
      selectedFiles.add(fileId);
    }
  }

  void selectAllFiles() {
    final documents = getDocumentsData();
    if (selectedFiles.length == documents.length) {
      selectedFiles.clear();
    } else {
      selectedFiles.clear();
      selectedFiles.addAll(documents.map((doc) => doc['id'] as String));
    }
  }

  void moveSelectedFiles() {
    if (selectedFiles.isNotEmpty) {
      Get.snackbar(
        'Success',
        '${selectedFiles.length} files moved successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      selectedFiles.clear();
      isSelectionMode.value = false;
    }
  }

  void addFiles() {
    Get.snackbar(
      'Add Files',
      'Add files feature coming soon',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Sample data for different tabs
  List<Map<String, dynamic>> getPhotosData() {
    return [
      {
        'id': 'photo_1',
        'date': '2022 07 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_2',
        'date': '2022 07 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_3',
        'date': '2022 06 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_4',
        'date': '2022 06 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_5',
        'date': '2022 06 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_6',
        'date': '2022 06 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_7',
        'date': '2022 06 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_8',
        'date': '2022 06 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_9',
        'date': '2022 06 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_10',
        'date': '2022 06 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_11',
        'date': '2022 06 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_12',
        'date': '2022 06 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_13',
        'date': '2022 05 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_14',
        'date': '2022 05 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_15',
        'date': '2022 05 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_16',
        'date': '2022 05 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_17',
        'date': '2022 05 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_18',
        'date': '2022 05 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_19',
        'date': '2022 05 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_20',
        'date': '2022 05 22',
        'image': 'assets/images/flower2.png',
      },
    ];
  }

  List<Map<String, dynamic>> getVideosData() {
    return [
      {
        'id': 'video_1',
        'date': '2025 07 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.2GB',
      },
      {
        'id': 'video_2',
        'date': '2025 07 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '856MB',
      },
      {
        'id': 'video_3',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.1GB',
      },
      {
        'id': 'video_4',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.5GB',
      },
      {
        'id': 'video_5',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '987MB',
      },
      {
        'id': 'video_6',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.8GB',
      },
      {
        'id': 'video_7',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '2.3GB',
      },
      {
        'id': 'video_8',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.1GB',
      },
      {
        'id': 'video_9',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.7GB',
      },
      {
        'id': 'video_10',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '2.8GB',
      },
      {
        'id': 'video_11',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.4GB',
      },
      {
        'id': 'video_12',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.9GB',
      },
      {
        'id': 'video_13',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '2.2GB',
      },
      {
        'id': 'video_14',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.6GB',
      },
      {
        'id': 'video_15',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.0GB',
      },
      {
        'id': 'video_16',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.3GB',
      },
      {
        'id': 'video_17',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.9GB',
      },
      {
        'id': 'video_18',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.4GB',
      },
      {
        'id': 'video_19',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.8GB',
      },
      {
        'id': 'video_20',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '2.1GB',
      },
    ];
  }

  List<Map<String, dynamic>> getDocumentsData() {
    return [
      {'id': 'doc_1', 'name': 'Document Name', 'size': '2.4GB'},
      {'id': 'doc_2', 'name': 'Large File name', 'size': '2.4GB'},
      {'id': 'doc_3', 'name': 'Important Document', 'size': '1.8GB'},
      {'id': 'doc_4', 'name': 'Project File', 'size': '3.2GB'},
      {'id': 'doc_5', 'name': 'Report.pdf', 'size': '856MB'},
      {'id': 'doc_6', 'name': 'Presentation.pptx', 'size': '1.2GB'},
      {'id': 'doc_7', 'name': 'Spreadsheet.xlsx', 'size': '2.1GB'},
      {'id': 'doc_8', 'name': 'Contract.pdf', 'size': '1.5GB'},
      {'id': 'doc_9', 'name': 'Manual.docx', 'size': '987MB'},
      {'id': 'doc_10', 'name': 'Archive.zip', 'size': '4.2GB'},
    ];
  }
}
