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
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Text('test test'),
      ),
    );
  }
}
