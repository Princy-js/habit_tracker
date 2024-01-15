import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/database/user_database.dart';
import 'package:habit_tracker/view/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final String? name_from_reg;
  LoginPage({required this.name_from_reg});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordHidden = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/sample logo.png"), width: 100, height: 100,),
            SizedBox(height: 20,),
            Text('LOGIN HERE!', style: GoogleFonts.aclonica(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "UserName",
                  hintText: "username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: passwordHidden,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordHidden = !passwordHidden;
                      });
                    },
                    icon: Icon(passwordHidden ? Icons.visibility_off : Icons.visibility),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  hintText: "password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                await validateLogin();
              },
              color: Colors.grey[200],
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateLogin() async {
    final mail = usernameController.text.trim();
    final pwd = passwordController.text.trim();

    if (mail.isNotEmpty && pwd.isNotEmpty) {
      final users = await UsersHiveDb.user_instance.getUsers();
      bool userFound = users.any((user) => user.email == mail && user.password == pwd);

      if (userFound) {
        Get.offAll(() => HomePage());
        Get.snackbar('SUCCESS!', 'Login Success');
      } else {
        Get.snackbar('ERROR!', 'Login Failed, Invalid Credentials');
      }
    } else {
      Get.snackbar('ERROR!', 'Fields must not be empty');
    }
  }
}
