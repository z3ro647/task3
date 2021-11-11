import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/addscreen.dart';
import 'package:task3/screen/detailscreen.dart';
import 'package:task3/screen/editscreen.dart';
import 'package:task3/screen/settingscreen.dart';
import 'package:task3/sql_helper.dart';

class DataTableTutorial extends StatefulWidget {
  const DataTableTutorial({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _DataTableTutorialState createState() => _DataTableTutorialState();
}

class _DataTableTutorialState extends State<DataTableTutorial> {
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
          title: const Text('Data Table Tutorial'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
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
                                        builder: (context) => EditScreen(
                                              id: item['id'], email: 'z3ro647@gmail.com',
                                            )));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteItem(item['id']);
                              },
                            ),
                          ],
                        ),
                      ])
                  ],
                  border: TableBorder.all(width: 1, color: Colors.purple),
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
                                username: 'vivek',
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
              ),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ));
  }
}
