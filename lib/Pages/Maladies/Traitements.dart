import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Animations/bullet_point.dart';

class TraitementsMaladies extends StatefulWidget {
  const TraitementsMaladies({super.key});

  @override
  State<TraitementsMaladies> createState() => _TraitementsMaladiesState();
}

class _TraitementsMaladiesState extends State<TraitementsMaladies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("L’un des moyens les plus importants de traiter le diabète est de conserver un mode de vie sain.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(height: 20,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Les types de traitements possibles sont:",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    BulletList([
                      "Traitements médicaux",
                      "Prévention",
                      "Activité physique régulière",
                      "Arreter de fumer",
                    ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
