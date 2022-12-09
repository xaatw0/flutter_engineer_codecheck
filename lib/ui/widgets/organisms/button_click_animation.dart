import 'package:flutter/material.dart';

/// 対象のWidgetを押すと、少し小さくなって、それから元の大きさになるアニメーションを実施する。
/// アニメーション後、[onTap]が実施される。
class ButtonClickAnimation extends StatefulWidget {
  const ButtonClickAnimation(
      {Key? key, required this.child, required this.onTap})
      : super(key: key);

  /// アニメーションするWidget
  final Widget child;

  /// アニメーション後に実施されるイベント
  final void Function()? onTap;

  @override
  State<StatefulWidget> createState() => _ButtonClickAnimationState();
}

class _ButtonClickAnimationState extends State<ButtonClickAnimation>
    with TickerProviderStateMixin<ButtonClickAnimation> {
  // 100ミリ秒でアニメーションが実施される。
  late AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      value: 1.0);

  // 最初が1で最後に0.95になるようにする。つまり、100%の大きさを95%の大きさに変化させる。
  late Animation<double> easeInAnimation = Tween(begin: 1.0, end: 0.95).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 1→0.95に変化させて、サイズを変える
        controller.forward().then((_) {
          // 0.95になった後に逆再生させて、1に戻す
          controller.reverse().then((_) {
            // 元の大きさに戻ったら、onTapのイベントがあれば実行する
            if (widget.onTap != null) {
              widget.onTap!();
            }
          });
        });
      },
      // childの大きさを1→0.95→1にアニメーションさせる
      child: ScaleTransition(
        scale: easeInAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
