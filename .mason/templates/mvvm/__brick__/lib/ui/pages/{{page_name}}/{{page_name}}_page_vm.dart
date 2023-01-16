import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{page_name.pascalCase()}}PageVm {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }
}
