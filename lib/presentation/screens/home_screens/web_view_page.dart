import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends ConsumerStatefulWidget {
  WebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  String url;

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends ConsumerState<WebViewPage> {
  late WebViewController controller;
  StateProvider<bool> isLoadingProvider = StateProvider<bool>((ref) => true);

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            ref.read(isLoadingProvider.notifier).state = false;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Column(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : WebViewWidget(
                  controller: controller,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
