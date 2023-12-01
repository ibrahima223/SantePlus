import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/medicament.dart';
import 'modifiermedicament.dart';

class UserMedoc extends StatefulWidget {
  const UserMedoc({super.key});

  @override
  State<UserMedoc> createState() => _UserMedocState();
}

class _UserMedocState extends State<UserMedoc> {
  TextEditingController search_input= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            // //padding: const EdgeIn,
            height: 500,
            child: StreamBuilder<List<medicament>>(
                stream: getAllMedicamentByUserId(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<medicament> medicamentss =
                    snapshot.data as List<medicament>;
                    if (search_input.text.isNotEmpty) {
                      medicamentss = medicamentss
                          .where((element) =>
                          element.nom!
                              .toLowerCase()
                              .contains(search_input.text.toLowerCase()))
                          .toList();
                    }
                    return ListView.builder(
                      itemCount: medicamentss.length,
                      itemBuilder: (context, index) {
                        medicament medicamentCourant = medicamentss[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myliste(
                            medicamentCourant.imageUrl,
                            medicamentCourant.nom,
                            IconButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>(UpdateMedicament(med: medicamentCourant,)))
                                );
                              },
                              icon: Icon(Icons.edit_rounded,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return Dialog(
                                        insetPadding: EdgeInsets.all(20),
                                        shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
                                        child: Container(
                                          height: 350,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 30),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage('assets/images/delete.jpg'),
                                                  radius: 50,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 20),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                                  child: Text("Souhaitez-vous supprimer ce médicament ?",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 10),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color(0xffeb4335),
                                                          fixedSize: Size(100, 50),
                                                        ),
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("NON",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 20
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 10),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color(0xff048b9a),
                                                          fixedSize: Size(100, 50),
                                                        ),
                                                        onPressed: (){
                                                          medicamentCourant.delete();
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("OUI",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 20
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                );
                              },
                              icon: Icon(Icons.delete_rounded,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
            ),
          ),
        );
  }
}
Container myliste(String photo, String text, IconButton icon1, IconButton icon2){
  return Container(
    height: 50,
    decoration: BoxDecoration(
        color: const Color(0xffefeaea),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const[
          BoxShadow(
            offset: Offset(0,0),
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 4,
          )
        ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(photo),
          radius: 20,
        ),
        Text(text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: (){},
              icon: icon1,
            ),
            IconButton(
              onPressed: (){},
              icon: icon2,
            )
          ],
        ),
      ],
    ),
  );
}
