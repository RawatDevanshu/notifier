import 'package:flutter/material.dart';
import 'package:graphiceranotification/first.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graphiceranotification/options.dart';
import 'package:graphiceranotification/splash_screen.dart';
import 'package:graphiceranotification/student_user_verify.dart';
import 'package:graphiceranotification/studentdashboard.dart';
import 'package:graphiceranotification/teacher.dart';
import 'first.dart';
Future<void>  _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print("Handling a background message ${message.messageId}");
}

void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await FirebaseMessaging.instance.getInitialMessage();
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        FirstScreen.id:(_)=>FirstScreen(),
        SplashScreen.id:(_)=>SplashScreen(),
         Options.id:(_)=>Options(),
         Teacher.id:(_)=> Teacher(),
         StudentVerification.id:(_)=>StudentVerification(),
         StudentDashboard.id:(_)=>StudentDashboard(),
      },
      initialRoute:SplashScreen.id,);
  }
}
