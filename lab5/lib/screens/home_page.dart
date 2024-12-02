import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lab4/widgets/custom_button.dart';
import 'package:lab4/providers/home_page_provider.dart'; 

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homePageProvider = Provider.of<HomePageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, 'Login', '/login'),
            StreamBuilder<ConnectivityResult>(
              stream: homePageProvider.connectivityStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == ConnectivityResult.none) {
                    homePageProvider.showNoInternetDialog(context);
                  } else {
                    homePageProvider.closeDialog(context);
                  }
                }
                return Container(); 
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String routeName) {
    return SizedBox(
      width: 200,
      child: CustomButton(
        title: title,
        routeName: routeName,
      ),
    );
  }
}
