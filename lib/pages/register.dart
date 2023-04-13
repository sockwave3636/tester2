import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tester2/pages/login_page.dart';
import 'package:tester2/service/auth_service.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:tester2/helper/helper_function.dart';
import '../widgets/wid.dart';
import 'homep_page.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  String email ="";
  String fullName ="";
  String password="";
  bool changeButton = false;
  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:_isLoading?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),):
        SingleChildScrollView(
            child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "The Sideline".text.size(30).bold.make(),
                          SizedBox(height: 6,),
                          "Create an account to chat and explore".text.size(20).fontWeight(FontWeight.w400).make(),
                          SizedBox(height: 15,),
                          Image.asset(
                            "assets/images/poiuy.png",
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Welcome ",
                            style:  const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding:  const EdgeInsets.symmetric(vertical: 13.0, horizontal: 25),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blueAccent,width: 1)
                                      ),
                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Enter the username",
                                      labelText: "Username"
                                  ),
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return"User name can't be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      fullName=value;
                                    });
                                  },
                                ),
                                SizedBox(height: 6,),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blueAccent,width: 1)
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "Enter the user name",
                                      labelText: "Username"
                                  ),
                                  validator: (value){
                                    if (value!.isEmpty){
                                      return"email can't be empty";
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
                                      onTap: (){register();},
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
                                            "Register",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ))
                                ),
                                const SizedBox(height: 8,),
                                Text.rich(TextSpan(
                                    text: "already have an account",
                                    style: const TextStyle(color: Colors.black,fontSize: 16),
                                    children:<TextSpan>[
                                      TextSpan(text: "Sign in now",
                                          style: const TextStyle(color: Colors.black,decoration: TextDecoration.underline)
                                          ,recognizer: TapGestureRecognizer()..onTap=(){
                                            nextScreenReplace(context, const LoginPage());
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
register()async{
if(formKey.currentState!.validate()){
  setState(() {
    _isLoading = true;
  });
  await authService.registerUserWithEmailandPassword(fullName, email, password).then((value) async {
    if (value == true) {
      // saving the shared preference state
      await HelperFunctions.saveUserLoggedInStatus(true);
      await HelperFunctions.saveUserEmailSF(email);
      await HelperFunctions.saveUserNameSF(fullName);
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
