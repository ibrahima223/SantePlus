import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class rappel{
  String? id;
  String nom;
  String description;
  String heure;
  String idUser;

  rappel({ required this.id,required this.nom, required this.description, required this.heure,required this.idUser});
  factory rappel.fromMap(
      Map<String, dynamic> data, DocumentReference documentReference){
    return rappel(
      id: documentReference.id,
      nom: data['nom'],
      description: data['description'],
      heure: data['categorie'],
      idUser: data ['idUser'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'description': description,
      'heure': heure,
      'nom': nom,
    };
  }

  final firestore = FirebaseFirestore.instance;
  Future<void> update() async {
    final docRef = firestore.collection('rappels').doc(id);
    await docRef.update(toMap());
  }

  Future<void> create() async{
    User? userconnected = FirebaseAuth.instance.currentUser;
    this.idUser = userconnected!.uid;
    final collection = firestore.collection('rappels');
    final docRef = await collection.add(toMap());
    id = docRef.id;
  }

  Future<void> delete() async{
    final docRef = firestore.collection('rappels').doc(id);
    await docRef.delete();
  }
}