import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  late Stream<ConnectivityResult> _connectivityStream;
  bool _isAlertVisible = false;

  HomePageProvider() {
    _connectivityStream = Connectivity().onConnectivityChanged;
    _checkConnectivity(); 
  }

  Stream<ConnectivityResult> get connectivityStream => _connectivityStream;

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
    }
  }

  void showNoInternetDialog(BuildContext context) {
    if (!_isAlertVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // ignore: inference_failure_on_function_invocation
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('No Internet Connection'),
              content: const Text('Please check your internet connection and try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
      _isAlertVisible = true;
    }
  }

  void closeDialog(BuildContext context) {
    if (_isAlertVisible) {
      Navigator.of(context, rootNavigator: true).pop(); 
      _isAlertVisible = false;
    }
  }
}

class _showNoInternetDialog {
}

