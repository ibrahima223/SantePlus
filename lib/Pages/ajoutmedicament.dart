import 'package:flutter/material.dart';
class AddMedicament extends StatefulWidget {
  const AddMedicament({super.key});

  @override
  State<AddMedicament> createState() => _AddMedicamentState();
}

class _AddMedicamentState extends State<AddMedicament> {
  var _selectedOnes;
   List<String> _Ones=[
    'Traditionnel',
    'Non-traditionnel'
  ];
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
                  onPressed: (){},
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
