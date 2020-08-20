import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContributeWebView extends StatefulWidget {

  @override
  _ContributeWebViewState createState() => _ContributeWebViewState();
}

class _ContributeWebViewState extends State<ContributeWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  // get webLink => this.webLink;

  @override
  Widget build(BuildContext context) {
    var webLink = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter otp'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          // actions: <Widget>[
          //   NavigationControls(_controller.future),
          //   SampleMenu(_controller.future),
          // ],
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: WebView(
            initialUrl: webLink,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            }));
  }
}
