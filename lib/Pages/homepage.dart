import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/services/Userservice.dart';

import 'listerappels.dart';
import 'listemaladie.dart';
import 'listemedicament.dart';
import 'listetraitement.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final userservice= UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height:270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(80), bottomRight: Radius.circular(80) ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        offset: Offset(0, 0),
                      )
                    ],
                    color: Color(0xff4285F4),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:  CircleAvatar(
                          backgroundImage: AssetImage("assets/images/photo.jpg"),
                          radius: 30,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text('Bienvenue,',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child:  FutureBuilder<String>(
                                    future: userservice.getUser(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          'Erreur : ${snapshot.error}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  )
                              ),
                            ],
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 40),
                              child:IconButton(
                                icon: Icon(Icons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: (){},
                              ) ,
                            ),
                            Padding(
                              padding:EdgeInsets.only(),
                              child:IconButton(
                                icon: Badge(
                                  label: Text('10'),
                                  child: Icon(
                                    Icons.notifications,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){},
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 199),
                  child: Stack(
                    children: [
                      Container(
                        height: 190,
                        decoration: BoxDecoration(
                            color: Color(0xffEFEAEA),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.4),
                                  blurRadius: 7,
                                  offset: Offset(0, 0)
                              )
                            ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Catégories",
                                  style: TextStyle(
                                      color: Color(0xff4285F4),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500
                                  ),
                                )
                            ),
                            IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.arrow_forward_ios,
                                  size: 30,
                                  color: Color(0xff4285F4),
                                )
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 70,
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          print("hello");
                                        },
                                        child: Image.asset("assets/images/medicament.jpg"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          print("hello");
                                        },
                                        child: Image.asset("assets/images/maladie.jpg"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          print("hello");
                                        },
                                        child: Image.asset("assets/images/traitement.jpg"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50,),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              children: [
                                GestureDetector(
                                  child: myCard('assets/images/medic.jpg','Médicaments'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Medicaments()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: myCard('assets/images/person.jpg', 'Maladies'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Maladies()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: myCard('assets/images/traite.jpg', 'Traitements'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Traitements()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: myCard('assets/images/photo_prise.jpg', 'Rappels'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Rappels()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );


  }
}
Container myCard(String photo, String text) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            offset: Offset(2, 0),
            blurRadius: 4,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage(photo),
            fit: BoxFit.cover
        )
    ),
    child: Container(
        alignment: Alignment.bottomCenter,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff18534F),
              fontWeight: FontWeight.bold
          ),
        )
    ),
  );
}