import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    Key? key,
    required this.listItem,
    required this.index,
  }) : super(key: key);

  final Widget listItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 700),
      child: SlideAnimation(
        verticalOffset: 50.h,
        horizontalOffset: 50.w,
        child: FadeInAnimation(
          child: listItem,
        ),
      ),
    );
  }
}
