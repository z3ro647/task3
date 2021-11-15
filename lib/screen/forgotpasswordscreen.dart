import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/registerscreen.dart';
import 'package:task3/sql_helper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String email = "";
  String username = "";
  String newPassword = "";

  Future<void> passwordReset(
      String username, String email, String newpassword) async {
    final data = await SQLHelper.readUsernameAndEmail(username, email);
    int l = data.length;
    if (l == 1) {
      await SQLHelper.forgotPassword(username, email, newpassword);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password changed successfully!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Username and Email does not match!'),
      ));
    }
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.blue,
        title: const Center(child: Text('Task 3')),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Forgot Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
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
                  CustomInputWidget(
                      controller: usernameController,
                      labeltext: 'Username',
                      hinttext: 'Username',
                      icon: Icons.person_outline),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                      controller: emailController,
                      labeltext: 'Email',
                      hinttext: 'Email',
                      icon: Icons.email_outlined),
                  const SizedBox(
                    height: 20,
                  ),
                  // CustomInputWidget(
                  //     controller: newPasswordController,
                  //     labeltext: 'New Password',
                  //     hinttext: 'New Password',
                  //     icon: Icons.lock_outline)
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6) {
                        return 'New Password must be atleast 6 character';
                      }
                      return null;
                    },
                    controller: newPasswordController,
                    obscureText: _isObscure,
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
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: CustomColor.blue),
                  )),
            ],
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
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        username = usernameController.text;
                        email = emailController.text;
                        newPassword = newPasswordController.text;
                      });
                      passwordReset(username, email, newPassword);
                    }
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account yet?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: CustomColor.blue),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget(
      {Key? key,
      required this.controller,
      required this.labeltext,
      required this.hinttext,
      required this.icon})
      : super(key: key);

  final TextEditingController controller;
  final String labeltext;
  final String hinttext;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (labeltext == 'Username') {
          if (value.length < 5) {
            return 'Username must be atleast 5 character';
          }
        } else if (labeltext == 'Email') {
          if (!value.contains('@')) {
            return 'Invalid Email address';
          }
        } else if (labeltext == 'New Password') {
          if (value.length < 6) {
            return 'New Password must be atleast 6 character';
          }
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        prefixIcon: Icon(
          icon,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }
}
