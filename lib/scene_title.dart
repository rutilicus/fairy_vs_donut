import 'dart:math';

import 'package:fairy_vs_donut/global_data.dart';
import 'package:fairy_vs_donut/scene_choose.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SceneTitle extends SceneWidget {
  SceneTitle({required GlobalData globalData, required double scale}) {
    this.globalData = globalData;
    this.scale = scale;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset("assets/base.png",
          scale: 1.0 / this.scale, filterQuality: FilterQuality.none,),
        Positioned(
            left: 100 * this.scale,
            width: 160 * this.scale,
            top: 128 * this.scale,
            height: 192 * this.scale,
            child: Image.asset("assets/logo.png",
              scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)
        )
      ],
    );
  }

  @override
  SceneWidget run(double scale, List<Point<num>> clicks) {
    if (clicks.isNotEmpty) {
      this.globalData.resetFairy();
      this.globalData.setEnemyPower();
      return SceneChoose(globalData: this.globalData, scale: scale);
    }
    if (this.scale != scale) {
      return SceneTitle(globalData: this.globalData, scale: scale);
    }

    return this;
  }
}
