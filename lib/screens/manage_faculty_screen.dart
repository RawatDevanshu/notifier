import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

class ManageFaculty extends StatefulWidget {
  const ManageFaculty({super.key});

  @override
  State<ManageFaculty> createState() => _ManageFacultyState();
}

class _ManageFacultyState extends State<ManageFaculty> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50),
            height: SizeConfig.safeBlockVertical * 15,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFF000C45)))),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: const Color.fromARGB(255, 3, 21, 108),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                const SizedBox(width: 70),
                const Text(
                  'Faculty List',
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 6.5,
            width: SizeConfig.safeBlockHorizontal * 90,
            child: TextFormField(
                controller: searchController,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    fontSize: 15),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  prefixIconColor: const Color(0xFF000C45),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'search by teacher id',
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
            height: SizeConfig.safeBlockVertical * 70,
            width: SizeConfig.safeBlockHorizontal * 100,
            color: Colors.white,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) {
                  return Material(
                    //color: Color(0xFFB7B78A),
                    child: Card(
                      color: Color(0xFFEEEEEE),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(children: [
                        Column(
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical * 5,
                                      width:
                                          SizeConfig.safeBlockHorizontal * 20,
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    const Color(0xFFDDDDDD),
                                                title: const Text("Remove"),
                                                content: const Text(
                                                    "Do you really want to remove?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          "Continue")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("Cancel")),
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
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            color: const Color(0xFFEEEEEE),
                                            child: const Center(
                                                child: Text(
                                              'Remove',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14.5,
                                                  color: Color(0xFF000C45)),
                                            ))),
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }
}
