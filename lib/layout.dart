import 'package:beanmind_flutter/hexcolor.dart';
import 'package:flutter/material.dart';

class BuildLayoutDemo extends StatefulWidget {
  const BuildLayoutDemo({super.key});

  @override
  _BuildLayoutDemoState createState() => _BuildLayoutDemoState();
}

class _BuildLayoutDemoState extends State<BuildLayoutDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3E413C),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text('KooBits', style: TextStyle(color: Colors.white),),
            Spacer(),
            IconButton(icon: Icon(Icons.notifications ,color: Colors.white), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings ,color: Colors.white), onPressed: () {}),
          ],
        ),
        actions: [
          // Add any additional actions here
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User'),
              accountEmail: Text('Level 1 / 1k'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Profile picture
              ),
              decoration: BoxDecoration(
                color: Color(0xFF605BD9),
              ),
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('KooChallenge'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('KooTraining'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text('KooClass'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('KooFun'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.12,
            color: Color(0xFF605BD9),
            child: Column(
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Profile picture
                ),
                SizedBox(height: 20,),
                Text('User', style: TextStyle(fontSize: 20, color: Colors.white),),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.flag, color: Colors.white,),
                  title: Text('Challenge', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.school, color: Colors.white,),
                  title: Text('Training', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.class_, color: Colors.white,),
                  title: Text('Class', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.gamepad, color: Colors.white,),
                  title: Text('Fun', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.supervised_user_circle, color: Colors.white),
                  title: Text('Friends', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildCard('Daily Challenge', 'Sunday Mini', 'Start', 'Every Mon - Sat', Colors.orange, Colors.white),
                        buildCard('Peer Challenge', '', '', '', Colors.deepOrange, Colors.white),
                        buildCard('Super Hero Challenge', '', '', '', Colors.blue, Colors.white),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Additional content can be added here
                  ],
                ),
              ),
            ),
          ),
        ],
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
