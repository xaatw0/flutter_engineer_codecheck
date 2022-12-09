import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/owner_image.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';

import '../../widgets/molecules/repository_detail_column.dart';

/// レポジトリの詳細を表示するページ
class RepositoryDetailPage extends StatefulWidget {
  const RepositoryDetailPage({Key? key}) : super(key: key);

  static const path = '/repository';

  @override
  State<RepositoryDetailPage> createState() => _RepositoryDetailPageState();
}

class _RepositoryDetailPageState extends State<RepositoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return DayNightTemplate(children: [
      Center(
        child: Container(
          height: 135,
          width: 135,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 8),
            ],
            gradient: LinearGradient(
              //stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey, Colors.white70],
            ),
          ),
          child: ClipOval(
            child: OwnerImage(
              url: 'https://avatars.githubusercontent.com/u/14101776?v=4',
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Center(
        child: Text(
          "Flutter",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RepositoryDetailColumn('Star', 146985),
          RepositoryDetailColumn('Watcher', 146985),
          RepositoryDetailColumn('Fork', 146985),
          RepositoryDetailColumn('Issue', 146985),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),
      Center(
        child: Text(
          'Description',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    ]);
  }
}
