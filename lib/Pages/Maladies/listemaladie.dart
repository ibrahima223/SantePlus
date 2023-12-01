import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/Pages/Rappels/listerappels.dart';
import 'package:santeplus/Pages/Maladies/user_maladie.dart';
import 'package:santeplus/services/Userservice.dart';

import 'admin_maladie.dart';
class Maladies extends StatefulWidget {
  const Maladies({super.key});

  @override
  State<Maladies> createState() => _MaladiesState();
}

class _MaladiesState extends State<Maladies> {
  final userservice= UserService();
  TextEditingController search_input= TextEditingController();
  int currentIndex = 0;
  void initState(){
    search_input.addListener(()=> setState(() {
    }));
    super.initState();
  }
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
                          decoration: const BoxDecoration(
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
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child:  CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/profile_1.jpg"),
                                  radius: 30,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right: 100),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Bienvenue,',
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
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                              'Erreur : ${snapshot.error}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      )
                                    ],
                                  )
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Badge(
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
        SizedBox(height: 20),
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
              currentIndex = index;
            });
          },

          tabs: [
            Tab(icon: Text("Tous les maladies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, backgroundColor: Colors.transparent),)),
            Tab(icon: Text("Mes maladies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        ),
                Column(
                  children: [
                    (currentIndex == 0)? AdminMaladie()
                        : UserMaladie(),
                  ],
                ),

              ],
            ),
          ),
      ),
    );
  }
}
Container mylist(String photo, String text){
  return Container(
    height: 50,
    decoration: BoxDecoration(
        color: const Color(0xffefeaea),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const[
          BoxShadow(
            offset: Offset(0,0),
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 4,
          )
        ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage(photo),
            radius: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(text,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
        ),
        // IconButton(
        //     onPressed: (){},
        //     icon: icon,
        //   ),
      ],
    ),
  );
}
