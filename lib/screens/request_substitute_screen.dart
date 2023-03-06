import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

import '../first.dart';

List<String> semester = ['1', '2', '3', '4', '5', '6', '7', '8'];
List<String> facultyList = [
  'Faculty_name_1',
  'Faculty_name_2',
  'Faculty_name_3',
  'Faculty_name_4'
];
var fname;
var sem;
var sec;

class RequestSubstitute extends StatefulWidget {
  const RequestSubstitute({super.key});

  @override
  State<RequestSubstitute> createState() => _RequestSubstituteState();
}

class _RequestSubstituteState extends State<RequestSubstitute> {
  @override
  void initState() {
    super.initState();
    sem = semester[0];
    fname = facultyList[0];
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController req_titleController = TextEditingController();
    final TextEditingController req_messageController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: const Text(
          'Request Substitute',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              color: Color(0xFF000C45),
              fontSize: 21),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                  Container(
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
                    height: SizeConfig.safeBlockVertical * 2,
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
                        border:
                            Border.all(width: 1.75, color: Color(0xFF000C45))),
                    child: InkWell(
                      onTap: () {},
                      child: const Center(
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
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Faculty Name',
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
                        value: fname,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            fname = value!;
                          });
                        },
                        items: facultyList
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
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  // SizedBox(
                  //     height: MediaQuery.of(context).size.height * 0.1,
                  //     width: MediaQuery.of(context).size.width * 0.6,
                  //     child: Textfield(
                  //       toController: toController,
                  //       hint: 'To',
                  //       maxlines: 1,
                  //     )),

                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Title of request',
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
                    // height: SizeConfig.safeBlockVertical * 6.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: TextFormField(
                        controller: req_titleController,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontSize: 15),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Title',
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
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Message',
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
                    // height: SizeConfig.safeBlockVertical * 6.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: TextFormField(
                        controller: req_messageController,
                        maxLines: 5,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            fontSize: 15),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText:
                              'Please write Name of lecture,timing ,class room number and other necessary details',
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
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF000C45),
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: makeVisible,
            child: const Center(
              child: Select(),
            ),
          )
        ]),
      ),
    ));
  }
}
