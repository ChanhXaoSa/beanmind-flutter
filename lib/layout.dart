import 'package:flutter/material.dart';

class BuildLayoutDemo extends StatefulWidget {
  @override
  _BuildLayoutDemoState createState() => _BuildLayoutDemoState();
}

class _BuildLayoutDemoState extends State<BuildLayoutDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.network(
                //   'https://i.pinimg.com/236x/ab/3d/e2/ab3de2f5cc08f507f728f39c66e596b8.jpg',
                //   height: 50,
                // ),
                Text(
                  'BeanMind',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  color: Colors.green[600],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Learning'),
                        textColor: Colors.white,
                        onTap: () {
                        },
                      ),
                      ListTile(
                        title: Text('Minigame'),
                        textColor: Colors.white,
                        onTap: () {
                        },
                      ),
                      ListTile(
                        title: Text('Daily Quest'),
                        textColor: Colors.white,
                        onTap: () {
                        },
                      ),
                    ],
                  ),
                ),
                // Right side content
                Expanded(
                  child: Text('Hello'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
