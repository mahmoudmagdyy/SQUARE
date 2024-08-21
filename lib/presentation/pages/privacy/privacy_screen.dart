import 'package:aqarat/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  late WebViewController _controller;

  int progress = 0;

  void _updateProgress(int progress) {
    setState(() {
      this.progress = progress;
    });
  }

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _updateProgress(progress);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: progress < 100
          ? Center(
              child: CircularProgressIndicator(
                value: progress.toDouble(),
                color: AppColors.primary,
              ),
            )
          : WebViewWidget(
              controller: _controller,
            ),
    );
  }
}
