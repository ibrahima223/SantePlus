import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/traitement.dart';
class UpdateTraitement extends StatefulWidget {
  final traitement trait;
  const UpdateTraitement({super.key, required this.trait});

  @override
  State<UpdateTraitement> createState() => _UpdateTraitementState();
}

class _UpdateTraitementState extends State<UpdateTraitement> {
  DateTime selectedDate = DateTime.now();
  TextEditingController nom_traitInput= TextEditingController();
  TextEditingController nom_medicInput= TextEditingController();
  TextEditingController frequenceInput= TextEditingController();
  TextEditingController dosage_Input= TextEditingController();
  TextEditingController date_debutInput = TextEditingController();
  TextEditingController date_finInput= TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    )) ??
        selectedDate;

    if (picked != true && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: const Text("Ajouter un traitement",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4285F4),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
              color: Color(0xff4285F4)
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child:TextFormField(
                  controller: nom_traitInput,
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
                    hintText: widget.trait.nom,
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child:TextFormField(
                  controller: nom_medicInput,
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
                    hintText: widget.trait.nom_medicament,
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child:TextFormField(
                  controller: dosage_Input,
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.number,
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
                    hintText: widget.trait.dosage,
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child:TextFormField(
                  controller: frequenceInput,
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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
                    hintText: widget.trait.frequence,
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child:TextFormField(
                  readOnly: true,
                    controller: date_debutInput,
                    cursorColor: Colors.blue,
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
                      hintText: widget.trait.date_debut,
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate =
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                        DateFormat('yyyy-MM-dd')
                            .format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          date_debutInput.text = formattedDate;
                        });
                      } else {}
                    }
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child:TextFormField(
                  readOnly: true,
                    controller: date_finInput,
                    cursorColor: Colors.blue,
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
                      hintText: widget.trait.date_fin,
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate =
                      await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                        DateFormat('yyyy-MM-dd')
                            .format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          date_finInput.text = formattedDate;
                        });
                      } else {}
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff048B9A),
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: (){
                    widget.trait.nom= nom_traitInput.text=='' ? widget.trait.nom: nom_traitInput.text;
                    widget.trait.nom_medicament= nom_medicInput.text=='' ? widget.trait.nom_medicament: nom_medicInput.text;
                    widget.trait.dosage = dosage_Input.text=='' ? widget.trait.dosage: dosage_Input.text;
                    widget.trait.frequence= frequenceInput.text=='' ? widget.trait.frequence: frequenceInput.text;
                    widget.trait.date_debut= date_debutInput.text=='' ? widget.trait.date_debut: date_debutInput.text;
                    widget.trait.date_fin= date_finInput.text=='' ? widget.trait.date_fin: date_finInput.text;
                    widget.trait.update();
                    validation("Succès", "Traitement modifié avec succès");
                  },
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
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffeb4335),
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
                                              widget.trait.delete();
                                              Navigator.of(context).pop();
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
                  child: Text("Supprimer",
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
      ),
    );
  }
}
