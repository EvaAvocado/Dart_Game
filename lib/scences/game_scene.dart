import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_game_tutorial/entities/asteroidBig.dart';
import 'package:flutter_game_tutorial/entities/asteroidwhite.dart';
import 'package:flutter_game_tutorial/entities/bullet.dart';
import 'package:flutter_game_tutorial/entities/explosion.dart';
import 'package:flutter_game_tutorial/entities/player.dart';
import 'package:flutter_game_tutorial/scences/app_scene.dart';
import 'package:flutter_game_tutorial/utilits/global_vars.dart';

import '../main.dart';

class GameScene extends AppScene {
  Player _player = Player();
  double _startGlobalPosition = 0;
  List<AsteroidBig> _listAsteroidBig = [];
  int _tickAsteroidBig = 0;

  List<AsteroidWhite> _listAsteroidWhite = [];
  int _tickAsteroidWhite = 0;

  List<Explosion> _listExplosion = [];

  List<Bullet> _listBullets = [];
  List<Widget> _listWidgets = [];

  int points = 0;
  int lives = 3;
  int _tickLives = 20;

  GameScene();

  @override
  Widget buildScene(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: FractionalOffset(0.05, 0.95),
            child: Text('Счет: ' + points.toString(),
                textDirection: TextDirection.ltr, // текст слева направо
                style: TextStyle(
                    fontSize: 24, color: Colors.white))), // высота шрифта 24
        Align(
            alignment: FractionalOffset(0.95, 0.95),
            child: Text('Жизни: ' + lives.toString(),
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 24, color: Colors.white))),
        if (_player.visible) _player.build(),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
              ),
            )),
        Positioned(
            top: 0,
            left: GlobalVars.screenWidth / 2,
            child: Container(
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight / 2,
              child: GestureDetector(
                onTap: _onAcceleration,
              ),
            )),
        Positioned(
            top: GlobalVars.screenHeight / 2,
            left: GlobalVars.screenWidth / 2,
            child: Container(
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight / 2,
              child: GestureDetector(
                onTap: _onShoot,
              ),
            )),
        Stack(
          children: _listWidgets,
        ),
        if (lives == -1)
          Container(
              color: Colors.black,
              width: GlobalVars.screenWidth,
              height: GlobalVars.screenHeight,
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('GAME OVER',
                          style: TextStyle(fontSize: 128, color: Colors.white)),
                      TextButton(
                        child: Text('Начать заново',
                            style: TextStyle(fontSize: 24)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          lives = 3;
                          points = 0;
                          _player.x = 50;
                          _player.y = GlobalVars.screenHeight / 2;
                          _player.angle = 0;
                          _player.visible = true;
                          update();
                          // Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyAppMaterial()));
                        },
                      ),
                    ],
                  ))),
      ],
    );
  }

  @override
  void update() {
    _tickLives--;
    _player.update();
    _CreateAsteroidBig();
    _CreateAsteroidWhite();
    _bulletCollisionWithAsteroid();
    _collisionWithAsteroids();

    _listWidgets.clear();

    _listExplosion.removeWhere((element) => !element.visible);
    _listAsteroidBig.removeWhere((element) => !element.visible);
    _listAsteroidWhite.removeWhere((element) => !element.visible);
    _listBullets.removeWhere((element) => !element.visible);

    if (_player.visible == false) {}

    _listExplosion.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });

    _listBullets.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });

    _listAsteroidBig.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });

    _listAsteroidWhite.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });
  }

  void _CreateAsteroidBig() {
    _tickAsteroidBig++;
    if (_tickAsteroidBig > 45) {
      _listAsteroidBig.add(AsteroidBig());
      _tickAsteroidBig = 0;
    }
  }

  void _CreateAsteroidWhite() {
    _tickAsteroidWhite++;
    if (_tickAsteroidWhite > 45) {
      _listAsteroidWhite.add(AsteroidWhite());
      _tickAsteroidWhite = 0;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double _updateGlobalPosition = details.globalPosition.dx;

    if (_updateGlobalPosition > _startGlobalPosition + 30) {
      //right;
      _player.isMoveRight = true;
    }

    if (_updateGlobalPosition < _startGlobalPosition + 30) {
      //left;
      _player.isMoveLeft = true;
    }
  }

  void _onAcceleration() {
    _player.isAcceleration = _player.isAcceleration ? false : true;
  }

  void _onShoot() {
    _listBullets.add(Bullet(_player.getAngle, _player.x, _player.y));
  }

  void _bulletCollisionWithAsteroid() {
    _listBullets.forEach((bullet) {
      _listAsteroidBig.forEach((aBig) {
        if (bullet.x < aBig.x + 20 &&
            bullet.x > aBig.x - 20 &&
            bullet.y < aBig.y + 20 &&
            bullet.y > aBig.y - 20) {
          aBig.visible = false;
          _listExplosion.add(Explosion(bullet.x, bullet.y));
          points++;
        }
      });
      _listAsteroidWhite.forEach((aWhite) {
        if (bullet.x < aWhite.x + 20 &&
            bullet.x > aWhite.x - 20 &&
            bullet.y < aWhite.y + 20 &&
            bullet.y > aWhite.y - 20) {
          aWhite.visible = false;
          _listExplosion.add(Explosion(bullet.x, bullet.y));
          points++;
        }
      });
    });
  }

  void _collisionWithAsteroids() {
    if (_tickLives <= 0) {
      _listAsteroidBig.forEach((aBig) {
        if (_player.x < aBig.x + 15 &&
            _player.x > aBig.x - 15 &&
            _player.y < aBig.y + 15 &&
            _player.y > aBig.y - 15) {
          lives--;
          aBig.visible = false;
          _listExplosion.add(Explosion(aBig.x, aBig.y));
          _tickLives = 20;
        }
      });
      _listAsteroidWhite.forEach((aWhite) {
        if (_player.x < aWhite.x + 15 &&
            _player.x > aWhite.x - 15 &&
            _player.y < aWhite.y + 15 &&
            _player.y > aWhite.y - 15) {
          lives--;
          aWhite.visible = false;
          _listExplosion.add(Explosion(aWhite.x, aWhite.y));
          _tickLives = 20;
        }
      });
      if (lives <= 0) {
        _player.visible = false;
        if (lives != -1) {
          _listExplosion.add(Explosion(_player.x, _player.y));
          lives = -1;
          //вызывать новую сцену с game over
        }
      }
    }
  }
}
