import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,);
  }
}

