import 'package:flutter/material.dart';
import 'package:graphiceranotification/first.dart';
import 'package:graphiceranotification/screens/recieved_requests_screen.dart';
import 'package:graphiceranotification/screens/request_substitute_screen.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

import '../../utils/button_widget.dart';
import '../options.dart';

class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({super.key});

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                height: SizeConfig.safeBlockVertical * 10,
                width: SizeConfig.safeBlockHorizontal * 100,
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFF000C45)))),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    isDrawerOpen
                        ? GestureDetector(
                            child: Icon(Icons.arrow_back_ios),
                            onTap: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : GestureDetector(
                            child: Icon(
                              Icons.menu,
                              size: SizeConfig.safeBlockVertical * 3.5,
                            ),
                            onTap: () {
                              setState(() {
                                xOffset = 290;
                                yOffset = 80;
                                isDrawerOpen = true;
                              });
                            },
                          ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000C45),
                          decoration: TextDecoration.none,
                          fontFamily: 'Roboto'),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 1, child: Text("logout"))
                      ],
                      icon: const Icon(Icons.logout),
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName(Options.id));
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 85,
                width: SizeConfig.safeBlockHorizontal * 100,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: 'Send Notice',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FirstScreen()));
                          },
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockHorizontal * 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          text: 'Request Substitute',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const RequestSubstitute()));
                          },
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockHorizontal * 40,
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                            width: 200,
                            child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          RecievedRequestScreen())));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Recieved Requests',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF000C45)),
                                    ),
                                    Icon(Icons.notifications_outlined,
                                        color: Colors.grey),
                                  ],
                                )),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              height: 20,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6)),
                              constraints: const BoxConstraints(
                                  minHeight: 14, minWidth: 14),
                              child: const Text(
                                '99+',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontFamily: 'Roboto',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
