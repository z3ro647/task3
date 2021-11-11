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

  // void _show(BuildContext ctx, int id, String name, String email) async {
  //   final singleData = await SQLHelper.getOneItemOfUser(id);
  //   String itemName = "";
  //   String text1 = "";
  //   String text2 = "";
  //   String text3 = "";
  //   setState(() {
  //     itemName = singleData[0]['name'];
  //     text1 = singleData[0]['text1'];
  //     text2 = singleData[0]['text2'];
  //     text3 = singleData[0]['text3'];
  //   });
  //   showDialog(
  //     context: ctx,
  //     builder: (_) {
  //       return SimpleDialog(
  //         title: Text('Name: ' + itemName),
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
  //             child: Text('Text 1:' + text1),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
  //             child: Text('Text 2:' + text2),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
  //             child: Text('Text 3:' + text3),
  //           ),
  //           SimpleDialogOption(
  //             child: const Text('Edit'),
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => EditScreen(
  //                             email: email,
  //                             id: id,
  //                           )));
  //             },
  //           ),
  //           SimpleDialogOption(
  //             child: const Text('Delete'),
  //             onPressed: () {
  //               deleteItem(id);
  //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //                 content: Text('Item Deleted Successfully!'),
  //               ));
  //               Navigator.pop(context);
  //               _refreshlist();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.blue,
          title: const Text('Task 3'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                // const SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   'Welcome, Name: ' + widget.name + ', Email: ' + widget.email,
                // ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'ID',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                for (var item in _items)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              debugPrint(item['id'].toString());
                              // _show(context, item['id'], widget.name,
                              //     widget.email);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          email: widget.email,
                                          id: item['id'],
                                          name: widget.name)));
                            },
                            child: Text(
                              item['id'].toString(),
                              style: const TextStyle(
                                  //fontSize: 16.0,
                                  color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              debugPrint(item['id'].toString());
                              // _show(context, item['id'], widget.name,
                              //     widget.email);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          email: widget.email,
                                          id: item['id'],
                                          name: widget.name)));
                            },
                            child: Text(
                              item['name'],
                              style: const TextStyle(
                                  //fontSize: 16.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: CustomColor.blue),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: CustomColor.blue),
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
          ),
        ));
  }
}
