import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tester2/helper/helper_function.dart';
import 'package:tester2/pages/homep_page.dart';
import 'package:tester2/pages/login_page.dart';
import 'package:tester2/shared/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    //run the inisilization for me
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: Constants.apikey,
        appId: Constants.appid,
        messagingSenderId:Constants.messageingSenderId,
        projectId:Constants.projectId));
  }
  else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }
  getUserLoggedInStatus() async{
      await HelperFunctions.getUserLoggedInStatus().then((value){
        if(value!=null){
            setState(() {
              _isSignedIn = value;
            });
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    theme:ThemeData(
      primaryColor: Constants().primcolor
    ),
    home: _isSignedIn ? HomePage():LoginPage()
    );
  }
}

