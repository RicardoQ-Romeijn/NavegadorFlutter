// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController webController;
  late String url;
  TextEditingController txtController = TextEditingController();
  final Set<String> listaURLS = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 35, 0, 15),
                child: Container(
                  width: MediaQuery.of(context).size.width - 75,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(90, 90, 90, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: TextField(
                      controller: txtController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Buscar ...",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoMono',
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoMono',
                        color: Colors.white,
                        backgroundColor: Color.fromRGBO(90, 90, 90, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 10, 15),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        url = txtController.text;

                        if (url.startsWith("www.")) {
                          url = "https://" + url;
                        } else {
                          if (url.contains(".")) {
                            url = "https://www." + url;
                          } else {
                            url = "https://duckduckgo.com/?t=ffab&q=" + url;
                          }
                        }
                        webController.loadUrl(url);
                        listaURLS.add(url);
                        FocusScope.of(context).unfocus();
                      });
                    },
                    icon: Icon(Icons.search),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: WebView(
              initialUrl: "https://duckduckgo.com/",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                listaURLS.add("https://duckduckgo.com/");
                webController = webViewController;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      webController.goBack();
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_left_sharp),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      webController.loadUrl("https://duckduckgo.com/");
                    });
                  },
                  icon: Icon(Icons.home),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      webController.goForward();
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_right_sharp),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(60, 60, 60, 1),
    );
  }
}
