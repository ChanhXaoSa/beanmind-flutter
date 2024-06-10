import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCard('Daily Challenge', 'Sunday Mini', 'Start', 'Every Mon - Sat', Colors.orange, Colors.white),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildCard('Peer Challenge', '', '', '', Colors.deepOrange, Colors.white),
                            buildCard('Super Hero Challenge', '', '', '', Colors.blue, Colors.white),
                          ],
                        )
                      ],
                    ),
          ),
        ),
      ),
    );
  }
  Widget buildCard(String title, String subtitle, String buttonText, String description, Color color, Color textColor) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(buttonText),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: textColor),
          ),
        ],
      ),
    );
  }
}