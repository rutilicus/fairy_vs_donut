import 'dart:math';

import 'package:fairy_vs_donut/commons.dart';
import 'package:fairy_vs_donut/global_data.dart';
import 'package:fairy_vs_donut/scene_choose.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SceneTransBackground extends SceneWidget {
  int frameCount = 0;
  static const int maxFrame = Commons.fps;

  SceneTransBackground({
    required GlobalData globalData, required double scale,
    this.frameCount = 0}) {
    this.globalData = globalData;
    this.scale = scale;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>.empty(growable: true);
    children.addAll(
        [
          // サイズ固定用の箱
          Container(
            width: 360 * scale,
            height: 640 * scale,
          ),
          //背景
          Positioned(
              left: (-360 * frameCount / maxFrame) * scale,
              width: 360 * scale,
              top:0,
              height: 640 * scale,
              child: Image.asset("assets/base.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
          Positioned(
              left: (-360 * frameCount / maxFrame + 360) * scale,
              width: 360 * scale,
              top:0,
              height: 640 * scale,
              child: Image.asset("assets/base.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
          // Fairy
          Positioned(
              left: (58 + 180 * (maxFrame - frameCount) / maxFrame) * this.scale,
              width: 64 * this.scale,
              top: (206 + 135 * globalData.fairyLocation) * this.scale,
              height: 64 * this.scale,
              child: Image.asset("assets/fairy.png",
                scale: 1.0 / this.scale, filterQuality: FilterQuality.none,)),
        ]);

    return Stack(
      children: children,
    );
  }

  @override
  SceneWidget run(double scale, List<Point<num>> clicks) {
    if (frameCount >= maxFrame) {
      this.globalData.setEnemyPower();
      return SceneChoose(globalData: this.globalData, scale: scale);
    }

    // スクロールの都合上毎回新しいインスタンスを返す
    return SceneTransBackground(
      globalData: this.globalData, scale: scale,
      frameCount: this.frameCount + 1,
    );
  }
}
