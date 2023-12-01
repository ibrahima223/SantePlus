import 'package:flutter/material.dart';

class DescriptionMaladie extends StatefulWidget {
  const DescriptionMaladie({super.key});

  @override
  State<DescriptionMaladie> createState() => _DescriptionMaladieState();
}

class _DescriptionMaladieState extends State<DescriptionMaladie> {
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
                child: Text("Le diabète de type 2 modifie la façon dont l’organisme utilise le sucre (glucose) comme source d’énergie. Il empêche l’organisme d’utiliser correctement l’insuline, ce qui peut entraîner une forte glycémie s’il n’est pas traité.",
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
                child: Text("Le diabète de type 2 peut souvent être évité. Les facteurs qui contribuent à l’apparition du diabète de type 2 comprennent le surpoids, le manque d’exercice et une prédisposition génétique.",
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
                child: Text("Il est important de poser le diagnostic de bonne heure pour éviter les pires effets du diabète de type 2. La meilleure façon de dépister le diabète tôt est de consulter un prestataire de soins pour faire des examens réguliers et des tests sanguins.",
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
