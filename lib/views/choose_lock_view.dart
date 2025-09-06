import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/choose_lock_controller.dart';

class ChooseLockView extends StatelessWidget {
  const ChooseLockView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChooseLockController());
    return Scaffold(
      backgroundColor: Color(0xff02A4FF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              _lockOption("assets/icons/thumb.png", "Fingerprint", () {
                controller.selectLock("fingerprint");
              }),
              _lockOption("assets/icons/pswd.png", "PIN", () {
                controller.selectLock("pin");
              }),
              _lockOption("assets/icons/pattern.png", "Pattern", () {
                controller.selectLock("pattern");
              }),
              Text("Choose Lock Type"),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lockOption(String path, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff4B82F1FF), // bright border color
            width: 1, // thickness
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5), // glow color
              blurRadius: 10, // spread of the glow
              spreadRadius: 2, // makes glow extend outward
            ),
          ],
          color: Color(0xff02A4FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                path,
                width: 100,
                height: 100,
                color: Colors.white, // optional: tint color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
