import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicamentInfo extends StatefulWidget {
  const MedicamentInfo({super.key});

  @override
  State<MedicamentInfo> createState() => _MedicamentInfoState();
}

class _MedicamentInfoState extends State<MedicamentInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          title: const Text("Informations sur le médicament",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff4285F4),
        ),
        body: SingleChildScrollView(),
      ),
    );
  }
}
