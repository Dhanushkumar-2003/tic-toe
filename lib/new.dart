import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:audioplayers/audioplayers.dart';

class New extends StatefulWidget {
  New({super.key, required this.name, required this.path});
  String name;
  String path;
  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  void changeSliderValue(double value) {
    setState(() {});
  }

  bool isplay = false;
  AudioPlayer plays = AudioPlayer();

  // double _value = 0.5;
  Duration _value = Duration.zero;

  Duration pos = Duration(seconds: 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 67),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(185, 0, 0, 0),
            Color.fromARGB(255, 19, 16, 67),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(146),
                  child: const Center(
                      child:
                       Image(
                    height: 400,
                    image: AssetImage('image/m.png'),
                    fit: BoxFit.fitHeight,
                  )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Slider(
              min: 0.0,
              max: 100,
              activeColor: Colors.blue,
              inactiveColor: Colors.white,
              value: _value.inSeconds.toDouble(),
              onChanged: (double value) async {
                _value = Duration(seconds: value.toInt());
                await plays.seek(_value);
                setState(() {});
              },
            ),
            Row(
              children: [
                Text(
                  _value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 40,
                child: IconButton(
                  padding: EdgeInsets.only(right: 1),
                  focusColor: Colors.white,
                  icon: Icon(
                    isplay ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 54,
                  ),
                  onPressed: () {
                    if (isplay) {
                      isplay = false;
                      plays.pause();
                    } else {
                      isplay = true;
                      plays.play(UrlSource(widget.path));
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
