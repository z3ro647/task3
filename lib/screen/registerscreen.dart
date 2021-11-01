import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/homescreen.dart';
import 'package:task3/screen/loginscreen.dart';
import 'package:task3/sql_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var username = "";
  var email = "";
  var password = "";
  var confirmpassword = "";

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> adduser(String username, String email, String password) async {
    await SQLHelper.createUser(username, email, password);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('User Created Successfully!'),
    ));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.blue,
        title: const Center(
          child: Text('Task 3'),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Register',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInputWidget(
                      controller: usernameController,
                      labeltext: 'Username',
                      hinttext: 'Username'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                      controller: emailController,
                      labeltext: 'Email',
                      hinttext: 'Email'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                      controller: passwordController,
                      labeltext: 'Password',
                      hinttext: 'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                      controller: confirmPasswordController,
                      labeltext: 'Confirm Password',
                      hinttext: 'Confirm Password'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              color: CustomColor.blue,
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  setState(() {
                    username = usernameController.text;
                    email = emailController.text;
                    password = passwordController.text;
                    confirmpassword = confirmPasswordController.text;
                  });
                  adduser(username, email, password);
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Login',
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

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget(
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
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
