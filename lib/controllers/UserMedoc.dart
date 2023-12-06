import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/medicamentAdmin.dart';

class UserMedocController extends ChangeNotifier {
  Stream<List<Medicament>> getAdminListMedicaments(String adminId) {
    return FirebaseFirestore.instance
        .collection('medicaments')
        .where('idAdmin', isEqualTo: adminId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Medicament(
          idAdmin: data['idAdmin'],
          nom: data['nom'] ?? '',
          description: data['description'] ?? '',
          categorie: data['categorie'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          title: data['title'] ?? '',
          dosage: data['dosage'] ?? '',
          frequence: data['frequence'] ?? '',
          stock_depart: data['stock_depart'] ?? 0,
          stock_restant: data['stock_restant'] ?? 0,
        );
      }).toList();
    });
  }
}
