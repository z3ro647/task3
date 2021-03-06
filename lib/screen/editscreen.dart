import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/homescreen.dart';
import 'package:task3/sql_helper.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required this.email, required this.id, required this.name})
      : super(key: key);
  
  final String email;
  final String name;
  final int id;

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController text1Controller = TextEditingController();
  TextEditingController text2Controller = TextEditingController();
  TextEditingController text3Controller = TextEditingController();

  String itemName = "";
  String text1 = "";
  String text2 = "";
  String text3 = "";

  List<Map<String, dynamic>> _item = [];

  Future<void> updateitem(int id, String email, String name, String itemName, String text1,
      String text2, String text3) async {
    await SQLHelper.updateSingleItemOfUserForEditing(
        id, itemName, text1, text2, text3);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Item Updated Successfully!'),
    ));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  name: name,
                  email: email,
                )));
  }

  void readData() async {
    final data = await SQLHelper.getOneItemOfUser(widget.id);
    _item = data;
    print(_item);
    setState(() {
      itemName = _item[0]['name'];
      nameController.text = itemName;
      text1 = _item[0]['text1'];
      text1Controller.text = text1;
      text2 = _item[0]['text2'];
      text2Controller.text = text2;
      text3 = _item[0]['text3'];
      text3Controller.text = text3;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.blue,
        title: const Text('Task 3'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Edit Item',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomInputField(
                      controller: nameController,
                      labeltext: 'Name',
                      hinttext: itemName),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                      controller: text1Controller,
                      labeltext: 'Text 1',
                      hinttext: text1),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                      controller: text2Controller,
                      labeltext: 'Text 2',
                      hinttext: text2),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                      controller: text3Controller,
                      labeltext: 'Text 3',
                      hinttext: text3)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: CustomColor.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      itemName = nameController.text;
                      text1 = text1Controller.text;
                      text2 = text2Controller.text;
                      text3 = text3Controller.text;
                    });
                    updateitem(
                        widget.id, widget.email, widget.name, itemName, text1, text2, text3);
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {Key? key,
      required this.controller,
      required this.labeltext,
      required this.hinttext})
      : super(key: key);

  final TextEditingController controller;
  final String labeltext;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        // border: const OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.grey)
        // ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey
          )
        )
      ),
    );
  }
}
