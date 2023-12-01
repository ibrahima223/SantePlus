import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Description.dart';
import 'Syptomes.dart';
import 'Traitements.dart';

class MaladieInfo extends StatefulWidget {
  const MaladieInfo({super.key});

  @override
  State<MaladieInfo> createState() => _MaladieInfoState();
}

class _MaladieInfoState extends State<MaladieInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4285F4),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          bottom:  TabBar(
            labelColor:Colors.white,
            dividerColor: Colors.white,
            indicatorColor: Color(0xff4285F4),
            unselectedLabelColor: Colors.white,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.green,// Couleur noire avec opacité
                width: 4, // Largeur de la ligne de délimitation
              ),
            ),
            labelStyle: const TextStyle(
              backgroundColor: Colors.transparent, // Fond transparent pour le texte de l'onglet sélectionné
            ),
            unselectedLabelStyle: const TextStyle(
              backgroundColor: Colors.transparent, // Fond transparent pour le texte de l'onglet non sélectionné
            ),
            tabs: [
              Tab(icon: Text("Description", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, backgroundColor: Colors.transparent),)),
              Tab(icon: Text("Symptômes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, backgroundColor: Colors.transparent),)),
              Tab(icon: Text("Traitements", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, backgroundColor: Colors.transparent),)),
            ],
          ),
          title: Text("Diabète de type 2",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            DescriptionMaladie(),
            SyptomesMaladies(),
            TraitementsMaladies(),
          ],
        ),
      ),
    );
  }
}
