import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:santeplus/Pages/homepage.dart';
import 'package:santeplus/Pages/connexion.dart';
import 'package:santeplus/Pages/listeRappels.dart';
import 'package:santeplus/Pages/listemaladie.dart';
import 'package:santeplus/Pages/listemedicament.dart';
import 'package:santeplus/Pages/listetraitement.dart';
import 'package:santeplus/Pages/profile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}





class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;

  final List<Widget> _pages=[
    const home(),
    const Medicaments(),
    const Maladies(),
    const Traitements(),
    const Profile()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight:Radius.circular(30), topLeft: Radius.circular(30)),
            color: Color(0xff4285f4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                icon: _selectedIndex == 0
                    ? const Icon(
                  Icons.home_rounded,
                  color: Colors.green,
                  size: 35,
                )
                    : const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                icon: _selectedIndex== 1
                    ? const Icon(
                  Icons.medication,
                  color: Colors.green,
                  size: 35,
                )
                    : const Icon(
                  Icons.medication,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    _selectedIndex= 2;
                  });
                },
                icon: _selectedIndex == 2
                    ? const Icon(
                  Icons.coronavirus_outlined,
                  color: Colors.green,
                  size: 35,
                )
                    : const Icon(
                  Icons.coronavirus_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                icon: _selectedIndex == 3
                    ? const Icon(
                  Icons.bubble_chart_outlined,
                  color: Colors.green,
                  size: 35,
                )
                    : const Icon(
                  Icons.bubble_chart_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
                icon: _selectedIndex == 4
                    ? const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.green,
                  size: 35,
                )
                    : const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        )
    );
  }
}
