import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// レポジトリの詳細を表示する画面での、スターとスター数、などの組み合わせのWidget
class RepositoryDetailColumn extends StatelessWidget {
  const RepositoryDetailColumn(
    this.title,
    this.value, {
    super.key,
  });

  final String title;
  final int value;

  static final formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formatter.format(value),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.merge(const TextStyle(color: Colors.pinkAccent)),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
