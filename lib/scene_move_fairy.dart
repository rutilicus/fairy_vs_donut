import 'dart:math';

import 'package:fairy_vs_donut/commons.dart';
import 'package:fairy_vs_donut/scene_over.dart';
import 'package:fairy_vs_donut/scene_trans_background.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:fairy_vs_donut/global_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SceneMoveFairy extends SceneWidget {
  int target = 0;
  int frameCount = 0;
  static const int maxFrame = Commons.fps ~/ 2;

  SceneMoveFairy({
    required GlobalData globalData,
    required double scale,
    required this.target,
    this.frameCount = 0}) {
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
          // Fairy
          Positioned(
              left: (58 + 180 * frameCount / maxFrame) * this.scale,
              width: 64 * this.scale,
              top: (206 + 135 * globalData.fairyLocation +
                  135 * (target - globalData.fairyLocation) *
                      frameCount / maxFrame) * this.scale,
              height: 64 * this.scale,
              child: Image.asset("assets/fairy.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
          // Donut
          Positioned(
              left: 238 * this.scale,
              width: 64 * this.scale,
              top: 206 * this.scale,
              height: 64 * this.scale,
              child: Image.asset("assets/donut.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
          Positioned(
              left: 238 * this.scale,
              width: 64 * this.scale,
              top: 341 * this.scale,
              height: 64 * this.scale,
              child: Image.asset("assets/donut.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
          Positioned(
              left: 238 * this.scale,
              width: 64 * this.scale,
              top: 476 * this.scale,
              height: 64 * this.scale,
              child: Image.asset("assets/donut.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
        ]
    );

    return Stack(
      children: children,
    );
  }

  @override
  SceneWidget run(double scale, List<Point<num>> clicks) {
    if (frameCount >= maxFrame) {
      if (this.globalData.enemyPower[target] > this.globalData.fairyPower) {
        return SceneOver(globalData: this.globalData, scale: scale,);
      } else {
        this.globalData.fairyLocation = target;
        this.globalData.fairyPower += this.globalData.enemyPower[target];
        if (this.globalData.fairyPower >= 1072) {
          return SceneOver(globalData: this.globalData, scale: scale,);
        }
        return SceneTransBackground(globalData: this.globalData, scale: scale);
      }
    }

    return SceneMoveFairy(
      globalData: this.globalData,
      scale: scale,
      target: target,
      frameCount: this.frameCount + 1,);
  }
}
