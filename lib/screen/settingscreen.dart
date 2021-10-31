import 'package:flutter/material.dart';
import 'package:task3/color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            height: 25,
          ),
          const Text(
            'Setting',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Old Password',
                      hintText: 'Old Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      hintText: 'New Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              color: CustomColor.blue,
              onPressed: () {},
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              color: CustomColor.blue,
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              color: CustomColor.blue,
              onPressed: () {},
              child: const Text(
                'Biometrics',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
