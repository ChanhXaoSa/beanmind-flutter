import 'package:beanmind_flutter/screens/layout/challenge_page.dart';
import 'package:beanmind_flutter/game/game_list.dart';
import 'package:flutter/material.dart';

class BeanMindLayout extends StatefulWidget {
  const BeanMindLayout({super.key});

  @override
  _BeanMindLayoutState createState() => _BeanMindLayoutState();
}

class _BeanMindLayoutState extends State<BeanMindLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3E413C),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              'BeanMind',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {}),
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
                backgroundImage: AssetImage(
                    'assets/images/physics.png'), // Profile picture
              ),
              decoration: BoxDecoration(
                color: Color(0xFF605BD9),
              ),
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('Challenge'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Training'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text('Class'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('Fun'),
              onTap: () {
                // Update the state of the app
                // ...
                // go to GameList()
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameList()),
                );
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
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/images/physics.png'), // Profile picture
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'User',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(
                    Icons.flag,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Challenge',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.school,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Training',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.class_,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Class',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.gamepad,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Fun',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // go to GameList()
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameList()),
                    );
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.supervised_user_circle, color: Colors.white),
                  title: Text(
                    'Friends',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
              ],
            ),
          ),
          // Expanded(child: ChallengePage()),
        ],
      ),
    );
  }
}
