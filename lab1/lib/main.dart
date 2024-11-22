import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 34, 113, 153),
        appBar: AppBar(
          title: Center(child: Text('STELMAKH OLEKSANDR KB-406', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          backgroundColor: Color.fromARGB(255, 106, 165, 95),
        ),
        body: CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  final _controller = TextEditingController();

  void _handleInputChange(String input) {
    setState(() {
      _counter = (input.toLowerCase() == 'avada kedavra') ? 0 : _counter + (int.tryParse(input) ?? 0);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Counter: $_counter', style: TextStyle(fontSize: 28, color: Colors.white)),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter a number or "Avada Kedavra"',
              labelStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            style: TextStyle(color: Colors.white),
            onSubmitted: _handleInputChange,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _handleInputChange(_controller.text),
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueGrey[700],
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
