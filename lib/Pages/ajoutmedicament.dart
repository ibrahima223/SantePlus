import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santeplus/models/medicament.dart';

import '../repositories/medicamentStream.dart';
class AddMedicament extends StatefulWidget {
  const AddMedicament({super.key});

  @override
  State<AddMedicament> createState() => _AddMedicamentState();
}

class _AddMedicamentState extends State<AddMedicament> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3= GlobalKey<FormState>();
  TextEditingController nom_controller= TextEditingController();
  TextEditingController description_controller= TextEditingController();
  var categorie;
   List<String> categories=[
    'Traditionnel',
    'Non-traditionnel'
  ];
  Future<void> validation(String titre, String message,String photo) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(titre),
          content: Text(message),
          actions: <Widget>[
            Center(
              child: Image.asset('assets/images/success.png',
                height: 20,
              ),
            ),
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
        title: const Text("Ajouter un médicament",
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
        child:Container(
          height: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
            color: Color(0xff4285F4)
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child:TextFormField(
                  key: _formKey,
                  controller: nom_controller,
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
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child:DropdownButtonFormField(
                  key: _formKey2,
                  value: categorie,
                    selectedItemBuilder: (BuildContext context) {
                      return categories.map<Widget>((String item) {
                        print("$item");
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList();
                    },
                  items: categories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (selectedItem)=> setState(
                        () {
                      categorie = selectedItem!;
                    },
                  ),
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
                    hintText: "Catégorie",
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child:TextFormField(
                  key:  _formKey3,
                  controller: description_controller,
                  cursorColor: Colors.blue,
                    keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  decoration: InputDecoration(
                    isDense: true,
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
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff048B9A),
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: () async {
                    medicament nouveauMedicament = medicament(
                      id: '',
                      nom: nom_controller.text,
                      description: description_controller.text,
                      categorie: categorie,
                      idUser: '',
                    );

                    try {
                      await nouveauMedicament.create();
                      validation("Succès", "Médicament ajouté avec succès", '');
                      setState(() {
                        _formKey.currentState?.reset();
                        _formKey2.currentState?.reset();
                        _formKey3.currentState?.reset();
                        nom_controller.clear();
                        categorie = null;
                        description_controller.clear();
                      });

                    } catch (e) {
                      validation("Erreur", "Une erreur s'est produite lors de la création",'assets/images/err.png');
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
        ) ,
      ),
    );
  }
}
