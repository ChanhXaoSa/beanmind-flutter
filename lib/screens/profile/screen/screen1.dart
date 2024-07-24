import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('TIẾN ĐỘ HỌC TẬP'));
  }
}

// class _DesktopScaffoldState extends State<DesktopScaffold> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // open drawer
//             myDrawer,
//             // first half of page
//             Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   // first 4 boxes in grid
//                   AspectRatio(
//                     aspectRatio: 4,
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: GridView.builder(
//                         itemCount: 4,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 4),
//                         itemBuilder: (context, index) {
//                           return Container(
//                             margin: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.grey[400],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),

//                   // list of previous days
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: 7,
//                       itemBuilder: (context, index) {
//                         return const ListTile(
//                           title: Text('Day 1'),
//                           subtitle: Text('10/10/2021'),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // second half of page
//             Expanded(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                   ),
//                   // list of stuff
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.grey[200],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }