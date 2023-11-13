import 'package:flutter/material.dart';
class Rappels extends StatefulWidget {
  const Rappels({super.key});

  @override
  State<Rappels> createState() => _RappelsState();
}

class _RappelsState extends State<Rappels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Rappels",
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
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            GestureDetector(
              child: mylist(
                  'assets/images/photo_4.jpg',
                  "C'est l'heure de votre prise"
              ),
            )
          ],
        ),

      ),
    );
  }
}
Container mylist(String photo, String text){
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage(photo),
            radius: 20,
          ),
        ),
        Text(text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
      ],
    ),
  );
}
