import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_tutorial/game_core/game.dart';
import 'package:flutter_game_tutorial/utilits/global_vars.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .whenComplete(() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    runApp(MaterialApp(
      home: MyAppMaterial(),
      debugShowCheckedModeBanner: false,
    ));
  });
}

class MyAppMaterial extends StatefulWidget {
  const MyAppMaterial({Key key}) : super(key: key);

  @override
  State<MyAppMaterial> createState() => _MyAppMaterialState();
}

class _MyAppMaterialState extends State<MyAppMaterial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: UniqueKey(),
        child: Scaffold(
          body: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    initGame();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
        child: Game());
  }

  void initGame() {
    GlobalVars.screenWidth = MediaQuery.of(context).size.width;
    GlobalVars.screenHeight = MediaQuery.of(context).size.height;
  }
}
