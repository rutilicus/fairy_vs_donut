import 'dart:async';
import 'dart:math';

import 'package:fairy_vs_donut/commons.dart';
import 'package:fairy_vs_donut/global_data.dart';
import 'package:fairy_vs_donut/scene_notice.dart';
import 'package:fairy_vs_donut/scene_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fairy vs. Donut',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static GlobalData _globalData = GlobalData();
  SceneWidget _sceneWidget = SceneNotice(globalData: _globalData, scale: 1.0,);
  double scale = 1.0;
  List<Point> clicks = List.empty(growable: true);

  double getScale(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // 横がボトルネックになる場合は横サイズをベースにscale作成、そうでなければ
    // 縦サイズをベースにscale作成
    double scale = size.width / Commons.width;
    if (Commons.height * scale > size.height) {
      scale = size.height / Commons.height;
    }

    return scale;
  }

  @override
  Widget build(BuildContext context) {
    // シーン実行処理
    scale = getScale(context);
    _sceneWidget = _sceneWidget.run(scale, clicks);
    clicks.clear();

    // 次フレーム動作タイマー設定
    Timer(Duration(milliseconds: 1000 ~/ Commons.fps), () {
      setState(() {});
    });

    return Scaffold(
        body: Center(child: GestureDetector(
          child: _sceneWidget,
          onTapDown: (details) {
            clicks.add(Point(
                details.localPosition.dx / scale,
                details.localPosition.dy / scale));
          },
        ),
        )
    );
  }
}
