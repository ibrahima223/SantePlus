import 'package:flutter/material.dart';
import 'package:santeplus/Pages/Medocs/ajoutmedicament.dart';
import 'package:santeplus/Pages/Traitements/ajouttraitement.dart';
import 'package:santeplus/Pages/Medocs/listemedicament.dart';
import 'package:santeplus/Pages/Traitements/listetraitement.dart';
enum PageContext{AddMedicament,AddTraitement}

class FloattingService{
  void _changePage(BuildContext context, PageContext pageContext){
    print('Bouton flottant appuyé!');

    if(pageContext == PageContext.AddMedicament){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddMedicament()),
      );
    } else if (pageContext == PageContext.AddTraitement){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTraitement()),
      );
    }
  }
  FloatingActionButton buildFloatingActionButton(VoidCallback onPressed, BuildContext context, PageContext pageContext) {
    return FloatingActionButton(
      backgroundColor: Color(0xff4285F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: (){
        _changePage(context, pageContext);
      },
      child: Icon(
        Icons.add,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}