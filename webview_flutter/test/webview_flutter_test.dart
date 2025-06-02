import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class MockWebviewFlutterPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements WebviewFlutterPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WebviewFlutter', () {
    late WebviewFlutterPlatform webviewFlutterPlatform;

    setUp(() {
      webviewFlutterPlatform = MockWebviewFlutterPlatform();
      WebviewFlutterPlatform.instance = webviewFlutterPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => webviewFlutterPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => webviewFlutterPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
