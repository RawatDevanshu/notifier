import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

class RecievedRequestScreen extends StatefulWidget {
  const RecievedRequestScreen({super.key});

  @override
  State<RecievedRequestScreen> createState() => _RecievedRequestScreenState();
}

class _RecievedRequestScreenState extends State<RecievedRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Drawer(
        backgroundColor: Color(0xFFEEEEEE),
        child: Text('drawer'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40),
            height: SizeConfig.safeBlockVertical * 15,
            width: SizeConfig.screenWidth,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFF000C45)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 20),
                const Text(
                  'Requests',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000C45),
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: SizeConfig.safeBlockVertical * 7,
              width: SizeConfig.safeBlockHorizontal * 25,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xFFDDDDDD),
                        title: const Text("Reject all"),
                        content: const Text(
                            "Do you really want to reject all request?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Continue")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xFF000C45),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    color: const Color(0xFFEEEEEE),
                    child: const Center(
                        child: Text(
                      'Reject All',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          fontSize: 13,
                          color: Color(0xFF000C45)),
                    ))),
              ),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical * 70,
            width: SizeConfig.safeBlockHorizontal * 100,
            color: Colors.white,
            child: ListView.builder(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 30),
                itemCount: 1,
                itemBuilder: (_, index) {
                  return Material(
                    //color: Color(0xFFB7B78A),
                    child: Card(
                      color: Color(0xFFEEEEEE),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Color(0xFFDDDDDD),
                            ),
                            height: SizeConfig.safeBlockVertical * 5.5,
                            width: SizeConfig.safeBlockHorizontal * 100,
                            child: const Center(
                              child: Text(
                                'Dr. Devesh Pratap Singh',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                          ),
                          const Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Teacher ID',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.safeBlockVertical * 5,
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Color(0xFF000C45),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          color: const Color(0xFFEEEEEE),
                                          child: const Center(
                                              child: Text(
                                            'Reject',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Roboto',
                                                fontSize: 14.5,
                                                color: Color(0xFF000C45)),
                                          ))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.safeBlockVertical * 5,
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          color: const Color(0xFF000C45),
                                          child: const Center(
                                              child: Text(
                                            'Accept',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Roboto',
                                                fontSize: 14.5,
                                                color: Colors.white),
                                          ))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.safeBlockVertical * 0.25,
                                right: SizeConfig.safeBlockHorizontal * 35),
                            height: SizeConfig.safeBlockVertical * 1.5,
                            width: SizeConfig.safeBlockHorizontal * 40,
                            child: const Text(
                              '20 Feb Monday 12:39 pm',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
