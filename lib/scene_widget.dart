import 'dart:math';
import 'package:flutter/material.dart';

import 'global_data.dart';

// ignore: must_be_immutable
abstract class SceneWidget extends StatelessWidget {
  late GlobalData globalData;
  double scale = 1.0;
  SceneWidget run(double scale, List<Point> clicks);

  List<Widget> drawPower(
      int top, int centerHorizontal, int power, bool isFairy) {
    String powerText = power.toString();

    List<Widget> ret = List<Widget>.empty(growable: true);

    for (int i = 0; i < powerText.length; i++) {
      ret.add(
        Positioned(
            left: (centerHorizontal - (powerText.length / 2 - i) * 16) * this.scale,
            width: 16 * this.scale,
            top: top * this.scale,
            height: 32 * this.scale,
            child: Image.asset("assets/num_" + (isFairy ? "fairy" : "donut") + "_" + powerText[i] + ".png",
              scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
      );
    }

    return ret;
  }
}
