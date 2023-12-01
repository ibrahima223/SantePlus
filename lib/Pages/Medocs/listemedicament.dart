import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santeplus/Pages/Medocs/ajoutmedicament.dart';
import 'package:santeplus/Pages/Animations/bottomnavigatorbar.dart';
import 'package:santeplus/Pages/Medocs/modifiermedicament.dart';
import 'package:santeplus/Pages/Connexion/profile.dart';
import 'package:santeplus/services/Userservice.dart';

import '../../models/medicament.dart';
import '../../models/medicament.dart';
import '../../models/medicament.dart';
import '../../repositories/medicamentStream.dart';
import '../../services/floattingservice.dart';
import 'AdminMedoc.dart';
import 'UserMedoc.dart';
import '../Rappels/listerappels.dart';
class Medicaments extends StatefulWidget {
  const Medicaments({super.key});

  @override
  State<Medicaments> createState() => _MedicamentsState();
}

class _MedicamentsState extends State<Medicaments> {
  final floatingservice= FloattingService();
  final userservice= UserService();
  TextEditingController search_input= TextEditingController();
  int curentIndex = 0;

  @override
  void initState(){
    super.initState();
    search_input.addListener(()=> setState(() {
    }));
  }

  // List<medicament> medicaments= [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 270,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child:  GestureDetector(
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
                                padding: EdgeInsets.only(right: 100),
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
                                  ],
                                )
                            ),
                            Row(
                              children: [
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 160),
                        child: Container(
                          margin: EdgeInsets.all(30),
                          height: 50,
                          child: CupertinoSearchTextField(
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                            ),
                            controller: search_input,
                            placeholder: "Rechercher....",
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 20,),
              TabBar(
                labelColor:Color(0xff4285F4),
                dividerColor: Colors.white,
                indicatorColor: Color(0xff4285F4),
                unselectedLabelColor: Colors.grey,
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff4285F4),// Couleur noire avec opacité
                    width: 3, // Largeur de la ligne de délimitation
                  ),
                ),
                labelStyle: const TextStyle(
                  backgroundColor: Colors.transparent, // Fond transparent pour le texte de l'onglet sélectionné
                ),
                unselectedLabelStyle: const TextStyle(
                  backgroundColor: Colors.transparent, // Fond transparent pour le texte de l'onglet non sélectionné
                ),
                onTap: (index){
                  setState(() {
                    curentIndex = index;
                  });
                },
                tabs: [
                  Tab(icon: Text("Tous médicaments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, backgroundColor: Colors.transparent),)),
                  Tab(icon: Text("Mes medicaments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
              Column(
                children: [
                  (curentIndex==0)?AdminMedoc()
                      : UserMedoc(),
                ],
              )
              ,
            ],
          ),
        ),
        floatingActionButton: floatingservice.buildFloatingActionButton(() {
        }, context, PageContext.AddMedicament),
      ),
    );
  }
}

Container myliste(String photo, String text, IconButton icon){
  return Container(
    margin: EdgeInsets.all(10),
    height: 50,
    decoration: BoxDecoration(
        color: Color(0xffefeaea),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,0),
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 4,
          )
        ]
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(photo),
        radius: 20,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black
            )
        ),
      ),
      trailing: IconButton(
        onPressed: (){},
        icon: icon,
      ),
    ),
  );
}
