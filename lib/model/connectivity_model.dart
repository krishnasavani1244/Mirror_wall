import 'dart:async';

class ConnectivityModel {
  String ConnectivityStatus;
  StreamSubscription? connectivityStream;

  ConnectivityModel({
    required this.ConnectivityStatus,
    this.connectivityStream,
});
}