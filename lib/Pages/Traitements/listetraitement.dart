import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:santeplus/Pages/Rappels/listerappels.dart';
import 'package:santeplus/Pages/Traitements/modifiertraitement.dart';
import 'package:santeplus/models/rappel.dart';
import 'package:santeplus/models/traitement.dart';
import 'package:santeplus/repositories/traitementStream.dart';
import '../../services/Userservice.dart';
import '../../services/floattingservice.dart';
class Traitements extends StatefulWidget {

  const Traitements({super.key,});

  @override
  State<Traitements> createState() => _TraitementsState();
}

class _TraitementsState extends State<Traitements> {
  // late  List<traitement> traitements= [];
  final floattingservice= FloattingService();
  final userservice= UserService();
  TextEditingController search_input= TextEditingController();
  TextEditingController nominput= TextEditingController();
  TextEditingController descrptioninput= TextEditingController();
  TextEditingController heureinput= TextEditingController();
  void initState(){
    search_input.addListener(() {
      setState(() {
        heureinput.text;
      });
    });
    super.initState();
  }
  Future<void> validation(String titre, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(titre),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
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
      Container(
        //padding: const EdgeIn,
        height: 500,
        child: StreamBuilder<List<traitement>>(
          stream: getAllTraitementByUserId(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<traitement> traitements =
              snapshot.data as List<traitement>;
              if (search_input.text.isNotEmpty) {
                traitements = traitements
                    .where((element) =>
                    element.nom!
                        .toLowerCase()
                        .contains(search_input.text.toLowerCase()))
                    .toList();
              }
              return ListView.builder(
                itemCount: traitements.length,
                itemBuilder: (context, index) {
                  traitement traitementCourant = traitements[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            UpdateTraitement(trait: traitementCourant)),
                      );
                    },
                    child: StreamBuilder<rappel?>(
                        stream: getRappelByTraitementId(traitementCourant.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            // rappel rappels = snapshot.data!;
                            final hasAlarm = false;
                            return mylist(
                              traitementCourant.imageUrl,
                              traitementCourant.nom,
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: Dialog(
                                          backgroundColor: Color(0xff4285F4),
                                          insetPadding: EdgeInsets.all(20),
                                          shadowColor: Color.fromRGBO(
                                              0, 0, 0, 0.5),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 300),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/images/ajout_rappel.jpg'),
                                                  radius: 50,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text('Ajout de rappel',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 40
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10),
                                                child: TextFormField(
                                                  controller: nominput,
                                                  cursorColor: Colors.blue,
                                                  keyboardType: TextInputType
                                                      .text,
                                                  decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      borderSide: const BorderSide(
                                                          color: Colors.green
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(20),
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        )
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: "Nom du rappel",
                                                    hintStyle: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight
                                                            .w500
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10),
                                                child: TextFormField(
                                                    controller: heureinput,
                                                    cursorColor: Colors.blue,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(20),
                                                        borderSide: const BorderSide(
                                                            color: Colors.green
                                                        ),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(20),
                                                          borderSide: BorderSide(
                                                            color: Colors.white,
                                                          )
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      suffixIcon: Icon(Icons
                                                          .access_time_rounded,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                      hintText: "Ex: 10:00",
                                                      hintStyle: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .w500
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      TimeOfDay? pickedTime = await showTimePicker(
                                                        initialTime: TimeOfDay
                                                            .now(),
                                                        context: context,
                                                      );

                                                      if (pickedTime != null) {
                                                        print(
                                                            pickedTime.format(
                                                                context));
                                                        setState(() {
                                                          heureinput.text =
                                                              pickedTime
                                                                  .toString()
                                                                  .substring(10,
                                                                  15); //set the value of text field.
                                                        });
                                                      } else {
                                                        print(
                                                            "Time is not selected");
                                                      }
                                                    }
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10),
                                                child: TextFormField(
                                                  controller: descrptioninput,
                                                  cursorColor: Colors.blue,
                                                  keyboardType: TextInputType
                                                      .text,
                                                  maxLines: 3,
                                                  decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      borderSide: const BorderSide(
                                                          color: Colors.green
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(20),
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        )
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    hintText: "Description",
                                                    hintStyle: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight
                                                            .w500
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: ElevatedButton(
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor: Color(
                                                        0xff048B9A),
                                                    fixedSize: Size(200, 50),
                                                  ),
                                                  onPressed: () async {
                                                    rappel nouveauRappel = rappel(
                                                        id: '',
                                                        nom: nominput.text,
                                                        description: descrptioninput
                                                            .text,
                                                        heure: heureinput.text,
                                                        idUser: '',
                                                        isActive: true,
                                                        idTrait: traitementCourant!
                                                            .id!
                                                    );
                                                    try {
                                                      await nouveauRappel
                                                          .create();
                                                      final reference = nouveauRappel
                                                          .id;
                                                      validation("Succès",
                                                          "Rappel ajouté avec succès");
                                                      setState(() {
                                                        nominput.clear();
                                                        descrptioninput.clear();
                                                        heureinput.clear();
                                                      });
                                                    } catch (e) {
                                                      validation("Erreur",
                                                          "Une erreur s'est produite lors de la création");
                                                    }
                                                  },
                                                  child: Text("Ajouter",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );;
                                    },
                                  );
                                },
                                icon: Icon(
                                    Icons.access_alarms_rounded, size: 20,
                                    color: hasAlarm ? Colors.green : Colors
                                        .black),
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>(UpdateTraitement(trait: traitementCourant,)))
                                  );
                                },
                                icon: Icon(Icons.edit_rounded,
                                  color: Colors.blueAccent,
                                  size: 20,
                                ),
                              ),
                              IconButton(
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
                                                      backgroundImage: AssetImage('assets/images/traitement.jpg'),
                                                      radius: 50,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 20),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                                      child: Text("Souhaitez-vous supprimer ce traitement ?",
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
                                                              traitementCourant.delete();
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
                                icon: Icon(Icons.delete_rounded,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            );
                          } else {
                            return const Text('ggggg');
                          }
                        }),
                  );
                },
              );
            }
          }),
      ),
          ],

        ),
      ),
      floatingActionButton: floattingservice.buildFloatingActionButton(() {
      }, context, PageContext.AddTraitement),
    );
  }
}

Container mylist(String photo, String text, IconButton icon1,IconButton icon2,IconButton icon3){
  return Container(
    margin: EdgeInsets.all(10),
    height: 60,
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
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
        Row(
          children: [
            IconButton(
                onPressed: (){},
                icon: icon1,
              ),
            IconButton(
              onPressed: (){},
              icon: icon2,
            ),
            IconButton(
              onPressed: (){},
              icon: icon3,
            ),
          ],
        ),
      ],
    ),
  );
}