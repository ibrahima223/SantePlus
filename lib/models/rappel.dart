import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class rappel{
  String? id;
  String nom;
  String description;
  String heure;
  String idUser;
  bool isActive= false;
  String idTrait;

  rappel({ required this.idTrait, required this.isActive, required this.id,required this.nom, required this.description, required this.heure,required this.idUser});
  factory rappel.fromMap(
      Map<String, dynamic> data, DocumentReference documentReference){
    return rappel(
      id: documentReference.id,
      nom: data['nom'],
      description: data['description'],
      heure: data['categorie'],
      idUser: data ['idUser'],
      isActive: data['isActive'],
      idTrait: data['idTrait']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'description': description,
      'heure': heure,
      'nom': nom,
      'isActive': isActive,
      'idTrait': idTrait,
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

Stream<rappel?> getRappelByTraitementId(String idTrait) {
  return FirebaseFirestore.instance
      .collection('rappels')
      .where('idTrait', isEqualTo: idTrait)
      .snapshots()
      .map((querySnapshot) {
    var docs = querySnapshot.docs;
    if (docs.isNotEmpty) {
      var doc = docs.first;
      return rappel.fromMap(doc.data(), doc.reference);
    } else {
      return null; // Retourne null si aucun rappel trouvé
    }
  });
}