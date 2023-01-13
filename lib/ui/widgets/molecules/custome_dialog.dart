import 'package:flutter/material.dart';

/// カスタムのダイアログ
class CustomeDialog extends StatelessWidget {
  const CustomeDialog(
      {required this.title,
      required this.description,
      required this.onTap,
      this.labelButton = 'OK',
      super.key});

  /// タイトル
  final String title;

  /// 詳細
  final String description;

  /// ボタンをタップしたときのイベント
  final void Function() onTap;

  /// ボタンのラベル
  final String labelButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          color: Colors.white54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // タイトル
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // メッセージ
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                child: Text(labelButton),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
