import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

class WaNotifierPage extends StatefulWidget {
  const WaNotifierPage({super.key});

  @override
  State<WaNotifierPage> createState() => _WaNotifierPageState();
}

class _WaNotifierPageState extends State<WaNotifierPage> {
  final _webController = WebviewController();

  @override
  void initState() {
    initWeb();
    super.initState();
  }

  void initWeb() async {
    await _webController.loadUrl('https://kidsplanetnewspaper.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: _webController.loadingState,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Webview(_webController);
          },
        ),
      ),
    );
  }
}
