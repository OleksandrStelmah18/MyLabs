import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/profile_page.dart';
import 'screens/empty_page.dart';  // Додайте імпорт
import 'models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User currentUser = User();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lab3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(user: currentUser),
        '/register': (context) => RegisterPage(user: currentUser),
        '/profile': (context) => ProfilePage(user: currentUser),
        '/empty': (context) => EmptyPage(), // Додайте маршрут для нової сторінки
      },
    );
  }
}
