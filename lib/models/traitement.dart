import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class traitement{
  String? id;
  String idUser;
  String imageUrl;
  String nom_medicament;
  String nom;
  String dosage;
  String frequence;
  String date_debut;
  String date_fin;
  List<String>? rappels;

  traitement({ required this.rappels, required this.idUser,required this.id, this.imageUrl = 'assets/images/traite.jpg',required this.nom, required this.nom_medicament, required this.frequence,required this.dosage, required this.date_debut, required this.date_fin});
  factory traitement.fromMap(
      Map<String, dynamic> data, DocumentReference documentReference){
    List<String> rappels = (data['rappels'] as List<dynamic>?)?.map<String>((e) => e.toString()).toList() ?? [];
    return traitement(
      idUser: data['idUser'],
      id: documentReference.id,
      imageUrl: data['imageUrl'],
      nom: data['nom'],
      nom_medicament: data['nom_medicament'],
      dosage: data['dosage'],
      frequence: data ['frequence'],
      date_debut: data['date_debut'],
      date_fin: data['date_fin'],
      rappels: rappels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'nom_medicament': nom_medicament,
      'dosage': dosage,
      'imageUrl': imageUrl,
      'frequence':frequence,
      'nom': nom,
      'date_debut': date_debut,
      'date_fin': date_fin,
      'rappels': rappels,
    };
  }

  final firestore = FirebaseFirestore.instance;
  Future<void> update() async {
    final docRef = firestore.collection('traitements').doc(id);
    await docRef.update(toMap());
  }

  Future<void> create() async{
    User? userconnected = FirebaseAuth.instance.currentUser;
    this.idUser = userconnected!.uid;
    final collection = firestore.collection('traitements');
    final docRef = await collection.add(toMap());
    id = docRef.id;
  }

  Future<void> delete() async{
    final docRef = firestore.collection('traitements').doc(id);
    await docRef.delete();
  }
}
Stream<List<traitement>> getAllTraitementByUserId(String userid) {
  return FirebaseFirestore.instance
      .collection('traitements')
      .where('idUser', isEqualTo: userid)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((doc) => traitement.fromMap(doc.data(), doc.reference))
      .toList());
}