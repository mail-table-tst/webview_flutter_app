import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:webview_flutter_platform_interface/src/method_channel_webview_flutter.dart';

/// The interface that implementations of webview_flutter must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `WebviewFlutter`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [WebviewFlutterPlatform] methods.
abstract class WebviewFlutterPlatform extends PlatformInterface {
  /// Constructs a WebviewFlutterPlatform.
  WebviewFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebviewFlutterPlatform _instance = MethodChannelWebviewFlutter();

  /// The default instance of [WebviewFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWebviewFlutter].
  static WebviewFlutterPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [WebviewFlutterPlatform] when they register themselves.
  static set instance(WebviewFlutterPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();
}
