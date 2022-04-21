import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_game_tutorial/entities/entity.dart';
import 'package:flutter_game_tutorial/utilits/global_vars.dart';

class AsteroidBig extends Entity {
  Random rand = Random();
  double _speed = 4;
  double _angle = 0;
  bool flagX = true;
  bool flagY = true;

  AsteroidBig() : super("asteroidbig") {
    flagX = rand.nextBool();
    flagY = rand.nextBool();

    x = flagX ? 0 : GlobalVars.screenWidth;
    y = flagY ? 0 : GlobalVars.screenHeight;
    x += flagX ? -100 : 100;
    y += flagY ? -100 : 100;

    if (flagX && flagY) _angle = 30 + rand.nextDouble() * 30;
    if (flagX && !flagY) _angle = 120 + rand.nextDouble() * 30;
    if (!flagX && !flagY) _angle = -120 + rand.nextDouble() * -30;
    if (!flagX && flagY) _angle = -30 + rand.nextDouble() * -30;

    /*x = x = rand.nextDouble() * GlobalVars.screenWidth;
    x += rand.nextBool() ? 700 : -700;

    y = rand.nextDouble() * GlobalVars.screenHeight;
    y += rand.nextBool() ? 700 : -700;

    if (x < 0 && y > GlobalVars.screenHeight) {
      //начало значения угла на который надо повернуть + случайное число размером в интервал нужного угла
      _angle = 95 + rand.nextDouble() * 80;
    }
    if (x < 0 && y < 0) {
      _angle = 5 + rand.nextDouble() * 80;
    }
    if (x > GlobalVars.screenWidth && y > GlobalVars.screenHeight) {
      _angle = -(95 + rand.nextDouble() * 80);
    }
    if (x > GlobalVars.screenWidth && y < 0) {
      _angle = -(5 + rand.nextDouble() * 80);
    }*/
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
