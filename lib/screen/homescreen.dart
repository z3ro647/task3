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
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Text(
            'Welcome, Name: ' + widget.name + ', Email: ' + widget.email,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          //itemlist(context),
          Container(
            height: 400,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) => Card(
                      color: Colors.orange[200],
                      margin: const EdgeInsets.all(15),
                      child: ListTile(
                        title: Text(_items[index]['name']),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                id: _items[index]['id'],
                                              )));
                                  // DetailScreen(id: _items[index]['id']);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditScreen(
                                                email: widget.name,
                                                id: _items[index]['id'],
                                              )));
                                },
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteItem(_items[index]['id']);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Item Deleted Successfully!'),
                                    ));
                                    _refreshlist();
                                  })
                            ],
                          ),
                        ),
                      ),
                    )),
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
                      builder: (context) => const SettingScreen(id: 1,))),
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
      )
    );
  }
}
