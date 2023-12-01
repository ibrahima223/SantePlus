import 'package:flutter/material.dart';
import 'package:santeplus/Pages/Connexion/connexion.dart';
import 'package:santeplus/Pages/Animations/transition.dart';

import '../Animations/animation.dart';
import 'inscription.dart';
class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white70],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/LogoScreen.png',
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                  ),
                  Positioned(
                    bottom: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4285F4),
                          fixedSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                          CustomPageRoute(
                            page: Inscription(),
                            transitionType: TransitionType.fade,
                          ),
                        );
                      },
                      child: DelayedAnimation(
                        delay: 1800,
                        child: Text("Inscription",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4285F4),
                          fixedSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                          CustomPageRoute(
                            page: connexion(),
                            transitionType: TransitionType.fade,
                          ),
                        );
                      },
                      child: DelayedAnimation(
                        delay: 1800,
                        child: Text("Connexion",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}