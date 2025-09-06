import 'package:get/get.dart';
import '../routes/app_routes.dart';

class MediaCompressionController extends GetxController {
  final selectedMedia = <String>{}.obs; // Set of selected media IDs
  final compressionRatio = 25.obs; // Default compression ratio

  void toggleMediaSelection(String mediaId) {
    if (selectedMedia.contains(mediaId)) {
      selectedMedia.remove(mediaId);
    } else {
      selectedMedia.add(mediaId);
    }
  }

  void setCompressionRatio(int ratio) {
    compressionRatio.value = ratio;
  }

  void startCompression() {
    if (selectedMedia.isNotEmpty) {
      // Navigate to compression progress screen
      Get.toNamed(AppRoutes.compressionProgress);
    }
  }

  void goBack() {
    Get.back();
  }

  // Sample media data
  List<Map<String, dynamic>> getMediaData() {
    return [
      {
        'id': 'media_1',
        'date': '2025 07 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.2GB',
        'type': 'video',
      },
      {
        'id': 'media_2',
        'date': '2025 07 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '856MB',
        'type': 'video',
      },
      {
        'id': 'media_3',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.1GB',
        'type': 'video',
      },
      {
        'id': 'media_4',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.5GB',
        'type': 'video',
      },
      {
        'id': 'media_5',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '987MB',
        'type': 'video',
      },
      {
        'id': 'media_6',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.8GB',
        'type': 'video',
      },
      {
        'id': 'media_7',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '2.3GB',
        'type': 'video',
      },
      {
        'id': 'media_8',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.1GB',
        'type': 'video',
      },
      {
        'id': 'media_9',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.7GB',
        'type': 'video',
      },
      {
        'id': 'media_10',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '2.8GB',
        'type': 'video',
      },
      {
        'id': 'media_11',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.4GB',
        'type': 'video',
      },
      {
        'id': 'media_12',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.9GB',
        'type': 'video',
      },
      {
        'id': 'media_13',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '2.2GB',
        'type': 'video',
      },
      {
        'id': 'media_14',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.6GB',
        'type': 'video',
      },
      {
        'id': 'media_15',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.0GB',
        'type': 'video',
      },
      {
        'id': 'media_16',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.3GB',
        'type': 'video',
      },
      {
        'id': 'media_17',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '1.9GB',
        'type': 'video',
      },
      {
        'id': 'media_18',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.4GB',
        'type': 'video',
      },
      {
        'id': 'media_19',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.8GB',
        'type': 'video',
      },
      {
        'id': 'media_20',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '2.1GB',
        'type': 'video',
      },
    ];
  }

  // Calculate total size of selected media
  String getSelectedMediaSize() {
    final media = getMediaData();
    double totalSize = 0;

    for (final id in selectedMedia) {
      final item = media.firstWhere((element) => element['id'] == id);
      final sizeStr = item['size'] as String;
      if (sizeStr.endsWith('GB')) {
        totalSize += double.parse(sizeStr.replaceAll('GB', ''));
      } else if (sizeStr.endsWith('MB')) {
        totalSize += double.parse(sizeStr.replaceAll('MB', '')) / 1024;
      }
    }

    return '${totalSize.toStringAsFixed(2)} GB';
  }
}
