import 'package:flutter/material.dart';
import 'sizeConfig.dart';
class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffEEEEEE),
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical*5, left: SizeConfig.safeBlockHorizontal*7, bottom:SizeConfig.safeBlockVertical*5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(

                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  radius: SizeConfig.safeBlockHorizontal*20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTnpsIQzc7hASnlMOXLDSH2oVW4oPjXWJ7TbIc_ZYB5Q&s'),
                    ),
                  ),
                ),

              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               Container(
                    color: Colors.transparent,
                    height: SizeConfig.safeBlockVertical *20,
                    width: SizeConfig.safeBlockHorizontal * 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(85)),
                      child:  Material(
                      borderRadius:  BorderRadius.circular(25),
                      color: Color(0xff000000),
                      elevation: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Upendra Pandit',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),     Text(
                            'Semester : 6',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight:FontWeight.w500,
                                color: Colors.white,
                              fontSize: 18
                            ),
                          ),     Text(
                            'Section D',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                                color: Colors.white
                            ),
                          ),   Text(
                            '20021897',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight:FontWeight.w500,
                              fontSize: 18,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
