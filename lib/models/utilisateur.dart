class Users{
  String nom;
  String prenom;
  String email;
  String imageURL;

  Users({required this.nom, required this.prenom, required this.email, required this.imageURL});

  factory Users.fromMap(
      Map<String, dynamic> data){
    return Users(
      prenom: data['prenom'],
      nom: data['nom'],
      email: '',
      imageURL: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prenom': prenom,
      'nom': nom,
    };
  }
}