import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/Pages/Animations/bullet_point.dart';

class SyptomesMaladies extends StatefulWidget {
  const SyptomesMaladies({super.key});

  @override
  State<SyptomesMaladies> createState() => _SyptomesMaladiesState();
}

class _SyptomesMaladiesState extends State<SyptomesMaladies> {
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
                child: Text("Les symptômes du diabète peuvent apparaître soudainement. Dans le diabète de type 2, les symptômes peuvent être légers et n’être remarqués qu’au bout de plusieurs années.",
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
                    Text("Les symptômes du diabète comprennent :",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    BulletList([
                      "une soif intense",
                      "le besoin d’uriner plus souvent que d’habitude",
                      "une vision floue",
                      "une sensation de fatigue",
                      "une perte de poids involontaire",
                    ]
                    ),
                  ],
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
                child: Text("Avec le temps, le diabète peut causer des lésions vasculaires dans le cœur, les yeux, les reins et les nerfs.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
