import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

/// The Linux implementation of [WebviewFlutterPlatform].
class WebviewFlutterLinux extends WebviewFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('webview_flutter_linux');

  /// Registers this class as the default instance of [WebviewFlutterPlatform]
  static void registerWith() {
    WebviewFlutterPlatform.instance = WebviewFlutterLinux();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
