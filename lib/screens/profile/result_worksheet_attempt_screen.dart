// import 'package:beanmind_flutter/controllers/result/result_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ResultWorksheetAttemptScreenScreen extends GetView<ResultController> {
//   const ResultWorksheetAttemptScreenScreen({Key? key}) : super(key: key);
//
//   static const String routeName = '/result_worksheet_attempt_screen?worksheet_attempt_id=:worksheet_attempt_id';
//
//   @override
//   Widget build(BuildContext context) {
//     final Color textColor = Theme.of(context).primaryColor;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kết quả bài làm'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Chúc mừng!',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Bạn đã đạt được ${controller.points} điểm',
//               style: TextStyle(fontSize: 18, color: textColor),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Nhấn vào từng câu hỏi để xem đáp án đúng',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: textColor),
//             ),
//             const SizedBox(height: 32),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: controller.worksheetAttempt.questions.length,
//                 itemBuilder: (context, index) {
//                   final question = controller.worksheetAttempt.questions[index];
//                   return ListTile(
//                     title: Text('Câu ${index + 1}: ${question.content}'),
//                     subtitle: Text('Đáp án: ${question.correctAnswer}'),
//                     trailing: Icon(
//                       question.isCorrect ? Icons.check_circle : Icons.cancel,
//                       color: question.isCorrect ? Colors.green : Colors.red,
//                     ),
//                     onTap: () {
//                       // Thêm hành động nếu cần, như điều hướng sang màn hình chi tiết câu hỏi
//                     },
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: Text('Quay lại'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
