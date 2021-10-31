import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/registerscreen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

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
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
                color: CustomColor.blue,
                onPressed: () {},
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    color: CustomColor.blue,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                    width: 150,
                    child: RaisedButton(
                        color: CustomColor.blue,
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen())),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
