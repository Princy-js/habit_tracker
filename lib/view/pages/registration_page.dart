import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/database/user_database.dart';
import 'package:habit_tracker/model/users.dart';
import 'package:habit_tracker/view/pages/login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final username_c = TextEditingController();
  final password_c = TextEditingController();
  final name_c = TextEditingController();

  bool passwordhidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/sample logo.png"),
                width: 100,
                height: 100,),
              SizedBox(height: 20,),
              Text('REGISTER HERE !', style: GoogleFonts.aclonica(
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                child: TextField(
                  controller: name_c,
                  decoration: InputDecoration(
                      labelText: "YourName",
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                child: TextField(
                  controller: username_c,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      helperText: "Enter your email",
                      labelText: "UserName",
                      hintText: "username",
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                child: TextFormField(
                  obscureText: passwordhidden,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_person),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          if (passwordhidden == true) {
                            passwordhidden = false;
                          }
                          else {
                            passwordhidden = true;
                          }
                        });
                      }, icon: Icon(passwordhidden == true ?
                      Icons.visibility_off : Icons.visibility)),
                      labelText: "Password",
                      hintText: "password",
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              MaterialButton(
                onPressed: () async {
                  final userlist = await UsersHiveDb.user_instance.getUsers();
                  validateSignup(userlist);
                  // name_c.clear();
                  // username_c.clear();
                  // password_c.clear();
                },
                color: Colors.grey[200],
                child: Text('Register'),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }

  void validateSignup(List<Users> usersList) async{
    final name = name_c.text.trim();
    final email = username_c.text.trim();
    final pswrd = password_c.text.trim();

    final validateEmail = EmailValidator.validate(email);
    final validatePassword = checkPassword(pswrd);

    if(name.isNotEmpty && email.isNotEmpty && pswrd.isNotEmpty){
      if(validateEmail){
        if(validatePassword){
          bool userExists = usersList.any((user) => user.email == email);

          if(userExists){
            Get.snackbar("ERROR!", "User Already Exists!");
          }else{
            final user = Users(email: email, password: pswrd, name: name);
            await UsersHiveDb.user_instance.addUser(user);
            Get.to(()=>LoginPage(name_from_reg: name));
            Get.snackbar("SUCCESS !", "Successfully Registered!!");
          }
        }
      }else{
        Get.snackbar("ERROR!", "Enter a valid email!");
      }
    }else{
      Get.snackbar("ERROR!", "Please fill in all the fields");
    }
  }

  bool checkPassword(String pswrd) {
    if(pswrd.length < 6){
      Get.snackbar("ERROR!", "Password length must be greater than 6");
      return false;
    }else{
      return true;
    }
  }
}


