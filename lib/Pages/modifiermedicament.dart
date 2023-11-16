import 'package:flutter/material.dart';
import 'package:santeplus/models/medicament.dart';
class UpdateMedicament extends StatefulWidget {
  final medicament med;
  const UpdateMedicament({super.key, required this.med});

  @override
  State<UpdateMedicament> createState() => _UpdateMedicamentState();
}
class _UpdateMedicamentState extends State<UpdateMedicament> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedOnes;
  List<String> _Ones=[
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
        title: const Text("Modifier un médicament",
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
          height: 650,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
              color: Color(0xff4285F4)
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child:TextFormField(
                  controller: _nomController,
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
                    hintText: widget.med.nom,
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
                  value: _selectedOnes,
                  selectedItemBuilder: (BuildContext context) {
                    return _Ones.map<Widget>((String item) {
                      print("$item");
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList();
                  },
                  items: _Ones.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (selectedItem)=> setState(
                        () {
                      _selectedOnes = selectedItem!;
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
                  controller: _descriptionController,
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
                    hintText: widget.med.description,
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
                  onPressed: (){
                    widget.med.nom = _nomController.text == '' ? widget.med.nom : _nomController.text;
                    widget.med.description= _descriptionController.text  == '' ? widget.med.description : _descriptionController.text;
                    widget.med.categorie= _selectedOnes ?? '';
                    widget.med.update();
                    validation("Succès", "Médicament modifié avec succès", '');
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
                padding: EdgeInsets.all(0.8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEB4335),
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
                                      backgroundImage: AssetImage('assets/images/delete.jpg'),
                                      radius: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                      child: Text("Souhaitez-vous supprimer ce médicament ?",
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
                                              widget.med.delete();
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
        ) ,
      ),
    );
  }
}
