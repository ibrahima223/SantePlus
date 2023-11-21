import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/traitement.dart';

Stream<List<traitement>> affichertraitement() {
  User? utilisateurConnecte = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance.collection('traitements')
      .where('idUser', isEqualTo: utilisateurConnecte?.uid)
      .snapshots()
      .map((event) => event.docs.map((e) => traitement.fromMap(e.data(), e.reference)).toList());
}