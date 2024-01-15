import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/pages/login_page.dart';
import 'package:habit_tracker/view/pages/registration_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 100),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ready to unlock your potential? ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Track your habits, Smash your goals, and become the best version of yourself. Start your Journey....! ',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Not a user?Register here'),
                    MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        Get.offAll(() => RegistrationPage());
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text('Already have an account?'),
                    MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        Get.off(()=>LoginPage(name_from_reg:'',));
                      },
                      child: Text('Login'),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
