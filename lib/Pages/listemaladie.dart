import 'package:flutter/material.dart';
import 'package:santeplus/services/Userservice.dart';
class Maladies extends StatefulWidget {
  const Maladies({super.key});

  @override
  State<Maladies> createState() => _MaladiesState();
}

class _MaladiesState extends State<Maladies> {
  final userservice= UserService();
  bool isSearchActive = false;
  TextEditingController search_input= TextEditingController();
  void initState(){
    search_input.addListener(() {
      isSearchActive = search_input.text.isNotEmpty;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(80), bottomRight: Radius.circular(80) ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                              offset: Offset(0, 0),
                            )
                          ],
                          color: Color(0xff4285F4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child:  CircleAvatar(
                                backgroundImage: AssetImage("assets/images/photo.jpg"),
                                radius: 30,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Bienvenue,',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20
                                      ),
                                    ),
                                    FutureBuilder<String>(
                                      future: userservice.getUser(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return Text(
                                            '${snapshot.data}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Erreur : ${snapshot.error}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          );
                                        } else {
                                          return const CircularProgressIndicator(
                                            color: Colors.blue,
                                          );
                                        }
                                      },
                                    )
                                  ],
                                )
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Badge(
                                    label: Text('10'),
                                    child: Icon(
                                      Icons.notifications,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: (){},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 160),
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              if(search_input.text.length > 1){
                                setState(() {
                                  isSearchActive=true;
                                });
                              }else{
                                setState(() {
                                  isSearchActive=false;
                                });
                              }
                            },
                            controller: search_input,
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:const BorderSide(
                                      color: Colors.green,
                                    )
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Rechercher...',
                                hintStyle: const TextStyle(
                                    fontWeight:FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.blue
                                ),
                                suffixIcon: isSearchActive
                                    ? IconButton(
                                  icon: const Icon(Icons.clear_outlined,
                                    size: 25,
                                    color: Colors.blue,
                                  ),
                                  onPressed: (){
                                    search_input.clear();
                                  },
                                )
                                    : null,
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.search,
                                    size: 25,
                                    color: Colors.blue,
                                  ),
                                  onPressed: (){},
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    )
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  GestureDetector(
                    child: mylist(
                        'assets/images/maladie.jpg',
                        'Diabète de type 2',
                        IconButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Dialog(
                                      insetPadding: EdgeInsets.all(20),
                                      shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width: double.infinity,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.white
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(0.8),
                                                child: Column(
                                                  children: [
                                                    Text("Diabète de type 2",
                                                      style: TextStyle(
                                                          color: Color(0xff18534F),
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text("C’est une maladie métabolique chronique "
                                                        "caractérisée par une résistance à l'insuline et"
                                                        " une élévation de la glycémie.",
                                                      style: TextStyle(
                                                          color:Color(0xff18534F),
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 10,
                                                      color: Color(0xff4285F4),
                                                    ),
                                                    Text("Les symptômes de cette maladie sont:"
                                                        "Polydipsie (soif excessive)\n"
                                                        "Fatigue\n"
                                                        "Faim excessive",
                                                      style: TextStyle(
                                                          color:Color(0xff18534F),
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 10,
                                                      color: Color(0xff4285F4),
                                                    ),
                                                    Text("Traitements recommandés:"
                                                        "Adopter un régime alimentaire équilibré\n"
                                                        " faire de l'exercice régulièrement\n"
                                                        " et perdre du poids si nécessaire\n"
                                                        "Médicaments",
                                                      style: TextStyle(
                                                          color:Color(0xff18534F),
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ) ,
                                    );
                                  }
                              );
                            },
                            icon: const Icon(Icons.info_outline,
                              size: 20,
                              color: Colors.black,
                            )
                        )
                    ),
                    onTap: (){

                    },
                  )
                ],
              ),
            ],

          ),
        ),
    );
  }
}
Container mylist(String photo, String text, IconButton icon){
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
        Text(text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
        IconButton(
            onPressed: (){},
            icon: icon,
          ),
      ],
    ),
  );
}
