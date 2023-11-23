import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/utilisateur.dart';
import '../services/Userservice.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Users users;

  @override
  void initState() {
    userGet();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4285F4),
      ),
      body: FutureBuilder<Users> (
        future: userGet(),
        builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if(snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Users user = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
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
                    Padding(
                      padding: EdgeInsets.only(top:20, bottom: 10),
                      child:CircleAvatar(
                        backgroundImage: user.imageURL == ''? AssetImage('assets/images/profile_1.jpg') : AssetImage(user.imageURL),
                        radius: 70,
                      ) ,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        margin: EdgeInsets.all(0.8),
                        height: 60,
                        child: TextField(
                          readOnly: true,
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.green
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: user.nom,
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        margin: EdgeInsets.all(0.8),
                        height: 60,
                        child: TextField(
                          readOnly: true,
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.green
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: user.prenom,
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        margin: EdgeInsets.all(0.8),
                        height: 60,
                        child: TextField(
                          readOnly: true,
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.green
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: user.email,
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff048B9A),
                          fixedSize: Size(200, 50),
                        ),
                        onPressed: (){},
                        child: Text("Modifier",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffEB4335),
                          fixedSize: Size(200, 50),
                        ),
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return Dialog(
                                  insetPadding: EdgeInsets.all(20),
                                  shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
                                  child: Container(
                                    height: 350,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/logout.png'),
                                            radius: 50,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                            child: Text("Êtes-vous sûr de vous déconnecter?",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 10),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xffeb4335),
                                                    fixedSize: Size(100, 50),
                                                  ),
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("NON",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 10),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xff048b9a),
                                                    fixedSize: Size(100, 50),
                                                  ),
                                                  onPressed: (){
                                                    FirebaseAuth.instance.signOut();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("OUI",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        label: Text("Déconnexion",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        icon: Icon(Icons.login_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            );
          }
        },
      )
    );
  }
}
