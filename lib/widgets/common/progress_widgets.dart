import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
        child: Container(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                animation: true,
                animationDuration: 3000,
                radius: 100,
                lineWidth: 40,
                progressColor: Colors.deepPurple,
                circularStrokeCap: CircularStrokeCap.round,
                percent: 1,       
              )
            ],
          ),
        )
      )
    );
  }
}