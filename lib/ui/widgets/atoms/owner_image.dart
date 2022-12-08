import 'dart:io';

import 'package:flutter/material.dart';

/// レポジトリの持ち主の画像
/// (GoldenTest時は、Flutterのログになる)
class OwnerImage extends StatelessWidget {
  const OwnerImage({
    Key? key,
    required this.url,
    this.size,
  }) : super(key: key);

  final String url;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Platform.environment.containsKey('FLUTTER_TEST')
          ? FlutterLogo(size: size)
          : Image.network(
              url,
              width: size,
              height: size,
            ),
    );
  }
}
