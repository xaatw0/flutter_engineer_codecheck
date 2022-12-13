import 'package:flutter_engineer_codecheck/ui/pages/search_page/visible_widget_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('isWeb', () async {
    const web = VisibleWidgetLogic(
      isWeb: true,
      isPortrait: false,
      isKeyboardShown: false,
      isTextInputted: false,
    );

    expect(web.isLogoVisible, true);
    expect(web.isButtonVisible, true);
    expect(web.hasPadding, true);

    const webKeyboard = VisibleWidgetLogic(
      isWeb: true,
      isPortrait: false,
      isKeyboardShown: true,
      isTextInputted: false,
    );

    expect(webKeyboard.isLogoVisible, true);
    expect(webKeyboard.isButtonVisible, true);
    expect(webKeyboard.hasPadding, true);

    const webKeyboardText = VisibleWidgetLogic(
      isWeb: true,
      isPortrait: false,
      isKeyboardShown: true,
      isTextInputted: true,
    );
    expect(webKeyboardText.isLogoVisible, true);
    expect(webKeyboardText.isButtonVisible, true);
    expect(webKeyboardText.hasPadding, true);
    const webPortrait = VisibleWidgetLogic(
      isWeb: true,
      isPortrait: true,
      isKeyboardShown: false,
      isTextInputted: false,
    );
    expect(webPortrait.isLogoVisible, true);
    expect(webPortrait.isButtonVisible, true);
    expect(webPortrait.hasPadding, true);
  });

  test('smartphone, portrait', () async {
    const portrait = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: true,
      isKeyboardShown: false,
      isTextInputted: false,
    );

    expect(portrait.isLogoVisible, true);
    expect(portrait.isButtonVisible, false);
    expect(portrait.hasPadding, true);

    const portraitKeyboard = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: true,
      isKeyboardShown: true,
      isTextInputted: false,
    );

    expect(portraitKeyboard.isLogoVisible, true);
    expect(portraitKeyboard.isButtonVisible, false);
    expect(portraitKeyboard.hasPadding, true);

    const portraitKeyboardInput = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: true,
      isKeyboardShown: true,
      isTextInputted: true,
    );

    expect(portraitKeyboardInput.isLogoVisible, true);
    expect(portraitKeyboardInput.isButtonVisible, false);
    expect(portraitKeyboardInput.hasPadding, true);

    const portraitInput = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: true,
      isKeyboardShown: false,
      isTextInputted: true,
    );

    expect(portraitInput.isLogoVisible, true);
    expect(portraitInput.isButtonVisible, true);
    expect(portraitInput.hasPadding, true);
  });

  test('smartphone, landscape', () async {
    const landscape = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: false,
      isKeyboardShown: false,
      isTextInputted: false,
    );

    expect(landscape.isLogoVisible, true);
    expect(landscape.isButtonVisible, false);
    expect(landscape.hasPadding, true);

    const landscapeKeyboard = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: false,
      isKeyboardShown: true,
      isTextInputted: false,
    );

    expect(landscapeKeyboard.isLogoVisible, false);
    expect(landscapeKeyboard.isButtonVisible, false);
    expect(landscapeKeyboard.hasPadding, false);

    const landscapeKeyboardInput = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: false,
      isKeyboardShown: true,
      isTextInputted: true,
    );

    expect(landscapeKeyboardInput.isLogoVisible, false);
    expect(landscapeKeyboardInput.isButtonVisible, false);
    expect(landscapeKeyboardInput.hasPadding, false);

    const landscapeInput = VisibleWidgetLogic(
      isWeb: false,
      isPortrait: false,
      isKeyboardShown: false,
      isTextInputted: true,
    );

    expect(landscapeInput.isLogoVisible, false);
    expect(landscapeInput.isButtonVisible, true);
    expect(landscapeInput.hasPadding, true);
  });
}
