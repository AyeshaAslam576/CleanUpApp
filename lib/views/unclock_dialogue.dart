import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/unlock_controller.dart';

class UnlockDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UnlockController());

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text("Make Protected"),
      content: Text(
        "Make this app protected? You'll need to unlock before opening it.",
      ),
      actions: [
        TextButton(onPressed: () => controller.onCancel(), child: Text("No")),
        ElevatedButton(
          onPressed: () => controller.onConfirm(),
          child: Text("Yes"),
        ),
      ],
    );
  }
}
