import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphiceranotification/screens/dashboards/admin_dashboard_screen.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';
import 'package:graphiceranotification/screens/dashboards/student_dashboard_screen.dart';

import '../dashboards/faculty_dashboard_screen.dart';

var sec;
var name;
var id;
var sem;
Map semToSec = {2: 'A,B,C,D'};
List<List<int>> counter = List.filled(15, List.filled(15, 0));

List<bool> _firstValue = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];
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
var makeVisible = false;

List<List<String>> mapping = [];
Map check = {
  'A': 0,
  'B': 1,
  'C': 2,
  'D': 3,
  'E': 4,
  'F': 5,
  'G': 6,
  'H': 7,
  'I': 8,
  'CE': 9,
  'CESPL': 10,
  'CST': 11,
  'CSTSPL1': 12,
  'CSTSPL2': 13,
  'AIDS': 14,
};
Map temp = {
  1: '',
  2: '',
  3: '',
  4: '',
  5: '',
  6: '',
  7: '',
  8: '',
  9: '',
  10: '',
  11: '',
  12: '',
  13: '',
  14: '',
  15: '',
  16: '',
};

class Teacher extends StatefulWidget {
  static var id = 'Teacher';

  const Teacher({Key? key}) : super(key: key);

  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  void RegisterFaculty() async {
    for (int i = 1; i < 9; i++) {
      if (temp[i] == '') continue;
      await FirebaseFirestore.instance
          .collection("Teachers")
          .doc(name.toString())
          .collection('Semester')
          .doc(i.toString())
          .set({'Sections': temp[i]});
    }
  }

  @override
  void initState() {
    sem = semester[0];
    sec = section[0];
    // TODO: implement initState
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
              child: Stack(children: [
                Center(
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
                          'Teacher ID',
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
                              id = val;
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
                        height: SizeConfig.safeBlockVertical * 5,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        height: SizeConfig.safeBlockVertical * 3.5,
                        width: SizeConfig.safeBlockHorizontal * 70,
                        child: const Text(
                          'Name',
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
                              name = val;
                            },
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontSize: 15),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Enter your name',
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (makeVisible == false) {
                                makeVisible = true;
                              } else {
                                makeVisible = false;
                              }
                            });
                            counter[int.parse(sem)].fillRange(0, 15, 0);
                            var val = temp[int.parse(sem)];
                            var a = val.toString().split(' ');
                            print(a[0].runtimeType);
                            for (int i = 0; i < a.length - 1; i++) {
                              print(a[i].trim());
                              if (a[i] != " " || a[i] != "") {
                                print(check[a[i]]);
                                counter[int.parse(sem)][check[a[i]]] = 1;
                              }
                            }
                            // temp[int.parse(sem)]='';
                          },
                          child: Center(
                            child: Text(
                              'Choose',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
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
                            if (name.toString().trim() != 'null' &&
                                id.toString().trim() != 'null') {
                              RegisterFaculty();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          FacultyDashboard())));
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
                Visibility(visible: makeVisible, child: Select())
              ]),
            ),
          ),
        )),
      ),
    )));
  }
}

class SectionCard extends StatelessWidget {
  final String sectionName;
  final VoidCallback onPressed;
  final bool color;

  const SectionCard({
    Key? key,
    required this.sectionName,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: color ? Colors.blue : Colors.white,
        elevation: 12.5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(sectionName,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  color: Color(0xFF000C45),
                  fontSize: 18.5)),
        ),
      ),
    );
  }
}

class Select extends StatefulWidget {
  const Select({Key? key}) : super(key: key);

  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: makeVisible,
      child: Center(
        child: Container(
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 8),
            height: SizeConfig.safeBlockVertical * 80,
            width: SizeConfig.safeBlockHorizontal * 80,
            child: Material(
              color: Colors.white,
              elevation: 10,
              borderRadius: BorderRadius.circular(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(12.4),
                      child: Text('You are choosing for semester $sem',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito Sans',
                              color: Colors.black,
                              fontSize: 15)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SectionCard(
                        sectionName: 'A',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][0]++;
                            if (counter[int.parse(sem)][0] % 2 != 0) {
                              tem += 'A ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('A ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][0] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'B',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][1]++;
                            if (counter[int.parse(sem)][1] % 2 != 0) {
                              tem += 'B ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('B ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][1] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'C',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][2]++;
                            if (counter[int.parse(sem)][2] % 2 != 0) {
                              tem += 'C ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('C ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][2] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'D',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][3]++;
                            if (counter[int.parse(sem)][3] % 2 != 0) {
                              tem += 'D ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('D ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][3] % 2 != 0 ? true : false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SectionCard(
                        sectionName: 'E',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][4]++;
                            if (counter[int.parse(sem)][4] % 2 != 0) {
                              tem += 'E ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('E ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][4] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'F',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][5]++;
                            if (counter[int.parse(sem)][5] % 2 != 0) {
                              tem += 'F ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('F ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][5] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'G',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][6]++;
                            if (counter[int.parse(sem)][6] % 2 != 0) {
                              tem += 'G ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('G ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][6] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'H',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][7]++;
                            if (counter[int.parse(sem)][7] % 2 != 0) {
                              tem += 'H ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('H ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][7] % 2 != 0 ? true : false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SectionCard(
                        sectionName: 'I',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][8]++;
                            if (counter[int.parse(sem)][8] % 2 != 0) {
                              tem += 'I ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('I ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][8] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'CE',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][9]++;
                            if (counter[int.parse(sem)][9] % 2 != 0) {
                              tem += 'CE ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('CE ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][9] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'CE SPL',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][10]++;

                            if (counter[int.parse(sem)][10] % 2 != 0) {
                              tem += 'CESPL ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('CESPL ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][10] % 2 != 0 ? true : false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SectionCard(
                        sectionName: 'CST',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][11]++;
                            if (counter[int.parse(sem)][11] % 2 != 0) {
                              tem += 'CST ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('CST ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][11] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'CST SPL1',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][12]++;
                            if (counter[int.parse(sem)][12] % 2 != 0) {
                              tem += 'CSTSPL1 ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res =
                                  tem.toString().replaceAll('CESPL1 ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][12] % 2 != 0 ? true : false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SectionCard(
                        sectionName: 'CST SPL2',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][13]++;
                            if (counter[int.parse(sem)][13] % 2 != 0) {
                              tem += 'CSTSPL2 ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res =
                                  tem.toString().replaceAll('CSTSPL2 ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][13] % 2 != 0 ? true : false,
                      ),
                      SectionCard(
                        sectionName: 'AI DS',
                        onPressed: () {
                          setState(() {
                            var tem = temp[int.parse(sem)];
                            counter[int.parse(sem)][14]++;
                            if (counter[int.parse(sem)][14] % 2 != 0) {
                              tem += 'AIDS ';
                              temp[int.parse(sem)] = tem;
                            } else {
                              var res = tem.toString().replaceAll('AIDS ', '');
                              temp[int.parse(sem)] = res;
                            }
                          });
                        },
                        color:
                            counter[int.parse(sem)][14] % 2 != 0 ? true : false,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print("pressed");
                        print(makeVisible);
                        makeVisible = false;
                        print(makeVisible);
                      });
                      print(temp);
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        height: SizeConfig.safeBlockVertical * 8,
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: const Card(
                          color: Colors.black,
                          elevation: 5,
                          child: Center(
                            child: Text(
                              'Confirm!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
