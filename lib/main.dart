import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pr/cntroller/provider/connectivity_provider.dart';
import 'package:pr/web_viewpage.dart';

import 'package:provider/provider.dart';

import 'home_page.dart';



void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
      ),
    ],
    builder: (context,_){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => home_page(),
          '/' : (context) => web_viewpage(),
        },
      );
    },
  )
  );
}





