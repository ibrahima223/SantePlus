import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/Pages/Animations/bottomnavigatorbar.dart';
import 'package:santeplus/Pages/Inscription/inscription.dart';
import 'package:santeplus/models/utilisateur.dart';
class connexion extends StatefulWidget {
  const connexion({super.key});

  @override
  State<connexion> createState() => _connexionState();
}

class _connexionState extends State<connexion>{
  TextEditingController email_controller= TextEditingController();
  final motpasse_controller= TextEditingController();
  bool _obscureText = true;
  bool _emailVide = false;
  bool _emailInvalide = false;
  bool _motpasseVide = false;
  bool erreurMotDePasse= false;
  void _toogleObscured(){
    setState(() {
      _obscureText=!_obscureText;
    });
  }
  bool isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  Future<void>ConnectUser() async {
    setState(() {
      _emailVide= email_controller.text.isEmpty;
      _motpasseVide= motpasse_controller.text.isEmpty;
      _emailInvalide = !isEmailValid(email_controller.text);
    });
    if(!_emailVide && !_motpasseVide && !_emailInvalide){
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_controller.text,
          password: motpasse_controller.text,
        );
        print('Connexion réussie');
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

        /*getUserPassword(credential.user!.uid).then((String? motDePasseFirestore) {
          if (motDePasseFirestore != null && motDePasseFirestore == motpasse_controller.text) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            setState(() {
              erreurMotDePasse = true;
            });
          }
        });*/

      }
      catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            print('Aucun utilisateur trouvé avec cette adresse e-mail.');
          } else if (e.code == 'wrong-password') {
            print('Mauvais mot de passe fourni pour cet utilisateur.');
          }
        } else {
          print('Erreur inattendue : $e');
        }
      }
    }

  }

  /*Future<String?> getUserPassword(String userId) async {
    try {
      /*QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('utilisateur')
          .where('email', isEqualTo: email)
          .get();*/


      final docRef = await FirebaseFirestore.instance.collection("utilisateur").doc(userId);
      docRef.get().then(
            (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          Users current = Users.fromMap(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );

    } catch (e) {
      print('Erreur lors de la récupération du mot de passe : $e');
      return null;
    }
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd9d9d9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo.png'),
            Padding(
              padding: EdgeInsets.only(top:40),
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,0),
                          blurRadius: 6,
                          color: Color.fromRGBO(0, 0, 0, 0.4)
                      )
                    ]
                ),
                child: TextField(
                  controller: email_controller,
                  decoration: InputDecoration(
                    errorText: _emailVide
                        ? 'Veuillez remplir le champ vide'
                        : _emailInvalide
                        ? 'E-mail non valide'
                        : null,
                      focusColor: Colors.red,
                      hintStyle: TextStyle(
                          color: Color(0xff34A853),
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                      hintText: 'Adresse e-mail',
                      prefixIcon: Icon(Icons.email,
                        size: 30,
                        color: Color(0xff34A853),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none)
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:30),
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,0),
                          blurRadius: 6,
                          color: Color.fromRGBO(0, 0, 0, 0.4)
                      )
                    ]
                ),
                child: TextField(
                  controller: motpasse_controller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    errorText: _motpasseVide
                        ? 'Veuillez remplir le champ vide'
                        : erreurMotDePasse
                        ? 'Mot de passe incorrect'
                        : null,
                      focusColor: Colors.red,
                      hintStyle: TextStyle(
                          color: Color(0xff34A853),
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                      hintText: 'Mot de passe',
                      prefixIcon: Icon(Icons.lock,
                        size: 30,
                        color: Color(0xff34A853),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: GestureDetector(
                          onTap: _toogleObscured,
                          child: Icon(
                            color: Color(0xff34A853),
                            _obscureText
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none)
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                 fixedSize: Size(0,70),
                  backgroundColor: Color(0xff34A853),
                  shadowColor:Color.fromRGBO(0, 0, 0, 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                onPressed: (){
                  ConnectUser();
                },
                child: Text('Connexion',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Si vous n'avez pas de compte?"),
                  TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Inscription())
                        );
                      },
                      child: Text("Inscription",
                          style: TextStyle(
                              color: Color(0xff34A853),
                              fontSize: 20,
                          )
                      )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}