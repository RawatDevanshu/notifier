import 'package:flutter/material.dart';
import 'package:graphiceranotification/student_user_verify.dart';
import 'package:graphiceranotification/teacher.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'sizeConfig.dart';

class Options extends StatefulWidget {
  static var id = 'Options';

  const Options({Key? key}) : super(key: key);

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                  height: SizeConfig.safeBlockVertical * 12.5,
                  width: SizeConfig.safeBlockHorizontal * 35,
                  child:
                      Hero(tag: 'Logo', child: Image.asset('assets/logo.png'))),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 13),
            SelectionCard(
              text: 'Faculty',
              route: Teacher.id,
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 5),
            Center(
              child: SelectionCard(
                text: 'Student',
                route: StudentVerification.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectionCard extends StatefulWidget {
  const SelectionCard({
    Key? key,
    required this.text, required this.route,
  }) : super(key: key);
  final String text;
  final String route;

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

bool isFinished = false;

class _SelectionCardState extends State<SelectionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: SizeConfig.safeBlockVertical * 17,
        width: SizeConfig.safeBlockHorizontal * 75,
        child: Center(
          child: SlideAction(
            onSubmit: () {
              Navigator.pushNamed(context, widget.route);
            },
            submittedIcon: Icon(
              Icons.check,
              size: 100,
            ),
            sliderRotate: false,
            innerColor: Colors.white,
            outerColor: Colors.white,
            height: SizeConfig.safeBlockVertical * 17,
            borderRadius: 17.5,
            elevation: 10,
            text: 'widget.text',
            sliderButtonIconSize: SizeConfig.safeBlockVertical * 6,
            alignment: Alignment.center,
            sliderButtonIcon: Container(
                color: Colors.white,
                height: SizeConfig.safeBlockVertical * 10,
                width: SizeConfig.safeBlockHorizontal * 20,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                )),
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                height: SizeConfig.safeBlockVertical * 10,
                width: SizeConfig.safeBlockHorizontal * 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            fontFamily: 'Roboto',
                            color: Color(0xFF000C45)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 14),
                      child: Center(
                        child: Text(
                          'Slide the logo to right',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            textStyle: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w900, color: Colors.black),
            sliderButtonIconPadding: 0,
          ),
        ));
  }
}
