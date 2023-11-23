import 'package:flutter/material.dart';
import 'package:santeplus/Pages/splashScreen2.dart';
import 'package:santeplus/Pages/transition.dart';

import 'animation.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context){
          return Container(
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
                        bottom: 180,
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
                                page: SplashScreen2(),
                                transitionType: TransitionType.fade,
                              ),
                            );
                          },
                          child: DelayedAnimation(
                            delay: 1800,
                            child: Text("Commencer",
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
          );
        }

      ),
      debugShowCheckedModeBanner: false,
      
    );
  }
}