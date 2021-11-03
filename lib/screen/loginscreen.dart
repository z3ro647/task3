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
      // appBar: AppBar(
      //     backgroundColor: CustomColor.blue,
      //     toolbarHeight: 250,
      //     title: const Center(
      //       child: Text(
      //         'Task 3',
      //         style: TextStyle(fontSize: 25),
      //       ),
      //     )),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 220.0,
            child: Image.asset('assets/images/reward.jpg'),
          ),
          const Text(
            'Login',
            style: TextStyle(fontSize: 20, color: CustomColor.blue),
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
                      icon: Icons.person,
                      obsecure: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginFormWidget(
                      controller: passwordController,
                      labeltext: 'Password',
                      hinttext: 'Password',
                      icon: Icons.lock,
                      obsecure: true,
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()));
              },
              child: const Text(
                'Forgot Password ?',
                style: TextStyle(color: CustomColor.blue),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: 50,
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account yet?"),
              Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: CustomColor.blue),
                      ))),
            ],
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
      required this.obsecure,
      required this.icon})
      : super(key: key);
  final TextEditingController controller;
  final String labeltext;
  final String hinttext;
  final IconData icon;
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
