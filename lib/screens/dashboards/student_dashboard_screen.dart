import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

import '../../../drawer_screen.dart';
import '../home_Screen.dart';

class StudentDashboard extends StatefulWidget {
  static var id = 'StudentDashboard';
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    ));
  }
}
