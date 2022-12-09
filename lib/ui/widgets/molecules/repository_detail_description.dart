import 'package:flutter/material.dart';

/// レポジトリの詳細を表示する画面のDescription部分のWidget
class RepositoryDetailDescription extends StatelessWidget {
  const RepositoryDetailDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Description',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}