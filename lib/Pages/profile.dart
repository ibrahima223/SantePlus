import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff4285F4),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          decoration: BoxDecoration(
              color: Color(0xff4285F4),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70),bottomRight: Radius.circular(70)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    blurRadius: 6,
                    offset: Offset(0, 0)
                )
              ]
          ),
          child: Column(
            children: [
                  Padding(
                    padding: EdgeInsets.only(top:20, bottom: 10),
                    child:CircleAvatar(
                      backgroundImage: AssetImage('assets/images/photo.jpg'),
                      radius: 70,
                    ) ,
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  margin: EdgeInsets.all(0.8),
                  height: 60,
                  child: TextField(
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.green
                          ),
                        ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      filled: true,
                      fillColor: Colors.white,
                        hintText: "Nom de l'utilisateur",
                        hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  margin: EdgeInsets.all(0.8),
                  height: 60,
                  child: TextField(
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.green
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Prenom de l'utilisateur",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  margin: EdgeInsets.all(0.8),
                  height: 60,
                  child: TextField(
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.green
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "E-mail de l'utilisateur",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff048B9A),
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: (){},
                  child: Text("Modifier",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEB4335),
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                  },
                  label: Text("Déconnexion",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  icon: Icon(Icons.login_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
