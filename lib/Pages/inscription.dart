import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/Pages/connexion.dart';
import 'package:santeplus/Pages/bottomnavigatorbar.dart';
class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  String? errorName = null;
  String? errorFirstName = null;
  String? errorEmail= null;
  String? errorPassword= null;
  String? errorConfirm = null;

  bool _obscuredText= true;
  TextEditingController input_nom = TextEditingController();
  TextEditingController input_prenom = TextEditingController();
  TextEditingController input_email = TextEditingController();
  TextEditingController input_motpasse = TextEditingController();
  TextEditingController input_confirm_motpasse = TextEditingController();
  void _toogleObscured(){
    setState(() {
      _obscuredText=!_obscuredText;
    });
  }
  bool verified_motpasse() {
    if(input_confirm_motpasse == input_motpasse) {
      return true;
    }
    return false;
  }

  bool isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  void createUser() async {
    bool passe = verified_motpasse();
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: input_email.text,
          password: input_motpasse.text,
        );
        if(credential.user != null) {
          final uid = credential.user!.uid;
          FirebaseFirestore.instance.collection('utilisateur').doc(uid).set({
            'nom': input_nom.text,
            'prenom': input_prenom.text
          });
         // Navigator.of(context).pushReplacement(MaterialPageRoute(
           // builder: (context) => HomePage(),
          //));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
  }
  String? NameValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    }
    return null;
  }

  String? FisrtNameValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    }
    return null;
  }

  String? EmailValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    } else if (!isEmailValid(value)) {
      return 'Veuillez saisir une adresse email valide.';
    }
    return null;
  }

  String? PasswordValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    }
    return null;
  }

  String? ConfirmValidate(String value) {
    if (value.isEmpty) {
      return 'Veuillez remplir le champ vide';
    } else if (value != input_motpasse.text) {
      return 'Les mots de passe ne correspondent pas.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd9d9d9),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo.png'),
              Padding(
                padding: EdgeInsets.only(top:20),
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
                    controller: input_nom,
                    decoration: InputDecoration(
                      errorText: errorName,
                        focusColor: Colors.red,
                        hintStyle: TextStyle(
                            color: Color(0xff34A853),
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),
                        hintText: 'Nom',
                        prefixIcon: Icon(Icons.person,
                          size: 30,
                          color: Color(0xff34A853),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none)
                    ),
                      onChanged: (value){
                        setState(() {
                          errorName= NameValidate(value);
                        });
                      },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20),
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
                    controller: input_prenom,
                    decoration: InputDecoration(
                      errorText: errorFirstName,
                        focusColor: Colors.red,
                        hintStyle: TextStyle(
                            color: Color(0xff34A853),
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),
                        hintText: 'Prenom',
                        prefixIcon: Icon(Icons.person,
                          size: 30,
                          color: Color(0xff34A853),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none)
                    ),
                      onChanged: (value){
                        setState(() {
                          errorFirstName= FisrtNameValidate(value);
                        });
                      }
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:20),
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
                    controller: input_email,
                    decoration: InputDecoration(
                      errorText: errorEmail,
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
                      onChanged: (value){
                        setState(() {
                          errorEmail= EmailValidate(value);
                        });
                      }
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:20),
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
                    controller: input_motpasse,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscuredText,
                    decoration: InputDecoration(
                      errorText: errorPassword,
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
                              _obscuredText
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none)
                    ),
                      onChanged: (value){
                        setState(() {
                          errorPassword= PasswordValidate(value);
                        });
                      }
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:20),
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
                    controller: input_confirm_motpasse,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscuredText,
                    decoration: InputDecoration(
                      errorText:errorConfirm,
                        focusColor: Colors.red,
                        hintStyle: TextStyle(
                            color: Color(0xff34A853),
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),
                        hintText: 'Confirmer mot de passe',
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
                              _obscuredText
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none)
                    ),
                      onChanged: (value){
                        setState(() {
                          errorConfirm= ConfirmValidate(value);
                        });
                      }
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(0,70),
                      backgroundColor: Color(0xff34A853),
                      shadowColor:Color.fromRGBO(0, 0, 0, 0.4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  onPressed: () {
                    setState(() {
                      errorName = NameValidate(input_nom.text);
                      errorFirstName = FisrtNameValidate(input_prenom.text);
                      errorEmail= EmailValidate(input_email.text);
                      errorPassword = PasswordValidate(input_motpasse.text);
                      errorConfirm = ConfirmValidate(input_confirm_motpasse.text);
                    });
                    if (errorName == null &&
                        errorFirstName == null &&
                        errorEmail == null &&
                        errorPassword == null &&
                        errorConfirm == null) {
                      createUser();
                    }

                  },

                  child: Text("S'incrire",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Avez-vous un compte?"),
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Connexion",
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

