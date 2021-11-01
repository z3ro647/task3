import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/loginscreen.dart';
import 'package:task3/sql_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordCOntroller = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String oldPassword = "";
  String newPassword = "";
  String confirmPassword = "";

  Future<void> changePassword(int id, String oldPasswrod, String newPassword,
      String confirmPassword) async {
    if (newPassword.contains(confirmPassword)) {
      final data = await SQLHelper.readOldPassword(id);
      var op = data[0]['password'];
      if(oldPassword.contains(op)) {
        await SQLHelper.updatePassword(id, confirmPassword);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Old Password Does not Match'),
      ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Old Password and Confirm Password Does not Match'),
      ));
    }
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
            height: 25,
          ),
          const Text(
            'Setting',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
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
                    controller: oldPasswordCOntroller,
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
                    controller: newPasswordController,
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
                    controller: confirmPasswordController,
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
              onPressed: () {
                setState(() {
                  oldPassword = oldPasswordCOntroller.text;
                  newPassword = newPasswordController.text;
                  confirmPassword = confirmPasswordController.text;
                });
                changePassword(
                    widget.id, oldPassword, newPassword, confirmPassword);
              },
              child: const Text(
                'Submit',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Text(
                'Logout',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
