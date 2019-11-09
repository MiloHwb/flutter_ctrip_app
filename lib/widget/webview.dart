import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/6 21:51
 * @ 描述         
 */

const List<String> CACHE_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
  'm.ctrip.com/webapp/you/'
];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool isExit = false;

  @override
  void initState() {
    super.initState();
    webViewReference.close();
    _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {});
    _onStateChanged = webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      print('state.url = ' + state.url);
      switch (state.type) {
        case WebViewState.shouldStart:
          if (_isToMain(state.url)) {
            if (widget.backForbid && !isExit) {
              Navigator.of(context).pop();
              isExit = true;
            } else {
              webViewReference.reloadUrl(widget.url);
            }
          }
          break;
        case WebViewState.startLoad:
          break;
        case WebViewState.finishLoad:
          break;
        case WebViewState.abortLoad:
          break;
      }
    });
    _onHttpError = webViewReference.onHttpError.listen((WebViewHttpError httpError) {
      print(httpError);
    });
  }

  bool _isToMain(String url) {
    bool contains = false;
    for (var value in CACHE_URLS) {
      if (url?.endsWith(value) ?? false) {
        contains = true;
        break;
      }
    }
    return contains;
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webViewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          appBar(context, Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: false,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context, Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: MediaQuery.of(context).padding.top,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backgroundColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(
                    color: backButtonColor,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
