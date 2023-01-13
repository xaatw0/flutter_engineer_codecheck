import 'package:flutter/material.dart';

import '../atoms/shimmer_widget.dart';

/// RepositoryDataCardに似ているローディングしている最中に表示するWidget
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: ShimmerWidget.circular(
            width: 52,
            height: 52,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          title: ShimmerWidget.rectangular(height: 32),
        ),
      ),
    );
  }
}
