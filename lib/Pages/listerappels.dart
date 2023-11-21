import 'package:flutter/material.dart';
import 'package:santeplus/models/rappel.dart';
import 'package:santeplus/repositories/rappelStream.dart';
class Rappels extends StatefulWidget {
  const Rappels({super.key});

  @override
  State<Rappels> createState() => _RappelsState();
}

class _RappelsState extends State<Rappels> {
  List<rappel> rappels= [];
  @override
  void initState() {
    afficherrappel().listen((event) {
      rappels= event;
    });
    super.initState();
  }
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
        child: Column(
          children: [
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: rappels.length,
                itemBuilder:(context, index){
                  rappel rappelCourant= rappels[index];
                  return GestureDetector(
                    onTap: (){},
                    child: Container(),
                  );
                } ,

              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 10,
                  backgroundColor: Color(0xffEB4335),
                  fixedSize: Size(400, 50),
                ),
                onPressed: (){},
                child: Text("Tout supprimer",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
              )
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage(photo),
            radius: 20,
          ),
        ),
        Padding(
            padding:EdgeInsets.only(right: 25),
          child: Text(text,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
        ),
      ],
    ),
  );
}
