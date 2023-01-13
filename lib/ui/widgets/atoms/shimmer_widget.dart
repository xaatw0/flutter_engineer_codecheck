import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// シマーを扱いやすくするためのWidget
class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
    super.key,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
    super.key,
  });

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          height: height,
          width: width,
          decoration:
              ShapeDecoration(color: Colors.grey[400], shape: shapeBorder),
        ),
      );
}
