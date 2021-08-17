import 'dart:math';
import 'package:fairy_vs_donut/commons.dart';
import 'package:fairy_vs_donut/global_data.dart';
import 'package:fairy_vs_donut/scene_move_fairy.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SceneChoose extends SceneWidget {
  int frameCount = 0;
  static const int maxFrame = Commons.fps;

  SceneChoose({
    required GlobalData globalData,
    required double scale,
    this.frameCount = 0}) {
    this.globalData = globalData;
    this.scale = scale;
  }

  @override
  SceneWidget run(double scale, List<Point> clicks) {
    if (clicks.isNotEmpty) {
      Point p = clicks.first;
      if (225 < p.x && p.x < 315) {
        if (135 < p.y && p.y < 270) {
          return SceneMoveFairy(
              globalData: this.globalData,
              scale: scale,
              target: 0);
        }
        if (270 < p.y && p.y < 405) {
          return SceneMoveFairy(
              globalData: this.globalData,
              scale: scale,
              target: 1);
        }
        if (405 < p.y && p.y < 540) {
          return SceneMoveFairy(
              globalData: this.globalData,
              scale: scale,
              target: 2);
        }
      }
    }
    if (frameCount >= maxFrame) {
      var rand = Random();
      return SceneMoveFairy(
          globalData: this.globalData,
          scale: scale,
          target: rand.nextInt(3));
    }

    // このシーンは上部バースクロールの都合上毎回新しいインスタンスを返す
    return SceneChoose(
      globalData: this.globalData, scale: scale, frameCount: frameCount + 1,);
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
              left: 58 * this.scale,
              width: 64 * this.scale,
              top: (206 + 135 * globalData.fairyLocation) * this.scale,
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
          Positioned(
              left: 0,
              width: max((360 - 360 * frameCount / maxFrame) * this.scale, 0),
              top: 0,
              height: 8 * this.scale,
              child: Container(
                color: Colors.yellow,
                width: max((360 - 360 * frameCount / maxFrame) * this.scale, 0),
                height: 8 * this.scale,
              ))
        ]
    );
    children.addAll(
      drawPower(206 + 135 * globalData.fairyLocation - 16, 90, globalData.fairyPower, true)
    );
    children.addAll(
        drawPower(174, 270, globalData.enemyPower[0], false)
    );
    children.addAll(
        drawPower(309, 270, globalData.enemyPower[1], false)
    );
    children.addAll(
        drawPower(444, 270, globalData.enemyPower[2], false)
    );

    return Stack(
      children: children,
    );
  }
}
