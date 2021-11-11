import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/editscreen.dart';
import 'package:task3/screen/homescreen.dart';
import 'package:task3/sql_helper.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {Key? key, required this.id, required this.email, required this.name})
      : super(key: key);

  final int id;
  final String email;
  final String name;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String name = "";
  String text1 = "";
  String text2 = "";
  String text3 = "";

  List<Map<String, dynamic>> _item = [];

  void deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
  }

  void readData() async {
    final data = await SQLHelper.getOneItemOfUser(widget.id);
    _item = data;
    print(_item);
    setState(() {
      name = _item[0]['name'];
      text1 = _item[0]['text1'];
      text2 = _item[0]['text2'];
      text3 = _item[0]['text3'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(name),
            content: const Text('Do you want to edit or delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditScreen(
                                name: widget.name,
                                email: widget.email,
                                id: widget.id,
                              )));
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteItem(widget.id);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Item Deleted Successfully!'),
                  ));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                              name: widget.name, email: widget.email)));
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.blue,
        title: const Text(
          'Task 3',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          // IconButton(
          //   onPressed: () {
          //     _showDialog(context);
          //   },
          //   icon: const Icon(Icons.edit_outlined),
          // )
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditScreen(
                                name: widget.name,
                                email: widget.email,
                                id: widget.id,
                              )));
                } else if (value == 'delete') {
                  deleteItem(widget.id);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Item Deleted Successfully!'),
                  ));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                              name: widget.name, email: widget.email)));
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Edit"),
                      value: 'edit',
                    ),
                    const PopupMenuItem(
                      child: Text("Delete"),
                      value: 'delete',
                    )
                  ])
        ],
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Detail Screen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomCard(label: 'Name', text: name),
          CustomCard(label: 'Text 1', text: text1),
          CustomCard(label: 'Text 2', text: text2),
          CustomCard(label: 'Text 3', text: text3),
          // const SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 40),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       primary: CustomColor.blue,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => EditScreen(
          //                     name: widget.name,
          //                     email: widget.email,
          //                     id: widget.id,
          //                   )));
          //     },
          //     child: const Text(
          //       'Edit',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 40),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(primary: CustomColor.blue),
          //     onPressed: () {
          //       deleteItem(widget.id);
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Text('Item Deleted Successfully!'),
          //       ));
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => HomeScreen(
          //                   name: widget.name, email: widget.email)));
          //     },
          //     child: const Text(
          //       'Delete',
          //       style:
          //           TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget(
      {Key? key, required this.labeltext, required this.hinttext})
      : super(key: key);

  final String labeltext;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.text, required this.label})
      : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
