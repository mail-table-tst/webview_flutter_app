import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebviewFlutterMock extends WebviewFlutterPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('WebviewFlutterPlatformInterface', () {
    late WebviewFlutterPlatform webviewFlutterPlatform;

    setUp(() {
      webviewFlutterPlatform = WebviewFlutterMock();
      WebviewFlutterPlatform.instance = webviewFlutterPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await WebviewFlutterPlatform.instance.getPlatformName(),
          equals(WebviewFlutterMock.mockPlatformName),
        );
      });
    });
  });
}
