import 'package:flutter/material.dart';
import 'empty_page.dart';  // Імпортуємо EmptyPage для переходу
import '../models/user_model.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage({required this.user});
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false, _isPasswordVisible = false;
  late TextEditingController _nameController, _emailController, _passwordController;

  bool _validateName(String name) => RegExp(r'^[a-zA-Z]+$').hasMatch(name);
  bool _validateEmail(String email) => email.contains('@');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  Future<void> _confirmDelete() async {
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('Cancel')
        ),
        TextButton(
          onPressed: () {
            setState(() {
              widget.user.name = '';
              widget.user.email = '';
              widget.user.password = '';
            });
            Navigator.pushAndRemoveUntil(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(builder: (context) => HomePage()),  // Перехід на HomePage після видалення
              (route) => false,  // Очищаємо стек і переходимо лише на HomePage
            );
          }, 
          child: const Text('Delete')
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Переходимо на EmptyPage при натисканні на стрілку
            Navigator.pushAndRemoveUntil(
              context,
              // ignore: inference_failure_on_instance_creation
              MaterialPageRoute(builder: (context) => EmptyPage()),
              (route) => false,  // Очищаємо стек і переходимо лише на EmptyPage
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(Icons.person, size: 40, color: Colors.blue),
                      ),
                      const SizedBox(height: 20),
                      if (_isEditing)
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            errorText: !_validateName(_nameController.text) && _nameController.text.isNotEmpty ? 'Only letters' : null,
                          ),
                        )
                      else
                        Text(widget.user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      if (_isEditing)
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: !_validateEmail(_emailController.text) && _emailController.text.isNotEmpty ? 'Must contain @' : null,
                          ),
                        )
                      else
                        Text(widget.user.email, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 10),
                      if (_isEditing)
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                            ),
                          ),
                        )
                      else
                        Text('Password: ********', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      if (_validateName(_nameController.text) && _validateEmail(_emailController.text)) {
                        widget.user.name = _nameController.text;
                        widget.user.email = _emailController.text;
                        widget.user.password = _passwordController.text;
                        _isEditing = false;
                      }
                    } else {
                      _isEditing = true;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                child: Text(_isEditing ? 'Save Changes' : 'Edit Profile'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: _confirmDelete,
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
