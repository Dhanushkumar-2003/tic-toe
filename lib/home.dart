import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:image_picker/image_picker.dart';
import 'new.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer plays = AudioPlayer();

  bool ispaly = false;

  Future pla(index) async {
    print("AU");
  }

  // ignore: prefer_final_fields
  List _songs = [];

  String mp3path = '';
  Future mm() async {
    Directory dir = await Directory('/storage/emulated/0/');
    String mp3path = dir.toString();
    print(mp3path);

// ignore: no_leading_underscores_for_local_identifiers
    List<FileSystemEntity> _files;

    _files = dir.listSync(recursive: true, followLinks: false);

    for (FileSystemEntity entit in _files) {
      String path = entit.path;
      if (path.endsWith('.mp3')) _songs.add(entit);
      setState(() {
        _songs; //dummy comment
      });
    }
    print(_songs);
    // print(_songs.length);
  }

  late bool permissionGranted;

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
        print('object');
        mm();
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        permissionGranted = false;
      });
    }
  }

  initState() {
    // // ignore: avoid_print
    _getStoragePermission();
    // _gtStoragePermission();
    print("initState Called");
  }

  List m = [MusicItem(name: '', image: '', path: '')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'music!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w300),
            ),
            Container(
              color: Colors.black,
              width: double.infinity,
              child: const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('image/mm.png'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: ListView.builder(
                    itemCount: _songs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var list = _songs[index].path.toString().split('/');
                      String name = list[list.length - 1];
                      print("LIST ----$list");
                      print("---name---$name");
                      String path = _songs[index].path;
                      print("pat-----$path");
                      // ImagePicker ok = ImagePicker();
                      // File?K
                      // final k = ok.pickImage(source: _songs[index]);
                      // final m = File(k);
                      File? image;
                      Future pickImage() async {
                        {
                          final image = await ImagePicker()
                              .pickImage(source: _songs[index]);
                          print('Failed to pick image: $e');
                        }
                      }

                      return true
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Card(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(185, 0, 0, 0),
                                            Color.fromARGB(255, 19, 16, 67),
                                          ],
                                        )),
                                        child: MusicItem(
                                          name: name,
                                          path: path,
                                          image: '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListTile(
                              leading:
                                  Icon(ispaly ? Icons.pause : Icons.play_arrow),
                              title: Text(_songs[index].path),
                              onTap: () {
                                // pla(index);
                                // pa();
                                //I
                                if (ispaly) {
                                  plays.pause();
                                  ispaly = false;

                                  print('ml');
                                  setState(() {});
                                } else {
                                  plays.play(UrlSource(_songs[index].path));
                                  ispaly = true;
                                  setState(() {});

                                  print('ll');
                                }
                              },
                            );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicItem extends StatefulWidget {
  MusicItem(
      {super.key, required this.name, required this.image, required this.path});
  final String path;
  final String name;
  final String image;
  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  bool isplay = false;

// ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // ignore: unnecessary_null_comparison

          leading: Image(image: AssetImage('image/m.png')),

          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => New(
                          name: widget.name,
                          path: widget.path,
                        )),
              );
            },
          ),
          onTap: () {
            // plays.dispose();
            // plays = AudioPlayer();

            // if (isplay) {
            //   isplay = false;
            //   plays.pause();
            // } else {
            //   isplay = true;
            //   plays.play(UrlSource(widget.path));
            // }
            // setState(() {});
          },
          title: Text(widget.name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
