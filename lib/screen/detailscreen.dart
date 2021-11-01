import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/sql_helper.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String name = "";
  String text1 = "";
  String text2 = "";
  String text3 = "";

  List<Map<String, dynamic>> _item = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.blue,
        title: const Text(
          'Task 3',
          style: TextStyle(color: Colors.white),
        ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomTextFieldWidget(labeltext: 'Name', hinttext: name),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWidget(labeltext: 'Text 1', hinttext: text1),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWidget(labeltext: 'Text 2', hinttext: text2),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWidget(labeltext: 'Text 3', hinttext: text3),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              color: CustomColor.blue,
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
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
