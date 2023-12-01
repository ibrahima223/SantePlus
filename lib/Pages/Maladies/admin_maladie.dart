import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'listemaladie.dart';
import 'maladie_info.dart';

class AdminMaladie extends StatefulWidget {
  const AdminMaladie({super.key});

  @override
  State<AdminMaladie> createState() => _AdminMaladieState();
}

class _AdminMaladieState extends State<AdminMaladie> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      children: [
        GestureDetector(
          child: mylist(
              'assets/images/mal.jpg',
              'Diabète de type 2',
              // IconButton(
              //     onPressed: (){
              //       showDialog(
              //           context: context,
              //           builder: (BuildContext context){
              //             return Dialog(
              //               insetPadding: EdgeInsets.all(20),
              //               shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
              //               child: SingleChildScrollView(
              //                 child: Container(
              //                   width: double.infinity,
              //                   height: 300,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(15),
              //                       color: Colors.white
              //                   ),
              //                   child: Column(
              //                     children: [
              //                       Padding(
              //                         padding: EdgeInsets.all(0.8),
              //                         child: Column(
              //                           children: [
              //                             Text("Diabète de type 2",
              //                               style: TextStyle(
              //                                   color: Color(0xff18534F),
              //                                   fontSize: 20,
              //                                   fontWeight: FontWeight.bold
              //                               ),
              //                             ),
              //                             Text("C’est une maladie métabolique chronique "
              //                                 "caractérisée par une résistance à l'insuline et"
              //                                 " une élévation de la glycémie.",
              //                               style: TextStyle(
              //                                   color:Color(0xff18534F),
              //                                   fontWeight: FontWeight.w500
              //                               ),
              //                             ),
              //                             Divider(
              //                               height: 10,
              //                               color: Color(0xff4285F4),
              //                             ),
              //                             Text("Les symptômes de cette maladie sont:"
              //                                 "Polydipsie (soif excessive)\n"
              //                                 "Fatigue\n"
              //                                 "Faim excessive",
              //                               style: TextStyle(
              //                                   color:Color(0xff18534F),
              //                                   fontWeight: FontWeight.w500
              //                               ),
              //                             ),
              //                             Divider(
              //                               height: 10,
              //                               color: Color(0xff4285F4),
              //                             ),
              //                             Text("Traitements recommandés:"
              //                                 "Adopter un régime alimentaire équilibré\n"
              //                                 " faire de l'exercice régulièrement\n"
              //                                 " et perdre du poids si nécessaire\n"
              //                                 "Médicaments",
              //                               style: TextStyle(
              //                                   color:Color(0xff18534F),
              //                                   fontWeight: FontWeight.w500
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ) ,
              //             );
              //           }
              //       );
              //     },
              //     icon: const Icon(Icons.info_outline,
              //       size: 20,
              //       color: Colors.black,
              //     )
              // )
          ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MaladieInfo()),
            );
          },
        )
      ],
    );
  }
}
