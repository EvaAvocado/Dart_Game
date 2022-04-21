import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_game_tutorial/utilits/global_vars.dart';

import 'entity.dart';

class Explosion extends Entity {
  Explosion(double explosionX, double explosionY) : super("explosion") {
    x = explosionX;
    y = explosionY;
  }

  @override
  Widget build() {
    return Positioned(
      top: y,
      left: x,
      child: sprites[currentSprite],
    );
  }

  @override
  void move() {
    Timer(Duration(seconds: 2), () {
      visible = false;
    });
  }
}
