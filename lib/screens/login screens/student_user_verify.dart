import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';
import 'package:graphiceranotification/screens/dashboards/student_dashboard_screen.dart';

class StudentVerification extends StatefulWidget {
  static var id = 'StudentVerification';

  const StudentVerification({Key? key}) : super(key: key);

  @override
  _StudentVerificationState createState() => _StudentVerificationState();
}

class _StudentVerificationState extends State<StudentVerification> {
  var genders;
  var name;
  var email;
  var sem;
  var sec;
  var token;
  var studentid;

  List<String> semester = ['1', '2', '3', '4', '5', '6', '7', '8'];
  List<String> section = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'CE',
    'CE SPL',
    'CST',
    'CST SPL1',
    'CST SPL2',
    'AI DS'
  ];

  Future makeAstudentProfile() async {
    await FirebaseFirestore.instance
        .collection('Students')
        .doc('Semester')
        .collection(sem.toString())
        .doc('Section')
        .collection(sec.toString())
        .doc(studentid)
        .set({'token': token});
  }

  Future<String?> getFcmToken() async {
    String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
  }

  void getToken() async {
    token = await getFcmToken();
    print(token);
  }

  @override
  void initState() {
    getToken();
    sem = semester[0]; // TODO: implement initState
    sec = section[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
            body: WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
            child: Scaffold(
          body: SizedBox(
            height: SizeConfig.safeBlockVertical * 100,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 8,
                  ),
                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        color: Color(0xFF000C45),
                        fontSize: 21),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.75,
                  ),
                  const Text(
                    'Please fill the details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Student ID',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF000C45),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: TextFormField(
                        onChanged: (val) {
                          studentid = val;
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontSize: 15),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter your id',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF000C45),
                                width: 1.75,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF000C45),
                                width: 1.75,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.75,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Section',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF000C45),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  Container(
                      padding: (sec == 'CST SPL1' || sec == 'CST SPL2')
                          ? EdgeInsets.only(left: 7)
                          : EdgeInsets.only(left: 7),
                      height: SizeConfig.safeBlockVertical * 6.5,
                      width: SizeConfig.safeBlockHorizontal * 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              width: 1.75, color: Color(0xFF000C45))),
                      child: DropdownButton<String>(
                        alignment: Alignment.centerLeft,
                        value: sec,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            sec = value!;
                            print(sec);
                          });
                        },
                        items: section
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Roboto',
                                  fontSize: 15),
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.75,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Semester',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF000C45),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto',
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 7),
                      height: SizeConfig.safeBlockVertical * 6.5,
                      width: SizeConfig.safeBlockHorizontal * 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              width: 1.75, color: Color(0xFF000C45))),
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        value: sem,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            sem = value!;
                            print(sem);
                          });
                        },
                        items: semester
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Roboto',
                                  fontSize: 15),
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.75,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 7,
                    width: SizeConfig.safeBlockHorizontal * 50,
                    child: InkWell(
                      onTap: () async {
                        if (studentid != null && sec != "" && sem != "") {
                          sec=sec.toString().replaceAll(" ", "");
                          await makeAstudentProfile();
                          Navigator.pushReplacementNamed(
                              context, StudentDashboard.id);
                        }
                      },
                      child: Material(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Color(0xFF000C45),
                            child: const Center(
                                child: Text(
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Roboto',
                                  fontSize: 14.5,
                                  color: Colors.white),
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    )));
  }
}
