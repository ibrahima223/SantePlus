import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:santeplus/Pages/modifiertraitement.dart';
import 'package:santeplus/models/rappel.dart';
import 'package:santeplus/models/traitement.dart';
import 'package:santeplus/repositories/traitementStream.dart';
import '../services/Userservice.dart';
import '../services/floattingservice.dart';
class Traitements extends StatefulWidget {

  const Traitements({super.key,});

  @override
  State<Traitements> createState() => _TraitementsState();
}

class _TraitementsState extends State<Traitements> {
  List<traitement> traitements= [];
  final floattingservice= FloattingService();
  final userservice= UserService();
  bool isSearchActive = false;
  TextEditingController search_input= TextEditingController();
  TextEditingController nominput= TextEditingController();
  TextEditingController descrptioninput= TextEditingController();
  TextEditingController heureinput= TextEditingController();
  void initState(){
    search_input.addListener(() {
      isSearchActive = search_input.text.isNotEmpty;
      setState(() {
        heureinput.text;
      });
    });
    super.initState();
    affichertraitement().listen((event) {
      setState(() {
        traitements= event;
      });
    });
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
                                  label: Text('3'),
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
      Container(
        //padding: const EdgeIn,
        height: 500,
        child: ListView.builder(
          itemCount: traitements.length,
          itemBuilder: (context, index) {
            traitement traitementCourant = traitements[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateTraitement(trait: traitementCourant)),
                );
              },
              child: mylist(
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
                            shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 300),
                                  child: IconButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/ajout_rappel.jpg'),
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
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                  child: TextFormField(
                                    controller: nominput,
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
                                      hintText: "Nom du rappel",
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                  child: TextFormField(
                                    controller: heureinput,
                                    cursorColor: Colors.blue,
                                    readOnly: true,
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
                                      suffixIcon: Icon(Icons.access_time_rounded,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      hintText: "Ex: 10:00",
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                      onTap: () async {
                                        TimeOfDay? pickedTime =  await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if(pickedTime != null ){
                                          print(pickedTime.format(context));
                                          setState(() {
                                            heureinput.text = pickedTime.toString().substring(10,15); //set the value of text field.
                                          });
                                        }else{
                                          print("Time is not selected");
                                        }
                                      }
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                  child: TextFormField(
                                    controller: descrptioninput,
                                    cursorColor: Colors.blue,
                                    keyboardType: TextInputType.text,
                                    maxLines: 3,
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
                                      hintText: "Description",
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff048B9A),
                                      fixedSize: Size(200, 50),
                                    ),
                                    onPressed: () async{
                                      rappel nouveauRappel= rappel(
                                          id: '',
                                          nom: nominput.text,
                                          description: descrptioninput.text,
                                          heure: heureinput.text,
                                          idUser: ''
                                      );
                                      try {
                                        await nouveauRappel.create();
                                        validation("Succès", "Rappel ajouté avec succès");
                                        setState(() {
                                          nominput.clear();
                                          descrptioninput.clear();
                                          heureinput.clear();
                                        });
                                      } catch (e) {
                                        validation("Erreur", "Une erreur s'est produite lors de la création");
                                      }
                                    },
                                    child: Text("Ajouter",
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
                          ),
                        );;
                      },
                    );
                  },
                  icon: const Icon(Icons.access_alarms_rounded, size: 20, color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
          ],

        ),
      ),
      floatingActionButton: floattingservice.buildFloatingActionButton(() {
      }, context, PageContext.AddTraitement),
    );
  }
}

Container mylist(String photo, String text, IconButton icon){
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