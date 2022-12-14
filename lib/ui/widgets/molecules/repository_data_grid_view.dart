import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/molecules/repository_detail_column.dart';

class RepositoryDataGridView extends StatelessWidget {
  const RepositoryDataGridView({
    super.key,
    required this.columns,
    required this.axisCount,
  });

  /// スターなどの表示するデータのWidgetのリスト
  final List<RepositoryDetailColumn> columns;

  /// 並べる列数
  final int axisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: columns.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: axisCount,
        mainAxisExtent: 60,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return columns[index];
      },
    );
  }
}
