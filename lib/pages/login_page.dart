
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tester2/pages/homep_page.dart';
import 'package:tester2/pages/register.dart';
import 'package:tester2/widgets/wid.dart';
import 'package:velocity_x/velocity_x.dart';

import '../helper/helper_function.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name="";
  String email ="";
  String password="";
  bool changeButton = false;
  bool _isLoading = false;
  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  // Movetohome(BuildContext context)async{
  //   if(formKey.currentState!.validate()) {
  //     setState(() {
  //       changeButton = true;
  //     });
  //
  //     await Future.delayed(const Duration(seconds: 1));
  //     await Navigator.pushNamed(context, HomePage() as String);
  //     setState(() {
  //       changeButton = false;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),):SingleChildScrollView(
        child: SafeArea(
           child: Container(
             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 60),
              child: Form(
                key: formKey,
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      "The Sideline".text.size(30).bold.make(),
                      SizedBox(height: 7,),
                      "Login now to know what is being cooked!".text.size(18).fontWeight(FontWeight.w400).make(),
                      SizedBox(height: 10,),
                      Image.asset(
                        "assets/images/aweqr.jpg",
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Welcome",
                        style:  const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent,width: 1)
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter the Email",
                                  labelText: "Email"
                              ),
                                 validator: (value){
                                  if (value!.isEmpty){
                                      return"Email can't be empty";
                                  }
                                   return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)?null:"enter the valid email";
                                  },
                              onChanged: (value) {
                                setState(() {
                                  email=value;
                                });
                              },

                            ),
                            SizedBox(height: 6,),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent,width: 1)
                              ),
                                  hintText: "Enter the password",prefixIcon: Icon(Icons.password), labelText: "Password"),
                              validator: (value){
                                if (value!.isEmpty){
                                  return"Password can't be empty";
                                }
                                else if(value.length<6){
                                  return "password length is too small";
                                }
                                return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                                    .hasMatch(value!)?null:"Enter the valid password";
                              },
                              onChanged: (value) {
                                setState(() {
                                  password=value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Material(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                                child: InkWell(
                                  // splashColor: Colors.red,
                                  //   onTap: ()=> Movetohome(context),
                                  onTap: (){login();},
                                    child: AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      width: changeButton ? 60 : 150,
                                      height: 50,
                                      alignment: Alignment.center,
                                      // child: changeButton
                                      //     ? const Icon(
                                      //   Icons.done,
                                      //   color: Colors.white,
                                      // ):
                                        child:   const Text(
                                        "Log in",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ))
                            ),
                            const SizedBox(height: 8,),
                            Text.rich(TextSpan(
                              text: "Don't have an account?",
                              style: const TextStyle(color: Colors.black,fontSize: 16),
                              children:<TextSpan>[
                                TextSpan(text: "Register hear",
                                    style: const TextStyle(color: Colors.black,decoration: TextDecoration.underline)
                                ,recognizer: TapGestureRecognizer()..onTap=(){
                                  nextScreen(context, const RegisterPage());
                                    }),
                              ]
                            ))
                          ],
                        ),
                      )
            ],
          )
      ),
      )
      )
      )
    );
  }
  login()async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.blueAccent, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
