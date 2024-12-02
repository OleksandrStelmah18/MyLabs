import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../widgets/custom_button.dart';
import 'home_page.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  List<Map<String, dynamic>> apiData = [];

  Future<void> _fetchData() async {
    const apiUrl = 'http://localhost:8000/students/';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        setState(() {
          apiData = data.map((item) {
            return {
              'id': item['id'],
              'fullName': item['fullName'],
              'institute': item['institute'],
              'group': item['group'],
              'subject': item['subject'],
              'instructor': item['instructor'],
              'debtType': item['debtType'],
              'debtStatus': item['debtStatus'],
              'email': item['email']
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      // ignore: inference_failure_on_function_invocation
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showLogoutConfirmationDialog() {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Do you really want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закриваємо діалог
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  // ignore: inference_failure_on_instance_creation
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false, // Виходимо з усіх попередніх сторінок
                );
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _showLogoutConfirmationDialog, // Викликаємо діалогове вікно
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 200,
                  child: CustomButton(
                    title: 'Profile',
                    routeName: '/profile',
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _fetchData,
                    child: const Text('Fetch Data from API'),
                  ),
                  const SizedBox(height: 20),
                  apiData.isEmpty
                      ? const Text('No data available')
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('id')),
                              DataColumn(label: Text('ПІБ')),
                              DataColumn(label: Text('Інститут')),
                              DataColumn(label: Text('Група')),
                              DataColumn(label: Text('Предмет')),
                              DataColumn(label: Text('Викладач')),
                              DataColumn(label: Text('Тип заборгованості')),
                              DataColumn(label: Text('Статус заборгованості')),
                              DataColumn(label: Text('Пошта')),
                            ],
                            rows: apiData.map((item) {
                              return DataRow(cells: [
                                // Перевірка типу для кожного елемента
                                DataCell(Text(item['id'].toString())),
                                DataCell(Text(item['fullName'] != null ? item['fullName'].toString() : '')),
                                DataCell(Text(item['institute'] != null ? item['institute'].toString() : '')),
                                DataCell(Text(item['group'] != null ? item['group'].toString() : '')),
                                DataCell(Text(item['subject'] != null ? item['subject'].toString() : '')),
                                DataCell(Text(item['instructor'] != null ? item['instructor'].toString() : '')),
                                DataCell(Text(item['debtType'] != null ? item['debtType'].toString() : '')),
                                DataCell(Text(item['debtStatus'] != null ? item['debtStatus'].toString() : '')),
                                DataCell(Text(item['email'] != null ? item['email'].toString() : ''))
                              ]);
                            }).toList(),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
