import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphiceranotification/new_screen.dart';
import 'package:graphiceranotification/utils/push_notification.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';
import 'package:graphiceranotification/screens/dashboards/student_dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graphiceranotification/utils/localNotification.dart';
import 'getFCM.dart';

List<String> semester = ['1', '2', '3', '4', '5', '6', '7', '8'];
var sem;
var sec;
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
List<List<int>> counter = List.filled(15, List.filled(15, 0));

class FirstScreen extends StatefulWidget {
  static var id = 'FirstScreen';

  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  TextEditingController toController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var token;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      try {
        if (response.payload! != null && response.payload!.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return StudentDashboard();
          }));
        } else {}
      } catch (e) {
        return;
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("...............OnMessage....................");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('dbfood', 'dbfood',
              importance: Importance.max,
              styleInformation: bigTextStyleInformation,
              priority: Priority.max,
              playSound: true);
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const DarwinNotificationDetails());
      await flutterLocalNotificationPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
      ;
    } else {
      print("User declined or has not accepted permission");
    }
  }

  void getTokens(String token) async {
    var a = temp[int.parse(sem)];
    a = a.toString().split(' ');
    var data;
    for (int i = 0; i < a.length - 1; i++) {
      CollectionReference _collectionRef = FirebaseFirestore.instance
          .collection("Students")
          .doc("Semester")
          .collection(sem.toString())
          .doc('Section')
          .collection(a[i]);
      QuerySnapshot querySnapshot = await _collectionRef.get();
      data = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (int j = 0; j < data.length; j++) {
        var res = jsonEncode(data);
        print(jsonDecode(res)[0]['token']);
        sendPushMessage(jsonDecode(res)[j]['token'],
            messageController.text.trim(), titleController.text.trim());
      }
    }
  }

  Future<String?> getFcmToken() async {
    String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
  }

  void getToken() async {
    token = await getFcmToken();
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      print("Enter tru");
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAaEvNOLQ:APA91bHcctuEpm_kWwsLpdobM1yP6-l47SP8lTKWtreIv0p96X4nJ2_J6LXqwweD5LKrY1Pc5zJdsXtQbOAFqgAfc6f9aeN4ORQmwwbTzx3aYZxwPFyylxFOsHO4TU9_30r-DRJNzjyq'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          }));
    } catch (e) {
      if (kDebugMode) print("Error sending notification");
    }
  }



  void getSemAndSec() async{

    var a = await FirebaseFirestore.instance
        .collection("Teachers")
        .doc("Jeetu")
        .collection("Semester").get().then((value) => print(value.docs));

  }



  @override
  void initState() {
    sem = semester[0];

    getToken();
    requestPermission();
    initInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LocalNotification.initialize();
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   LocalNotification.showNotification(message);
    // });
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: const Text(
            'Notifier',
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
                        'Title of the message',
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
                          controller: titleController,
                          maxLines: 3,
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
                          controller: messageController,
                          maxLines: 5,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontSize: 15),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'Write your message..',
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
                    ElevatedButton(
                      onPressed: () async {
                        String name = toController.text.trim();
                        String title = titleController.text.trim();
                        String bodyText = messageController.text.trim();
                        if (name != "" && title != "" && bodyText != "") {
                          DocumentSnapshot snap = await FirebaseFirestore
                              .instance
                              .collection("userTokens")
                              .doc(name)
                              .get();
                          String token = snap['token'];
                          print(token);
                          sendPushMessage(token, bodyText, title);
                        }
                        getTokens('sd');
                        getSemAndSec();
                      },
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
              child: Center(
                child: Select(),
              ),
            )
          ]),
        ),
      )),
    );
  }
}

class Textfield extends StatelessWidget {
  const Textfield(
      {Key? key,
      required this.toController,
      required this.hint,
      required this.maxlines})
      : super(key: key);

  final TextEditingController toController;
  final String hint;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: toController,
      maxLines: maxlines,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
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
            margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 10),
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
                        color: counter[int.parse(sem)][4] % 2 == true
                            ? true
                            : false,
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
