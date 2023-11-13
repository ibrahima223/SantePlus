import 'package:flutter/material.dart';
class AddTraitement extends StatefulWidget {
  const AddTraitement({super.key});

  @override
  State<AddTraitement> createState() => _AddTraitementState();
}

class _AddTraitementState extends State<AddTraitement> {
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
    );
  }
}
