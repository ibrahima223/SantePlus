// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Medicament {
  final String? idAdmin;
  final String? nom;
  final String? description;
  final String? categorie;
  final String? imageUrl;
  final String? title;
  final String? dosage;
  final String? frequence;
  final int stock_depart;
  final int stock_restant;

  Medicament({
    this.idAdmin,
    this.nom,
    this.description,
    this.categorie,
    this.imageUrl= "assets/images/medicament.jpg",
    this.title,
    this.dosage,
    this.frequence,
    this.stock_depart = 1,
    this.stock_restant = 0,
  });

  int get pourcentage {
    return int.parse(((stock_restant * 100) / stock_depart).toStringAsFixed(0));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idAdmin': idAdmin,
      'nom': nom,
      'description': description,
      'categorie': categorie,
      'imageUrl': imageUrl,
      'title': title,
      'dosage': dosage,
      'frequence': frequence,
      'stock_depart': stock_depart,
      'stock_restant': stock_restant,
    };
  }

  factory Medicament.fromMap(Map<String, dynamic> map) {
    return Medicament(
      idAdmin: map['idAdmin'] != null ? map['idAdmin'] as String : null,
      nom: map['nom'] != null ? map['nom'] as String : null,
      description:
      map['description'] != null ? map['description'] as String : null,
      categorie: map['categorie'] != null ? map['categorie'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      dosage: map['dosage'] != null ? map['dosage'] as String : null,
      frequence: map['frequence'] != null ? map['frequence'] as String : null,
      stock_depart: map['stock_depart'] as int,
      stock_restant: map['stock_restant'] as int,
    );
  }

  // Future<void> addMedicament(Medicament medicament) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('medicaments').add(
  //       medicament.toMap(),
  //     );
  //     print('Médicament ajouté avec succès à Firebase');
  //   } catch (e) {
  //     print('Erreur lors de l\'ajout du médicament à Firebase : $e');
  //   }
  // }

  Stream<List<Medicament>> getAdminListMedicaments() {
    return _firestore.collection('medicaments').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Medicament(
          idAdmin: data['idAdmin'] ?? '',
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
