import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// 検索結果がなかったときに残念顔を表示するWidget
class NotFoundResult extends StatelessWidget {
  const NotFoundResult({
    Key? key,
  }) : super(key: key);

  static const _kFace = '(≥o≤)';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AutoSizeText(
        _kFace,
        style: TextStyle(fontSize: 1024),
        maxLines: 1,
      ),
    );
  }
}
