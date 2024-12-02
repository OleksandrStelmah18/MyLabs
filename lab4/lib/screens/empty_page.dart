import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'home_page.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  List<Map<String, String>> students = [
    {
      'ПІБ': 'Стельмах О.В.',
      'Інститут': 'ІКТА',
      'Група': 'КБ-406',
      'Предмет': 'Розробка моб. додатків',
      'Викладач': 'Верес З.Є.',
      'Тип заборгованості': 'Лабораторна робота',
      'Статус заборгованості': 'Не здано',
      'Кінцевий термін ліквідації': '01.12.2024',
      'Пошта студента': 'oleksandr.stelmakh.kb.2021@lpnu.ua',
    },
  ];

  void _addStudent() {
    setState(() {
      students.add({
        'ПІБ': '',
        'Інститут': '',
        'Група': '',
        'Предмет': '',
        'Викладач': '',
        'Тип заборгованості': '',
        'Статус заборгованості': '',
        'Кінцевий термін ліквідації': '',
        'Пошта студента': '',
      });
    });
  }

  void _removeStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  // Функція для показу діалогового вікна підтвердження виходу
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'ЗАБОРГОВАНОСТІ СТУДЕНТІВ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5, // Трохи відстані між літерами
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DataTable(
                        headingRowHeight: 56.0, 
                        dataRowHeight: 70.0, 
                        border: TableBorder.all(color: Colors.grey, width: 1),
                        columns: _buildColumns(),
                        rows: _buildRows(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addStudent, 
                    child: const Text('Додати студента'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return const [
      DataColumn(label: Text('ПІБ')),
      DataColumn(label: Text('Інститут')),
      DataColumn(label: Text('Група')),
      DataColumn(label: Text('Предмет')),
      DataColumn(label: Text('Викладач')),
      DataColumn(label: Text('Тип заборгованості')),
      DataColumn(label: Text('Статус заборгованості')),
      DataColumn(label: Text('Кінцевий термін ліквідації')),
      DataColumn(label: Text('Пошта студента')),
      DataColumn(label: Text('Дії')),
    ];
  }

  List<DataRow> _buildRows() {
    return students
        .asMap()
        .map(
          (index, student) => MapEntry(
            index,
            DataRow(
              cells: [
                ...student.entries.map((entry) {
                  return DataCell(
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        initialValue: entry.value,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        maxLines: null,  
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontSize: 14),
                        onChanged: (newValue) {
                          setState(() {
                            student[entry.key] = newValue;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeStudent(index),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        )
        .values
        .toList();
  }
}
