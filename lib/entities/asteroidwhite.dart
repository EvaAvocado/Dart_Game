import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_game_tutorial/utilits/global_vars.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'entity.dart';

class AsteroidWhite extends Entity {
  Random rand = Random();
  double _speed = 4;
  double _angle = 0;

  AsteroidWhite() : super("asteroidwhite") {
    //4 рандомных варианта
    switch (rand.nextInt(3)) {
      case 0:
        x = 0;
        break;
      case 1:
        x = GlobalVars.screenWidth;
        break;
      default:
        x = GlobalVars.screenWidth / 2;
        break;
    }

    if (x == 0 || x == GlobalVars.screenWidth) y = GlobalVars.screenHeight / 2;
    if (x == GlobalVars.screenWidth / 2)
      y = rand.nextBool() ? GlobalVars.screenHeight : 0;

    if (x == 0) {
      x -= 100;
      _angle = 50 + rand.nextDouble() * 80;
    }
    if (x == GlobalVars.screenWidth) {
      x += 100;
      _angle = _angle = -50 + rand.nextDouble() * -80;
    }
    if (y == 0) {
      y -= 100;
      _angle = -40 + rand.nextDouble() * 80;
    }
    if (y == GlobalVars.screenHeight) {
      y += 100;
      _angle = 140 + rand.nextDouble() * 80;
    }

    /*x = flagX ? 0 : GlobalVars.screenWidth;
    y = flagY ? GlobalVars.screenHeight/2 : GlobalVars.screenHeight;
    x += flagX ? -100 : 100;
    y += flagY ? -100 : 100;

    if (flagX && flagY) _angle = 30 + rand.nextDouble() * 30;
    if (flagX && !flagY) _angle = 120 + rand.nextDouble() * 30;
    if (!flagX && !flagY) _angle = -120 + rand.nextDouble() * -30;
    if (!flagX && flagY) _angle = -30 + rand.nextDouble() * -30;*/
  }

  @override
  Widget build() {
    return Positioned(top: y, left: x, child: sprites[currentSprite]);
  }

  @override
  void move() {
    x += sin(_angle) * _speed;
    y -= cos(_angle) * _speed;
    if (x > GlobalVars.screenWidth + 110 ||
        y > GlobalVars.screenHeight + 110 ||
        x < -110 ||
        y < -110) {
      visible = false;
    }
  }
}
