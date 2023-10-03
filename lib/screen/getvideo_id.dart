import 'package:flutter/material.dart';
import 'package:no_interrupt/screen/web_viewhelper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class getvideo extends StatefulWidget {
  const getvideo({Key? key}) : super(key: key);

  @override
  State<getvideo> createState() => _getvideoState();
}

class _getvideoState extends State<getvideo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Web View'),
        ),
        body:
           WebViewStack(),

    );
  }

}
