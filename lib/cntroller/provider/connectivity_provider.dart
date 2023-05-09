import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:pr/model/connectivity_model.dart';

class ConnectivityProvider extends ChangeNotifier {
  Connectivity connnectivity = Connectivity();

  ConnectivityModel connectivityModel = ConnectivityModel(ConnectivityStatus: "waiting");
}