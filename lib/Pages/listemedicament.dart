import 'package:flutter/material.dart';
import 'package:santeplus/Pages/ajoutmedicament.dart';
import 'package:santeplus/Pages/modifiermedicament.dart';
import 'package:santeplus/Pages/profile.dart';
import 'package:santeplus/services/Userservice.dart';

import '../services/floattingservice.dart';
class Medicaments extends StatefulWidget {
  const Medicaments({super.key});

  @override
  State<Medicaments> createState() => _MedicamentsState();
}

class _MedicamentsState extends State<Medicaments> {
  final floattingservice= FloattingService();
  final userservice= UserService();
  bool isSearchActive = false;
  TextEditingController search_input= TextEditingController();
  void initState(){
    search_input.addListener(() {
      isSearchActive = search_input.text.isNotEmpty;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child:  CircleAvatar(
                              backgroundImage: AssetImage("assets/images/photo.jpg"),
                              radius: 30,
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
                                        return CircularProgressIndicator(
                                          color: Colors.blue,
                                        );
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
                                  label: Text('10'),
                                  child: Icon(
                                    Icons.notifications,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: (){},
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
                        child: TextField(
                          onChanged: (value) {
                            if(search_input.text.length > 1){
                              setState(() {
                                isSearchActive=true;
                              });
                            }else{
                              setState(() {
                                isSearchActive=false;
                              });
                            }
                          },
                          controller: search_input,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Rechercher...',
                              hintStyle: TextStyle(
                                  fontWeight:FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.blue
                              ),
                              suffixIcon: isSearchActive
                                  ? IconButton(
                                icon: Icon(Icons.clear_outlined,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                                onPressed: (){
                                  search_input.clear();
                                },
                              )
                                  : null,
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                                onPressed: (){},
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                GestureDetector(
                  child: mylist(
                      'assets/images/medi.jpg',
                      'Amoxcilline',
                      IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return Dialog(
                                    insetPadding: EdgeInsets.all(20),
                                    shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        width: double.infinity,
                                        height: 300,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(0.8),
                                              child: Column(
                                                children: [
                                                  Text("Amoxicilline",
                                                    style: TextStyle(
                                                      color: Color(0xff18534F),
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("L'amoxicilline est un antibiotique "
                                                      "qui appartient à la classe des pénicillines."
                                                      " Il est utilisé pour traiter diverses infections"
                                                      " bactériennes.",
                                                    style: TextStyle(
                                                      color:Color(0xff18534F),
                                                      fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                    color: Color(0xff4285F4),
                                                  ),
                                                  Text("Les symptômes de cette maladie sont:"
                                                      "Infections bactériennes\n"
                                                      "les infections de l'oreille\n"
                                                      "les infections de la gorge\n"
                                                      "les infections urinaires.",
                                                    style: TextStyle(
                                                        color:Color(0xff18534F),
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                    color: Color(0xff4285F4),
                                                  ),
                                                  Text("Traitements recommandés :\n"
                                                      "Prendre l'amoxicilline conformément aux instructions du professionnel de la santé.\n"
                                                      "Respecter la posologie et la prise",
                                                    style: TextStyle(
                                                        color:Color(0xff18534F),
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ) ,
                                  );
                                }
                            );
                          },
                          icon: const Icon(Icons.info_outline,
                            size: 20,
                            color: Colors.black,
                          )
                      )
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UpdateMedicament()),
                    );
                  },
                )
              ],
            ),
          ],

        ),
      ),
      floatingActionButton: floattingservice.buildFloatingActionButton(() {
      }, context, PageContext.AddMedicament),
    );
  }
}

Container mylist(String photo, String text, IconButton icon){
  return Container(
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage(photo),
            radius: 20,
          ),
        ),

        Text(text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
        ),
        IconButton(
            onPressed: (){},
            icon: icon,
          ),
      ],
    ),
  );
}
