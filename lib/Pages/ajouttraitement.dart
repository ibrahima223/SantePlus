import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:santeplus/models/traitement.dart';
class AddTraitement extends StatefulWidget {
  const AddTraitement({super.key});

  @override
  State<AddTraitement> createState() => _AddTraitementState();
}

class _AddTraitementState extends State<AddTraitement> {
  DateTime selectedDate = DateTime.now();
  TextEditingController nom_traitInput= TextEditingController();
  TextEditingController nom_medicInput= TextEditingController();
  TextEditingController dosage_Input= TextEditingController();
  TextEditingController frequence_Input= TextEditingController();
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
          height: 610,
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
                    hintText: "Nom du traitement",
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
                    hintText: "Nom du médicament",
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
                    hintText: "Dosage du traitement",
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
                  controller: frequence_Input,
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
                    hintText: "Fréquence",
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
                    hintText: "Date_Début",
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
                    hintText: "Date_Fin",
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
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff048B9A),
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: () async {
                    traitement nouveautraitement = traitement(
                        idUser: '',
                        id: '',
                        nom: nom_traitInput.text,
                        nom_medicament: nom_medicInput.text,
                        frequence: frequence_Input.text,
                        dosage: dosage_Input.text,
                        date_debut: date_debutInput.text,
                        date_fin: date_finInput.text,
                    );

                    try {
                      await nouveautraitement.create();
                      validation("Succès", "Traitement ajouté avec succès");
                      setState(() {
                        nom_traitInput.clear();
                        nom_medicInput.clear();
                        frequence_Input.clear();
                        dosage_Input.clear();
                        date_debutInput.clear();
                        date_finInput.clear();
                      });
                      Navigator.of(context).pop();

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
      ),
    );
  }
}
