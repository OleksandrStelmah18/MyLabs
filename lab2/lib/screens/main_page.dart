import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class mainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Main Page',
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(title: 'Login', routeName: '/login'),
            SizedBox(height: 16),
            CustomButton(title: 'Profile', routeName: '/profile'),
          ],
        ),
      ),
    );
  }
}
