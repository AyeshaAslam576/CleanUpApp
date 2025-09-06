class OptimizationCategory {
  final String title;
  final String imagePath;
  final int itemCount;
  final String size;
  final String itemType; // "Images", "Videos", "Apps", etc.
  final String categoryType; // "duplicate", "similar", "large", etc.

  OptimizationCategory({
    required this.title,
    required this.imagePath,
    required this.itemCount,
    required this.size,
    required this.itemType,
    required this.categoryType,
  });

  static List<OptimizationCategory> getMockData() {
    return [
      OptimizationCategory(
        title: "Duplicate Images",
        imagePath: "assets/images/mountain_lake.jpg",
        itemCount: 658,
        size: "120.65MB",
        itemType: "Images",
        categoryType: "duplicate",
      ),
      OptimizationCategory(
        title: "Similar Screenshots",
        imagePath: "assets/images/phone_screenshot.jpg",
        itemCount: 125,
        size: "136.65MB",
        itemType: "Images",
        categoryType: "similar",
      ),
      OptimizationCategory(
        title: "Large Video",
        imagePath: "assets/images/lizard.jpg",
        itemCount: 5,
        size: "1.5GB",
        itemType: "Videos",
        categoryType: "large",
      ),
      OptimizationCategory(
        title: "Other Screenshots",
        imagePath: "assets/images/home_screen.jpg",
        itemCount: 125,
        size: "136.65MB",
        itemType: "Images",
        categoryType: "other",
      ),
      OptimizationCategory(
        title: "WhatsApp Images",
        imagePath: "assets/images/living_room.jpg",
        itemCount: 125,
        size: "136.65MB",
        itemType: "Images",
        categoryType: "whatsapp",
      ),
      OptimizationCategory(
        title: "Old Documents",
        imagePath: "assets/images/document.jpg",
        itemCount: 125,
        size: "136.65MB",
        itemType: "Documents",
        categoryType: "documents",
      ),
      OptimizationCategory(
        title: "WhatsApp Images",
        imagePath: "assets/images/app_icons.jpg",
        itemCount: 3,
        size: "2.65GB",
        itemType: "Apps",
        categoryType: "apps",
      ),
    ];
  }
}






