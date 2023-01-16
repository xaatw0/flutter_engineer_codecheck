import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../gen/assets.gen.dart';
import '{{page_name.snakeCase()}}_page_vm.dart';

class {{page_name.pascalCase()}}Page extends ConsumerStatefulWidget {
  const {{page_name.pascalCase()}}Page({Key? key}) : super(key: key);

  static const String path = '/{{page_name.camelCase()}}';

  @override
  ConsumerState<{{page_name.pascalCase()}}Page> createState() => _{{page_name.pascalCase()}}PageState();
}

class _{{page_name.pascalCase()}}PageState extends ConsumerState<{{page_name.pascalCase()}}Page> {
  final {{page_name.pascalCase()}}PageVm _vm = {{page_name.pascalCase()}}PageVm();

  @override
  void initState() {
    super.initState();

    _vm.setRef(ref);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
