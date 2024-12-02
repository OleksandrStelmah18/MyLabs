import 'package:flutter/material.dart';
import 'package:laba3/models/user_model.dart';

class RegisterPage extends StatefulWidget {
  final User user;

  RegisterPage({required this.user});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  // Функція для валідації імені
  bool _validateName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    return nameRegex.hasMatch(name);
  }

  // Функція для валідації email
  bool _validateEmail(String email) {
    return email.contains('@');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: !_validateName(_nameController.text) && _nameController.text.isNotEmpty
                    ? 'Name should only contain letters'
                    : null,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: !_validateEmail(_emailController.text) && _emailController.text.isNotEmpty
                    ? 'Email must contain "@"'
                    : null,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true, // Приховує текст пароля
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    setState(() {
      if (_validateName(_nameController.text) && _validateEmail(_emailController.text)) {
        widget.user.name = _nameController.text;
        widget.user.email = _emailController.text;
        widget.user.password = _passwordController.text;
        Navigator.pushReplacementNamed(context, '/empty');  // Замість /profile, використовуйте /empty
      } else {
        _errorMessage = 'Invalid input. Please check your details.';
      }
    });
  },
  child: const Text('Register'),
),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
