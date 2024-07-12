import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressWidgets extends StatefulWidget {
  const ProgressWidgets({super.key});

  @override
  State<ProgressWidgets> createState() => _ProgressWidgetsState();
}

class _ProgressWidgetsState extends State<ProgressWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lotties/loading_animation_01.json", height: 300),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: new LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 100,
            animation: true,
            lineHeight: 30.0,
            animationDuration: 2500,
            percent: 1,
            center: Text(
              "Xin chờ ...",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.green,
            alignment: MainAxisAlignment.center,
          ),
        ),
      ],
    )));
  }
}
