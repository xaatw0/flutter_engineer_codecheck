import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/search_page_vm.dart';
import 'package:flutter_engineer_codecheck/ui/pages/search_page/visible_widget_logic.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/atoms/cancel_tab_key.dart';
import 'package:flutter_engineer_codecheck/ui/widgets/templates/day_night_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../widgets/atoms/github_icon.dart';
import '../../widgets/molecules/search_text_field.dart';
import '../../widgets/organisms/moving_fadein_animation.dart';

/// 検索用のトップページのView
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  static const path = '/';

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _vm = GetIt.I.get<SearchPageVm>();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    // 画面が横向きの場合、キーボードと入力欄が被る可能性が高い。
    // そのため、横向きでキーボード表示時は、アイコンを消して、Padding を小さくする
    final visibleWidgetLogic = VisibleWidgetLogic(
      isWeb: kIsWeb,
      isPortrait: _vm.isPortrait(context),
      isKeyboardShown: _vm.isKeyboardShown(context),
      isTextInputted: _vm.isKeywordAvailable,
    );
    return Scaffold(
      body: SafeArea(
        child: DayNightTemplate(
          isAppBarShown: visibleWidgetLogic.hasPadding,
          hasPadding: visibleWidgetLogic.hasPadding,
          child: Column(
            children: [
              // Githubのアイコン
              Visibility(
                visible: visibleWidgetLogic.isLogoVisible,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: MovingFadeinAnimation(
                    child: GithubIcon(
                      size: MediaQuery.of(context).size.height / 4,
                      isDarkMode: _vm.isDarkMode,
                    ),
                  ),
                ),
              ),

              // 検索のキーワード入力
              Semantics(
                container: true,
                label: AppLocalizations.of(context).searchExplain,
                child: CancelTabKey(
                  child: SearchTextField(
                    controller: kIsWeb ? KanjiTextEditingController() : null,
                    onChangeKeyword: _vm.onChangeKeyword,
                    onSubmitted: (_) => _vm.onSearch(context),
                    onSelectSortMethod: () => _vm.onSelectSortMethod(context),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 検索ボタン
              // アプリでは、キーボードが非表示でキーワードが入力済みの時のみ表示される
              Visibility(
                visible: visibleWidgetLogic.isButtonVisible,
                child: Semantics(
                  container: true,
                  label: AppLocalizations.of(context).search,
                  child: OutlinedButton(
                    onPressed: () => _vm.onSearch(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.of(context).search,
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
