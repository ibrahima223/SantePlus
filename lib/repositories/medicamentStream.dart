import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/medicament.dart';

Stream<List<medicament>> affichermedicament() {
  User? utilisateurConnecte = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance.collection('medicaments')
      .where('idUser', isEqualTo: utilisateurConnecte?.uid)
      .snapshots()
      .map((event) => event.docs.map((e) => medicament.fromMap(e.data(), e.reference)).toList());
}
