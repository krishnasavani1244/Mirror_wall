import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class web_viewpage extends StatefulWidget {
  const web_viewpage({Key? key}) : super(key: key);

  @override
  State<web_viewpage> createState() => _web_viewpageState();
}

class _web_viewpageState extends State<web_viewpage> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  double progress = 0;
  var urlController = TextEditingController();




  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.blue,
        ),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
  }

  late var url;
  var initialUrl = "https://www.google.com/";
  String? initialpopmenuval;

  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Browser",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton(
              initialValue: initialpopmenuval,
              onSelected: (val) {
                setState(() {
                  initialpopmenuval = val;
                });
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.bookmark,
                        ),
                      ),
                      Text("All BookMark"),
                    ],
                  )),
                  PopupMenuItem(
                      child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                    actions: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text("Search engine"),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RadioListTile(title: Text("Google"),
                                                value:
                                                    "https://www.google.com/",
                                                groupValue: initialUrl,
                                                onChanged: (val) {
                                                  setState(() {
                                                    urlController.clear();
                                                    initialUrl = val!;
                                                  });
                                                  inAppWebViewController!
                                                      .loadUrl(
                                                          urlRequest:
                                                              URLRequest(
                                                    url: Uri.parse(initialUrl),
                                                  ));
                                                }),
                                            RadioListTile(title: Text("Yahoo"),
                                                value:
                                                "https://www.yahoo.com/?guccounter=1",
                                                groupValue: initialUrl,
                                                onChanged: (val) {
                                                  setState(() {
                                                    urlController.clear();
                                                    initialUrl = val!;
                                                  });
                                                  inAppWebViewController!
                                                      .loadUrl(
                                                      urlRequest:
                                                      URLRequest(
                                                        url: Uri.parse(initialUrl),
                                                      ));
                                                }),
                                            RadioListTile(title: Text("Bing"),
                                                value:
                                                "https://www.bing.com/",
                                                groupValue: initialUrl,
                                                onChanged: (val) {
                                                  setState(() {
                                                    urlController.clear();
                                                    initialUrl = val!;
                                                  });
                                                  inAppWebViewController!
                                                      .loadUrl(
                                                      urlRequest:
                                                      URLRequest(
                                                        url: Uri.parse(initialUrl),
                                                      ));
                                                }),
                                            RadioListTile(title: Text("Duck Duck Go"),
                                                value:
                                                "https://duckduckgo.com/",
                                                groupValue: initialUrl,
                                                onChanged: (val) {
                                                  setState(() {
                                                    urlController.clear();
                                                    initialUrl = val!;
                                                  });
                                                  inAppWebViewController!
                                                      .loadUrl(
                                                      urlRequest:
                                                      URLRequest(
                                                        url: Uri.parse(initialUrl),
                                                      ));
                                                }),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                              });
                        },
                        icon: Icon(
                          CupertinoIcons.search,
                        ),
                      ),
                      Text("Search Engine")
                    ],
                  ))
                ];
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 20,
            child: InAppWebView(
              pullToRefreshController: pullToRefreshController,
              onLoadStart: (controller, Uri) {
                setState(() {
                  inAppWebViewController = controller;
                  var v = url.toString();
                  setState(() {
                    urlController.text = v;
                  });
                });
              },
              onLoadStop: (controller, Uri) async {
                await pullToRefreshController.endRefreshing();
              },
              onWebViewCreated: (controller) =>
                  inAppWebViewController = controller,
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: urlController,
                onSubmitted: (val) {
                  url = Uri.parse(val);
                  if (url.scheme.isEmpty) {
                    url = Uri.parse("${initialUrl}search?q = $val");
                  }
                  inAppWebViewController!.loadUrl(
                    urlRequest: URLRequest(url: url),
                  );
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search or type of web address",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () async {
                    await inAppWebViewController!.loadUrl(
                        urlRequest: URLRequest(url: Uri.parse(initialUrl)));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_add_outlined),
                  onPressed: () async {
                    await inAppWebViewController?.getUrl();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () async {
                    if (await inAppWebViewController!.canGoBack()) {
                      await inAppWebViewController!.goBack();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    await inAppWebViewController!.reload();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    if (await inAppWebViewController!.canGoForward()) {
                      await inAppWebViewController!.goForward();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
