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

  TextEditingController oldPasswordController = TextEditingController();
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
      if (oldPassword.contains(op)) {
        await SQLHelper.updatePassword(id, confirmPassword);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password Updated Successfully'),
        ));
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

  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;

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
                      } else if (value.length < 6) {
                        return 'Old Password must be atleast 6 character';
                      }
                      return null;
                    },
                    controller: oldPasswordController,
                    obscureText: _isObscure1,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      hintText: 'Old Passowrd',
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure1
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure1 = !_isObscure1;
                            });
                          }),
                    ),
                  ),
                  //CustomInputField(controller: oldPasswordController, labeltext: 'Old Password', hinttext: 'Old Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6 ) {
                        return 'New Password must be atleast 6 character';
                      }
                      return null;
                    },
                    controller: newPasswordController,
                    obscureText: _isObscure2,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'New Passowrd',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure2
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          }),
                    ),
                  ),
                  //CustomInputField(controller: newPasswordController, labeltext: 'New Password', hinttext: 'New Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6 ) {
                        return 'Confirm Password must be atleast 6 character';
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    obscureText: _isObscure3,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Passowrd',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure3
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure3 = !_isObscure3;
                            });
                          }),
                    ),
                  ),
                  //CustomInputField(controller: confirmPasswordController, labeltext: 'Confirm Password', hinttext: 'Confirm Password')
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: CustomColor.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  setState(() {
                    oldPassword = oldPasswordController.text;
                    newPassword = newPasswordController.text;
                    confirmPassword = confirmPasswordController.text;
                  });
                  changePassword(
                      widget.id, oldPassword, newPassword, confirmPassword);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: CustomColor.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: CustomColor.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                child: const Text(
                  'Biometrics',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
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
        if (labeltext == 'Old Password') {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        } else if (labeltext == 'New Password') {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        } else if (labeltext == 'Confirm Password') {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
