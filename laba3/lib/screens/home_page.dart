import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
