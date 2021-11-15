import 'package:flutter/material.dart';
import 'package:task3/color.dart';
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

  Future<void> checkuser(String username, String email, String password) async {
    final dataUser = await SQLHelper.getUserByUsername(username);
    final dataEmail = await SQLHelper.getUserByEmail(email);
    int i, j;
    i = dataUser.length;
    j = dataEmail.length;
    if (i >= 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Username already exist'),
      ));
    } else if (j >= 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email already exist'),
      ));
    } else {
      adduser(username, email, password);
    }
  }

  Future<void> adduser(String username, String email, String password) async {
    await SQLHelper.createUser(username, email, password);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('User Created Successfully!'),
    ));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
  
  bool _isObscure1 = true;
  bool _isObscure2 = true;

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
                      hinttext: 'Username',
                      icon: Icons.person_outline,  
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputWidget(
                      controller: emailController,
                      labeltext: 'Email',
                      hinttext: 'Email',
                      icon: Icons.mail_outline  
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  // CustomInputWidget(
                  //     controller: passwordController,
                  //     labeltext: 'Password',
                  //     hinttext: 'Password',
                  //     icon: Icons.lock_outline,
                  //   ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 6 ) {
                        return 'Password must be atleast 6 character';
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    obscureText: _isObscure1,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Passowrd',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
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
                    obscureText: _isObscure2,
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
                  // CustomInputWidget(
                  //     controller: confirmPasswordController,
                  //     labeltext: 'Confirm Password',
                  //     hinttext: 'Confirm Password',
                  //     icon: Icons.lock_outline,  
                  //   ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
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
                      username = usernameController.text;
                      email = emailController.text;
                      password = passwordController.text;
                      confirmpassword = confirmPasswordController.text;
                    });
                    if (password ==confirmpassword) {
                      checkuser(username, email, password);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Password and Confirm Password dosen't matched"),
                      ));
                    }
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
      required this.hinttext, required this.icon})
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
          if(value.length < 5) {
            return 'Username must be atleast 5 character';
          }
        } else if (labeltext == 'Email') {
          if(!value.contains('@')) {
            return 'Invalid Email address';
          }
        } else if (labeltext == 'Password') {
          if(value.length < 6) {
            return 'Password must be atleast 6 character';
          }
        } else if (labeltext == 'Confirm Password') {
          if(value.length < 6) {
            return 'Confirm Password must be atleast 6 character';
          }
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        prefixIcon: Icon(
          icon
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
      ),
    );
  }
}
