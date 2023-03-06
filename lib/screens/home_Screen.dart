import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5),
              height: SizeConfig.safeBlockVertical * 10,
              width: SizeConfig.safeBlockHorizontal * 100,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFF000C45)))),
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
                    'Notifications',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000C45),
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto'),
                  ),
                  Container(),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: SizeConfig.safeBlockVertical * 90,
              width: SizeConfig.safeBlockHorizontal * 80,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Material(
              // color: Color(0xFFB7B78A),
                      child: Card(
               color: Color(0xFFEEEEEE),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Color(0xFFDDDDDD),
                                ),
                                height: SizeConfig.safeBlockVertical * 5.5,
                                width: SizeConfig.safeBlockHorizontal * 100,
                                child: Center(
                                  child: Text(
                                    'Dr. Devesh Pratap Singh',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                              ),
                              Material(

                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Compiler Design Class',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                color: Colors.transparent,

                              ),
                              Material(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Hi class! come to lt0 for the class',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                color: Colors.transparent,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom:SizeConfig.safeBlockVertical * 0.25,right: SizeConfig.safeBlockHorizontal*35 ),
                                height: SizeConfig.safeBlockVertical * 1.5,
                                width: SizeConfig.safeBlockHorizontal * 40,
                                child: Text(
                                  '20 Feb Monday 12:39 pm',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
