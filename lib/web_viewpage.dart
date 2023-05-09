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
  var SelectedOption = "Option 1";
  List bookMark =[];
  List urlBookmark1 =[];
  String urlBookmark = "";

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
        }
    );
  }

  late var url;
  var initialUrl = "https://www.google.com/";
  String? initialpopmenuval;

  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
              icon: Icon(Icons.more_vert,
                  color: Colors.black),
              itemBuilder: (context)=>[
                PopupMenuItem(
                  value: "Option1",
                  child: Row(
                    children: const [
                      Icon(Icons.bookmark,
                          color: Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      Text("All BookMark"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "Option2",
                  child: Row(
                    children: const [
                      Icon(Icons.screen_search_desktop_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Search Engine"),
                    ],
                  ),
                ),
              ],
              onSelected: (selectedOption){
                setState(() {
                  SelectedOption = selectedOption;
                });
                if (selectedOption == "Option 1") {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context){
                      return Container(
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(
                                                Icons.close
                                            ),
                                          ),
                                          Text(
                                            "Dismiss",
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Expanded(
                              flex: 10,
                              child: Container(
                                child: ListView.builder(
                                  itemCount: bookMark.length,
                                  itemBuilder: (context,i) => ListTile(
                                    title: Text("${urlBookmark1[i]}"),
                                    trailing: IconButton(onPressed: (){
                                      setState(() {
                                        bookMark.remove(urlBookmark1[i]);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }else if (selectedOption == "Option 2") {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Search Engine"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                                title: Text("Google"),
                                value: "https://www.google.com/",
                                groupValue: initialUrl ,
                                onChanged: (val) {
                                  setState(() {
                                    urlController.clear();
                                    initialUrl = val!;
                                  });
                                  inAppWebViewController!.loadUrl(
                                      urlRequest: URLRequest(
                                        url: Uri.parse(initialUrl),
                                      )
                                  );
                                  Navigator.of(context).pop();
                                }
                            ),
                            RadioListTile(
                              title: Text("Yahoo"),
                              value: "https://www.yahoo.com/?guccounter=1",
                              groupValue: initialUrl,
                              onChanged: (val){
                                setState(() {
                                  urlController.clear();
                                  initialUrl = val!;
                                });
                                inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(initialUrl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: Text("Bing"),
                              value: "https://www.bing.com/",
                              groupValue: initialUrl,
                              onChanged: (val){
                                setState(() {
                                  urlController.clear();
                                  initialUrl = val!;
                                });
                                inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(initialUrl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: Text("Duck Duck Go"),
                              value: "https://duckduckgo.com/",
                              groupValue: initialUrl,
                              onChanged: (val){
                                setState(() {
                                  urlController.clear();
                                  initialUrl = val!;
                                });
                                inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(initialUrl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  );
                }
              }
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 20,
            child: InAppWebView(
              pullToRefreshController: pullToRefreshController,
              onLoadStart: (controller,Uri) {
                setState(() {
                  inAppWebViewController = controller;
                  var v = url.toString();
                  setState(() {
                    urlController.text = v;
                  });
                });
              },
              onLoadStop: (controller,Uri) async{
                await pullToRefreshController.endRefreshing();
              },
              onWebViewCreated: (controller) => inAppWebViewController = controller,
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: urlController,
                onSubmitted: (val){
                  url = Uri.parse(val);
                  if (url.scheme.isEmpty) {
                    url = Uri.parse("${initialUrl}search?q = $val");
                  }
                  inAppWebViewController!.loadUrl(urlRequest: URLRequest(url: url),
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
                  onPressed: ()async{
                    await inAppWebViewController!.loadUrl(
                        urlRequest: URLRequest(
                            url: Uri.parse(initialUrl)));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_add_outlined),
                  onPressed: ()async{
                    await inAppWebViewController?.getUrl();


                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: ()async{
                    if(await inAppWebViewController!.canGoBack()) {
                      await inAppWebViewController!.goBack();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: ()async{
                    await inAppWebViewController!.reload();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: ()async{
                    if(await inAppWebViewController!.canGoForward()) {
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



