
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tester2/pages/homep_page.dart';
import 'package:tester2/pages/register.dart';
import 'package:tester2/widgets/wid.dart';
import 'package:velocity_x/velocity_x.dart';
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
      body: SingleChildScrollView(
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
                        "assets/images/loderwe.png",
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Welcome $name",
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
                                name = value;
                                setState(() {
                                  email=value;
                                  print(email);
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
                                  print(password);
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
                                  onTap: (){},
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
}
