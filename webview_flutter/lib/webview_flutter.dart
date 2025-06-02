import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

WebviewFlutterPlatform get _platform => WebviewFlutterPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
