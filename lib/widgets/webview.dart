import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({
    super.key,
    required this.url,
    this.showTitle = true,
    this.redirectUrl,
    this.onClosed,
    this.onCompleted,
  });
  final String url;
  final bool showTitle;
  final String? redirectUrl;
  final VoidCallback? onClosed;
  final VoidCallback? onCompleted;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (widget.redirectUrl != null &&
                request.url.startsWith(
                  widget.redirectUrl!,
                )) {
              Navigator.of(context).pop();
              widget.onCompleted?.call();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onClosed?.call();
        return true;
      },
      child: Scaffold(
        appBar: widget.showTitle
            ? AppBar(
                leading: IconButton(
                  onPressed: () => widget.onClosed?.call(),
                  icon: const Icon(Icons.close),
                ),
                title: const Text('Course payment'),
              )
            : null,
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
