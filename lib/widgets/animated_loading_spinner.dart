import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class AnimatedLoadingSpinner extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool repeat;
  final Duration? duration;

  const AnimatedLoadingSpinner({
    Key? key,
    this.size,
    this.color,
    this.repeat = true,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/loading_spinner.json',
      width: size ?? 15.w,
      height: size ?? 15.w,
      repeat: repeat,
      animate: true,
      fit: BoxFit.contain,
      // You can add color filters if needed
      // colorFilter: color != null
      //     ? ColorFilter.mode(color!, BlendMode.srcIn)
      //     : null,
    );
  }
}

// Alternative simple usage widget
class CleanupLoadingSpinner extends StatelessWidget {
  final String? message;
  final bool showMessage;

  const CleanupLoadingSpinner({Key? key, this.message, this.showMessage = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AnimatedLoadingSpinner(),
        if (showMessage) ...[
          SizedBox(height: 2.h),
          Text(
            message ?? 'Loading...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}





