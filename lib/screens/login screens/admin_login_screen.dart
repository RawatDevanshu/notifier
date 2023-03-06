import 'package:flutter/material.dart';
import 'package:graphiceranotification/utils/sizeConfig.dart';

import '../dashboards/admin_dashboard_screen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Admin Login',
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
                'Please enter username and password.',
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
                  'Username',
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
                    controller: usernameController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontSize: 15),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Enter username',
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
                  'Password',
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
                  controller: passwordController,
                  obscureText: _obscured,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      fontSize: 15),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Enter password',
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                          color: const Color(0xFF000C45),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 50,
                child: InkWell(
                  onTap: () {
                    print(usernameController.text);
                    if (usernameController.text == "admin" &&
                        passwordController.text == "admin") {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AdminDashboard()));
                    }
                  },
                  child: Material(
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Color(0xFF000C45),
                        child: const Center(
                            child: Text(
                          'Login',
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
    );
  }
}
