import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mp3/home.dart';

class Splsh extends StatefulWidget {
  const Splsh({super.key});

  @override
  State<Splsh> createState() => _SplshState();
}

class _SplshState extends State<Splsh> {
  initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 150),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('image/mm.png'),
                ),
              ),
            ),
            Container(
                width: 240,
                height: 400,
                padding: EdgeInsets.only(top: 100),
                child: LoadingIndicator(
                    strokeWidth: 7,
                    indicatorType: Indicator.ballClipRotateMultiple))
          ],
        ),
      ),
    );
  }
}
