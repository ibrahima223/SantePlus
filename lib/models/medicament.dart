import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
