import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:santeplus/models/rappel.dart';
class medicament{
  String? id;
  String imageUrl;
  String nom;
  String description;
  String categorie;
  String idUser;

  medicament({ required this.id, this.imageUrl = 'assets/images/medi.jpg',required this.nom, required this.description, required this.categorie,required this.idUser});
  factory medicament.fromMap(
      Map<String, dynamic> data, DocumentReference documentReference){
    return medicament(
        id: documentReference.id,
        imageUrl: data['imageUrl'],
        nom: data['nom'],
        description: data['description'],
        categorie: data['categorie'],
        idUser: data ['idUser'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'description': description,
      'imageUrl': imageUrl,
      'categorie': categorie,
      'nom': nom,
    };
  }

  final firestore = FirebaseFirestore.instance;
  Future<void> update() async {
    final docRef = firestore.collection('medicaments').doc(id);
    await docRef.update(toMap());
  }

  Future<void> create() async{
     User? userconnected = FirebaseAuth.instance.currentUser;
     this.idUser = userconnected!.uid;
    final collection = firestore.collection('medicaments');
    final docRef = await collection.add(toMap());
    id = docRef.id;
  }

  Future<void> delete() async{
    final docRef = firestore.collection('medicaments').doc(id);
    await docRef.delete();
  }

  // static Future<List<medicament>>researchMedic(String nom) async {
  //   try{
  //     var querySnapshot = await FirebaseFirestore.instance
  //         .collection('medicaments')
  //         .where('nom', isGreaterThanOrEqualTo: nom)
  //         .get();
  //
  //     List<medicament> result = querySnapshot.docs.map((doc) => medicament.fromMap(doc.data())).toList();
  //   }
  //   catch(e){
  //     print("Erreur lors de la recherche des médicaments : $e");
  //     return [];
  //   }
  //   // final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance
  //   //     .collection('medicaments')
  //   //     .where('nom', isEqualTo: nom)
  //   //     .get();
  //   //
  //   // final List<medicament> medicaments = result.docs
  //   //     .map((doc) => medicament.fromMap(doc.data()!, doc.reference))
  //   //     .toList();
  //   //
  //   // return medicaments;
  // }
  static List<medicament> rechercherMedicament(List<medicament> medicaments, String nom) {
    // Filtrer la liste des médicaments en fonction du nom
    List<medicament> resultats = medicaments.where((medicament) => medicament.nom == nom).toList();

    // Vérifier si le médicament est trouvé
    if (resultats.isEmpty) {
      return [];
    } else {
      return resultats;
    }
  }
}
// Ajouter un médicament

Future<void> addmedicament(medicament medicament) async {
  User? userconnected = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection('medicaments').add({
    'imageUrl': 'assets/images/medi.jpg',
    'nom': medicament.nom,
    'description': medicament.description,
    'categorie': medicament.categorie,
    'idUser': userconnected?.uid,
  });


}

Stream<List<medicament>> getAllMedicamentByUserId(String userid) {
  return FirebaseFirestore.instance
      .collection('medicaments')
      .where('idUser', isEqualTo: userid)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((doc) => medicament.fromMap(doc.data(), doc.reference))
      .toList());
}

