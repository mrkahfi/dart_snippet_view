import 'package:dart_style/dart_style.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DartSnippetView extends StatefulWidget {
  final double height;
  final double width;
  final String code;
  final bool runFormatter;
  const DartSnippetView({
    super.key,
    required this.height,
    required this.width,
    required this.code,
    this.runFormatter = false,
  });

  @override
  State<DartSnippetView> createState() => _DartSnippetViewState();
}

class _DartSnippetViewState extends State<DartSnippetView> {
  String? code;
  late WebViewController controller;

  @override
  void initState() {
    if (widget.runFormatter) {
      code = DartFormatter().format(widget.code);
    } else {
      code = widget.code;
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(code ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
    // return WebViewWidget(
    //   height: widget.height,
    //   width: widget.width,
    //   onWebViewCreated: (controller) {
    //     controller.loadContent(
    //       'packages/dart_snippet_view/assets/code_viewer.html',
    //       fromAssets: true,
    //     );
    //     // Image.asset('name',package: '',);

    //     Future.delayed(const Duration(seconds: 1), () {
    //       controller.callJsMethod('updateCodeContent', [code]);
    //     });
    //   },
    // );
  }
}
