import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/Pages/Connexion/profile.dart';
import 'package:santeplus/Pages/Animations/sliderScreen.dart';
import 'package:santeplus/services/Userservice.dart';

import '../Rappels/listerappels.dart';
import '../Maladies/listemaladie.dart';
import '../Medocs/listemedicament.dart';
import '../Traitements/listetraitement.dart';
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:0.8),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Profile()),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/profile_1.jpg"),
                            radius: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bienvenue,',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),
                            ),
                            FutureBuilder<String>(
                              future: userservice.getUser(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return Wrap(
                                    children: [
                                      Text(
                                        '${snapshot.data}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Badge(
                          label: Text('3'),
                          child: Icon(
                            Icons.notifications,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Rappels()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 199),
                  child: Stack(
                    children: [
                      SliderScreen(),
                      Padding(
                        padding: EdgeInsets.only(top: 135),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50,),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              children: [
                                GestureDetector(
                                  child: myCard('assets/images/medicament.jpg','Médicaments'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Medicaments()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: myCard('assets/images/maladie.jpg', 'Maladies'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Maladies()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: myCard('assets/images/traitement.jpg', 'Traitements'),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Traitements()),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: myCard('assets/images/rappels.jpg', 'Rappels'),
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
    child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: Colors.white60,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff18534F),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    ),
  );
}