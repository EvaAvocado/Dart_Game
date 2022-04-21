import 'package:flutter/cupertino.dart';

abstract class AppScene {
  Widget buildScene(BuildContext context);
  void update();
}
