import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/addscreen.dart';
import 'package:task3/screen/detailscreen.dart';
import 'package:task3/screen/editscreen.dart';
import 'package:task3/screen/settingscreen.dart';
import 'package:task3/sql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.name, required this.email})
      : super(key: key);
  final String name;
  final String email;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // All items
  List<Map<String, dynamic>> _items = [];

  void deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
  }

  void _refreshlist() async {
    final data = await SQLHelper.getAllItemsbyEmail(widget.email);
    setState(() {
      _items = data;
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _refreshlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.blue,
          title: const Text('Task 3'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome, Name: ' + widget.name + ', Email: ' + widget.email,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: const {
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth()
                  },
                  children: [
                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('name'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Action'),
                      )
                    ]),
                    for (var item in _items)
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item['name']),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              id: item['id'],
                                            )));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              id: item['id'],
                                            )));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              id: item['id'],
                                            )));
                              },
                            ),
                          ],
                        ),
                      ])
                  ],
                  border: TableBorder.all(width: 1, color: CustomColor.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: RaisedButton(
                  color: CustomColor.blue,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddScreen(
                                email: widget.email,
                                username: widget.name,
                              ))),
                  child: const Text(
                    'Add Item',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: RaisedButton(
                  color: CustomColor.blue,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingScreen(
                                id: 1,
                              ))),
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
