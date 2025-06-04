import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

const DEFAULT_W = 100.0;
const DEFAULT_H = 100.0;

class Web_ViewControllerCreationParams
    extends PlatformWebViewControllerCreationParams {
  Web_ViewControllerCreationParams._(
    PlatformWebViewControllerCreationParams params, {
    this.w,
    this.h,
  }) : super();

  factory Web_ViewControllerCreationParams.fromPlatformWebViewControllerCreationParams(
    PlatformWebViewControllerCreationParams params, {
    double? w,
    double? h,
  }) {
    return Web_ViewControllerCreationParams._(params, w: w, h: h);
  }

  final double? w;
  final double? h;
}

class WebviewFlutterLinux extends WebViewPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('webview_flutter_linux');

  /// Registers this class as the default instance of [WebviewFlutterPlatform]
  static void registerWith() {
    WebViewPlatform.instance = WebviewFlutterLinux();
  }

  /// Create a new [PlatformWebViewController].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [WebViewController] in `webview_flutter` instead.
  @override
  PlatformWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) {
    return PlatformWeb_ViewController(Web_ViewControllerCreationParams.fromPlatformWebViewControllerCreationParams(params, w:100, h:400 ));
  }

  /// Create a new [PlatformWebViewWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [WebViewWidget] in `webview_flutter` instead.
  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) {
    return PlatformWeb_ViewWidget(params);
  }
}

class PlatformWeb_ViewController extends PlatformWebViewController {
  late PlatformWebViewControllerCreationParams params;
  PlatformWeb_ViewController(PlatformWebViewControllerCreationParams p) : super.implementation(p) {
    params = p;
  }
}

class PlatformWeb_ViewWidget extends PlatformWebViewWidget {
  late double _w;
  late double _h;
  late PlatformWeb_ViewController _c;

  PlatformWeb_ViewWidget (PlatformWebViewWidgetCreationParams p) : super.implementation(p) {
    _c = p.controller as PlatformWeb_ViewController;

    if (_c.params is Web_ViewControllerCreationParams) {
      Web_ViewControllerCreationParams pl = _c.params as Web_ViewControllerCreationParams;
      _w = pl.w ?? DEFAULT_W;
      _h = pl.h ?? DEFAULT_H;
    }
  }

  @override
  Widget build(BuildContext context) {
  return ColoredBox(
              color: Colors.red,
              child: SizedBox(
                width: _w,
                height: _h,
              ),
         );
  }
}
