import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter_linux/webview_flutter_linux.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WebviewFlutterLinux', () {
    const kPlatformName = 'Linux';
    late WebviewFlutterLinux webviewFlutter;
    late List<MethodCall> log;

    setUp(() async {
      webviewFlutter = WebviewFlutterLinux();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(webviewFlutter.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      WebviewFlutterLinux.registerWith();
      expect(WebviewFlutterPlatform.instance, isA<WebviewFlutterLinux>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await webviewFlutter.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
