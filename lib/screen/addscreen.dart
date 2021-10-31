import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/sql_helper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var txt1 = "";
  var txt2 = "";
  var txt3 = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController text1Controller = TextEditingController();
  TextEditingController text2Controller = TextEditingController();
  TextEditingController text3Controller = TextEditingController();

  Future<void> additem(String email, String name, String text1, String text2, String text3) async {
    //print('Email: '+email+' , Name: '+name+', Text1'+txt1+' ,Text2'+txt2+' ,Text3'+txt3);
    await SQLHelper.createItem(email, name, text1, text2, text3);
    print('Item Added');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.email);
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
            'Add Item',
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
                  CustomInputWidget(
                    labeltext: 'Name',
                    hinttext: 'Name',
                    controller: nameController
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                    labeltext: 'Text 1',
                    hinttext: 'Text 1',
                    controller: text1Controller
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                    labeltext: 'Text 2',
                    hinttext: 'Text 2',
                    controller: text2Controller
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                    labeltext: 'Text 3',
                    hinttext: 'Text 3',
                    controller: text3Controller
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child:
                RaisedButton(
                  color: CustomColor.blue,
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      setState(() {
                        name = nameController.text;
                        txt1 = text1Controller.text;
                        txt2 = text2Controller.text;
                        txt3 = text3Controller.text;
                      });
                      additem(widget.email, name, txt1, txt2, txt3);
                    }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                )
              ),
          )
        ],
      ),
    );
  }
}

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget({Key? key, required this.labeltext, required this.hinttext, required this.controller}) : super(key: key);

  final String labeltext;
  final String hinttext;
  final TextEditingController controller;

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
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
