import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/atoms/github_icon.dart';
import '../../widgets/molecules/search_text_field.dart';

/// 検索用のトップページのView
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  static const path = '/';

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _vm = SearchPageVm();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DayNightTemplate(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: GithubIcon(
                size: MediaQuery.of(context).size.height / 4,
                isDarkMode: _vm.isDarkMode,
              ),
            ),
            SearchTextField(
                onSubmitted: (String keyword) =>
                    _vm.onSearch(keyword, context)),
          ],
        ),
      ),
    );
  }
}
