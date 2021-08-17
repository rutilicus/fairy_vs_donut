import 'dart:math';
import 'package:fairy_vs_donut/scene_title.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:flutter/material.dart';

import 'global_data.dart';

// ignore: must_be_immutable
class SceneOver extends SceneWidget {
  SceneOver({required GlobalData globalData, required double scale}) {
    this.globalData = globalData;
    this.scale = scale;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>.empty(growable: true);
    children.addAll(
        [
          Image.asset("assets/base.png",
            scale: 1.0 / this.scale, filterQuality: FilterQuality.none,),
          Positioned(
              left: 92 * this.scale,
              width: 176 * this.scale,
              top: 64 * this.scale,
              height: 192 * this.scale,
              child: Image.asset("assets/over.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
        ]);
    children.addAll(
      drawPower(256, 180, this.globalData.fairyPower, true)
    );
    return Stack(
      children: children,
    );
  }

  @override
  SceneWidget run(double scale, List<Point<num>> clicks) {
    if (clicks.isNotEmpty) {
      return SceneTitle(scale: scale, globalData: this.globalData,);
    }
    if (this.scale != scale) {
      return SceneOver(globalData: this.globalData, scale: scale);
    }
    return this;
  }
}
