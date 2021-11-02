import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/forgotpasswordscreen.dart';
import 'package:task3/screen/homescreen.dart';
import 'package:task3/screen/registerscreen.dart';
import 'package:task3/sql_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var usernameOremail = "";
  var pass = "";

  TextEditingController usernameOremailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> searchUser(String usernameOremail, String password) async {
    List<Map<String, dynamic>> _username = [];
    List<Map<String, dynamic>> _email = [];
    final dataUsername =
        await SQLHelper.getUserUsernamePassword(usernameOremail, password);
    _username = dataUsername;
    int l = _username.length;
    final dataEmail =
        await SQLHelper.getUserEmailPassword(usernameOremail, password);
    _email = dataEmail;
    int k = _email.length;
    if (l == 1) {
      print('User exist');
      final data = await SQLHelper.getUserByUsername(usernameOremail);
      print(data[0]['email']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    name: usernameOremail,
                    email: data[0]['email'],
                  )));
    } else if (k == 1) {
      print('User exist');
      final data = await SQLHelper.getUserByEmail(usernameOremail);
      print(data[0]['username']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                  name: data[0]['username'], email: usernameOremail)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User Not Found'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CustomColor.blue,
          toolbarHeight: 250,
          title: const Center(
            child: Text(
              'Task 3',
              style: TextStyle(fontSize: 25),
            ),
          )),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Login',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoginFormWidget(
                      controller: usernameOremailController,
                      labeltext: 'Username/Email',
                      hinttext: 'Username/Email',
                      obsecure: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginFormWidget(
                      controller: passwordController,
                      labeltext: 'Password',
                      hinttext: 'Password',
                      obsecure: true,
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 140,
                  child: RaisedButton(
                    color: CustomColor.blue,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          usernameOremail = usernameOremailController.text;
                          pass = passwordController.text;
                        });
                        searchUser(usernameOremail, pass);
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: RaisedButton(
                      color: CustomColor.blue,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword())),
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                )
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
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen())),
              child: const Text(
                'Register',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget(
      {Key? key,
      required this.controller,
      required this.labeltext,
      required this.hinttext,
      required this.obsecure})
      : super(key: key);
  final TextEditingController controller;
  final String labeltext;
  final String hinttext;
  final bool obsecure;

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
      obscureText: obsecure,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
