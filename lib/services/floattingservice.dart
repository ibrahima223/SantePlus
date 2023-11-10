import 'package:flutter/material.dart';

class FloattingService{
  FloatingActionButton buildFloatingActionButton(VoidCallback onPressed) {
    return FloatingActionButton(
      backgroundColor: Color(0xff4285F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: (){},
      child: Icon(
        Icons.add,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}