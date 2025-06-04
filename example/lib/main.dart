import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

WebViewPlatform? get _platform => WebViewPlatform.instance;
final WebViewController _controller = WebViewController();
final WebViewWidget _webViewWidget = WebViewWidget(controller: _controller);

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  String platformName = "UNKNOWN";
  PlatformWebViewControllerCreationParams c = PlatformWebViewControllerCreationParams();

  if (_platform != null) {
    platformName = _platform.toString();
  }
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _platformName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebviewFlutter Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_platformName == null)
              const SizedBox.shrink()
            else
              Text(
                'Platform Name: $_platformName',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (!context.mounted) return;
                try {
                  final result = await getPlatformName();
                  setState(() => _platformName = result);
                } catch (error) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text('$error'),
                    ),
                  );
                }
              },
              child: const Text('Get Platform Name'),
            ),
            _webViewWidget,
          ],
        ),
      ),
    );
  }
}
