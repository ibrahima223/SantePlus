import 'package:flutter/material.dart';
import 'package:santeplus/Pages/homepage.dart';
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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const home(),
    const Medicaments(),
    const Maladies(),
    const Traitements(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xff4285f4),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 30),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medication, size: 30),
                label: 'Médicaments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.coronavirus_outlined, size: 30),
                label: 'Maladies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bubble_chart_outlined, size: 30),
                label: 'Traitements',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined, size: 30),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
