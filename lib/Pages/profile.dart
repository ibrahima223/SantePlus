import 'dart:ffi';

import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile"
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4285F4),
      ),
      body: Container(
        height: 600,
        decoration: BoxDecoration(
            color: Color(0xff4285F4),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70),bottomRight: Radius.circular(70)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 6,
                  offset: Offset(0, 0)
              )
            ]
        ),
        child: Column(
          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top:0),
                  child:CircleAvatar(
                    backgroundImage: AssetImage('assets/images/photo.jpg'),
                    radius: 70,
                  ) ,
                ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: Offset(0,0),
                            blurRadius: 4
                          )
                        ]
                      ),
                    ),
                  )

          ],
        ),
      ),
    );
  }
}
