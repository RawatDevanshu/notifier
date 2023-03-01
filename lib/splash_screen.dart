import 'package:flutter/material.dart';
import 'package:graphiceranotification/first.dart';
import 'package:graphiceranotification/options.dart';

class SplashScreen extends StatefulWidget {
  static var id = 'SplashScreeen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, Options.id, (route) => false));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(

          color: Colors.white,
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Center(
            child: Hero(
                tag: 'Logo',
                child: Image.asset('assets/logo.png')),
          ),
        ),
      ),
    );
  }
}
