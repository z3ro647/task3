import 'package:flutter/material.dart';
import 'package:task3/screen/addscreen.dart';
import 'package:task3/screen/detailscreen.dart';
import 'package:task3/screen/editscreen.dart';
import 'package:task3/screen/forgotpasswordscreen.dart';
import 'package:task3/screen/homescreen.dart';
import 'package:task3/screen/loginscreen.dart';
import 'package:task3/screen/registerscreen.dart';
import 'package:task3/screen/settingscreen.dart';
import 'package:task3/screen/splashscreen.dart';
import 'package:task3/sql_helper.dart';

class ScreensList extends StatefulWidget {
  const ScreensList({Key? key}) : super(key: key);

  @override
  _ScreensListState createState() => _ScreensListState();
}

class _ScreensListState extends State<ScreensList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen())),
                child: const Text('Splash Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())),
                child: const Text('Login Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen())),
                child: const Text('Register Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword())),
                child: const Text('Forgot Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen(
                              name: 'Vivek',
                              email: 'z3ro647@gmail.com',
                            ))),
                child: const Text('Home Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddScreen(email: 'z3ro647@gmail.com', username: 'vivek',))),
                child: const Text('Add Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditScreen(email: 'z3ro647@gmail.com', id: 1, name: 'vivek',))),
                child: const Text('Edit Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailScreen(id: 2, email: 'z3ro647@gmail.com', name: 'vivek',))),
                child: const Text('Detail Screen')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen(id: 1,))),
                child: const Text('Setting Screen')),
            ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> _user = [];
                  const String user = 'vivek';
                  const String password = '123456';
                  final data =
                      await SQLHelper.getUserUsernamePassword(user, password);
                  _user = data;
                  int l = _user.length;
                  if (l == 1) {
                    print('User exist');
                    List<Map<String, dynamic>> _user1 = [];
                    final data1 = await SQLHelper.getUserByUsername(user);
                    _user1 = data1;
                    print(data1);
                    print(data1[0]['email']);
                  } else {
                    print('User does not exist');
                  }
                },
                child: const Text('Btn')),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Check items')
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('DataTableTutorial'),
            )
          ],
        ),
      ),
    );
  }
}
