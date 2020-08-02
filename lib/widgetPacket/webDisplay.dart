import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class Affiche extends StatelessWidget {
  final _url;
  final _title;


  Affiche(this._url, this._title);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(

      url: _url,
      appBar: AppBar(
        title: Text(_title),

        centerTitle: true,
      ),

      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
    );
  }
}


