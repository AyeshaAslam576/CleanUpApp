import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/adcontroller.dart';

class FullscreenAdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdsController());
    return Scaffold(
      body: GestureDetector(
        onTap: controller.closeAd,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/ad_placeholder.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
