import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../domain/string_resources.dart';

/// 検索結果がなかったときに残念顔を表示するWidget
class NotFoundResult extends StatelessWidget {
  const NotFoundResult({
    super.key,
  });

  static const _kFace = '(≥o≤)';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        container: true,
        label: StringResources.kLblNotFound,
        child: const AutoSizeText(
          _kFace,
          style: TextStyle(fontSize: 1024),
          maxLines: 1,
        ),
      ),
    );
  }
}
