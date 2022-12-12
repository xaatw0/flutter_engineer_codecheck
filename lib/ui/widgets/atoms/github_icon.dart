import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../gen/assets.gen.dart';

/// Githubのアイコン。
/// [isDarkMode]でテーマを指定する。trueの場合白いアイコン、falseの場合黒いアイコンが表示される。
/// [size]で高さを指定する
class GithubIcon extends StatelessWidget {
  const GithubIcon({
    super.key,
    required this.size,
    required this.isDarkMode,
  });

  final double size;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isDarkMode ? Assets.images.githubMarkWhite : Assets.images.githubMark,
      height: size,
    );
  }
}
