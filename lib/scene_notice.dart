import 'dart:math';

import 'package:fairy_vs_donut/commons.dart';
import 'package:fairy_vs_donut/scene_title.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:fairy_vs_donut/global_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SceneNotice extends SceneWidget {
  static const int maxFrameCount = Commons.fps * 5;

  int frameCount = 0;

  SceneNotice({required GlobalData globalData, required double scale}) {
    this.globalData = globalData;
    this.scale = scale;
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/notice.png",
      scale: 1.0 / this.scale,
      filterQuality: FilterQuality.none,
    );
  }

  @override
  SceneWidget run(double scale, List<Point<num>> clicks) {
    if (clicks.isNotEmpty || frameCount >= maxFrameCount) {
      return SceneTitle(globalData: this.globalData, scale: scale,);
    }
    frameCount++;
    if (this.scale != scale) {
      return SceneNotice(globalData: globalData, scale: scale,);
    }
    return this;
  }

}
