import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  //final Widget mobileBody;
  //final Widget tabletBody;
  final Widget desktopBody;

  ResponsiveLayout({
    //required this.mobileBody,
    //required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return desktopBody;
        } else if (constraints.maxWidth < 1100) {
          return desktopBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            myDrawer,
            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // first 4 boxes in grid
                  AspectRatio(
                    aspectRatio: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // list of previous days
                  Expanded(
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: Text('Day 1'),
                          subtitle: Text('10/10/2021'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // second half of page
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var drawerTextColor = TextStyle(
  color: Colors.blue[700],
  fontWeight: FontWeight.bold,
);
var drawerIconColor = Colors.blue[700];
var myDrawer = Drawer(
  backgroundColor: Colors.white,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.network(
                      'https://i0.wp.com/thegameofnerds.com/wp-content/uploads/2022/07/TGON-GAMER-Icon.png?resize=440%2C440&ssl=1',
                      width: 100,
                      height: 100),
                  Text(
                    'Lê Tuấn kiệt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(
            Icons.dashboard,
            size: 30,
            color: drawerIconColor,
          ),
          title: Text(
            'TIẾN ĐỘ HỌC TẬP',
            style: drawerTextColor,
          ),
          onTap: () => print('tiến độ học tập'),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 30,
            color: drawerIconColor,
          ),
          title: Text(
            'THÔNG TIN CÁ NHÂN',
            style: drawerTextColor,
          ),
          onTap: () => print('tiến độ học tập'),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(
            Icons.book,
            size: 30,
            color: drawerIconColor,
          ),
          title: Text(
            ' KHOÁ HỌC ĐÃ ĐĂNG KÍ',
            style: drawerTextColor,
          ),
          onTap: () => print('tiến độ học tập'),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(
            Icons.history,
            size: 30,
            color: drawerIconColor,
          ),
          title: Text(
            'LỊCH SỬ HỌC TẬP',
            style: drawerTextColor,
          ),
          onTap: () => print('tiến độ học tập'),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(
            Icons.gamepad,
            size: 30,
            color: drawerIconColor,
          ),
          title: Text(
            'TRÒ CHƠI ĐÃ CHƠI',
            style: drawerTextColor,
          ),
          onTap: () => print('tiến độ học tập'),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(
            Icons.logout,
            size: 30,
            color: drawerIconColor,
          ),
          title: Text(
            'ĐĂNG XUẤT',
            style: drawerTextColor,
          ),
          onTap: () => print('tiến độ học tập'),
        ),
      ),
    ],
  ),
);
