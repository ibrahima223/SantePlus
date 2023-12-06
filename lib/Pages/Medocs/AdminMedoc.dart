import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/UserMedoc.dart';
import '../../models/medicamentAdmin.dart';

class AdminMedoc extends StatefulWidget {
  const AdminMedoc({super.key});

  @override
  State<AdminMedoc> createState() => _AdminMedocState();
}

class _AdminMedocState extends State<AdminMedoc> {
  @override
  Widget build(BuildContext context) {
    UserMedocController userMedocController =
    Provider.of<UserMedocController>(context);
    return SingleChildScrollView(
      child: StreamBuilder<List<Medicament>>(
        stream: userMedocController.getAdminListMedicaments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Medicament> adminMedicaments = snapshot.data!;
            return Container(
              height: 500,
              child: ListView.builder(
                itemCount: adminMedicaments.length,
                itemBuilder: (context, index) {
                  Medicament medicament = adminMedicaments[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: mycard(
                      medicament.imageUrl!,
                      medicament.nom!,
                      medicament.description!,
                      IconButton(
                          onPressed:(){},
                          icon: Icon(Icons.visibility,
                            color: Colors.green,
                            size: 20,
                          )
                      )
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Erreur: ${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

Card mycard(String photo, String nom, String des, IconButton icon){
  return Card(
    margin: EdgeInsets.all(8),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(photo),
        radius: 20,
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(nom,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                )
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(des,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black
            )
        ),
      ),
      trailing: IconButton(
        onPressed: (){},
        icon: icon,
      ),
    ),
  );
}
