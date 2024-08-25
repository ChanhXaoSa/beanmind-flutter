import 'package:beanmind_flutter/controllers/result/result_controller.dart';
import 'package:beanmind_flutter/controllers/result/result_extention.dart';
import 'package:beanmind_flutter/firebase/firebase_configs.dart';
import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class ResultWorksheetAttemptScreen extends GetView<ResultController> {
  const ResultWorksheetAttemptScreen({Key? key}) : super(key: key);

  static const String routeName =
      '/result-worksheet-attempt/course_id=:course_id&worksheet_id=:worksheet_id&worksheet_attempt_id=:worksheet_attempt_id';

  @override
  Widget build(BuildContext context) {
    final Color _textColor = Colors.white;

    return Scaffold(
      appBar: const CustomHomeAppBar(),
      body: Obx(() {
        if (controller.loadingStatusApi.value == LoadingStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.loadingStatusApi.value == LoadingStatus.noReult) {
          return Center(child: Text('Không có dữ liệu.'));
        }

        if (controller.loadingStatusApi.value == LoadingStatus.error) {
          return Center(child: Text('Đã xảy ra lỗi khi tải dữ liệu.'));
        }

        return BackgroundDecoration(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.arrow_back),
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    // ),
                    const SizedBox(width: 10),
                    Text(
                      'Kết quả bài kiểm tra',
                      style: kHeaderTS.copyWith(color: _textColor),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/logo_beanmind.png', height: 100),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Center(
                  child: Text(
                    'Chúc mừng',
                    style: kHeaderTS.copyWith(color: _textColor),
                  ),
                ),
              ),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Bạn đã đạt được ${controller.points.value} điểm',
                  style: TextStyle(color: _textColor),
                  textAlign: TextAlign.center,
                ),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Danh sách câu hỏi và câu trả lời:',
                  style: TextStyle(color: _textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),
              ListView.builder(
                itemCount: controller.allQuestionsApi.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, questionIndex) {
                  final question = controller.allQuestionsApi[questionIndex];

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Câu hỏi ${questionIndex + 1}: ${question.question!.content}',
                            style: kQuizeTS,
                          ),
                          const SizedBox(height: 10),
                          GetBuilder<ResultController>(
                            id: 'answers_review_list_$questionIndex',
                            builder: (_) {
                              return ListView.separated(
                                itemCount: question.question!.questionAnswers!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final answer = question.question!.questionAnswers![index];
                                  final selectedAnswer = controller.checkAnswer(question.question!.questionAnswers!);
                                  final correctAnswer = question.question!.questionAnswers!
                                      .firstWhere((element) => element.isCorrect == true);
                                  final String? selectedAnswerId = selectedAnswer?.id;
                                  final String correctAnswerId = correctAnswer.id!;
                                  final String answerText = '${answer.content}';

                                  if (answer.id == correctAnswerId && selectedAnswerId == answer.id) {
                                    return CorrectAnswerCard(answer: answerText);
                                  } else if (selectedAnswerId == null) {
                                    return NotAnswerCard(answer: answerText);
                                  } else if (correctAnswerId != selectedAnswerId &&
                                      answer.id == selectedAnswerId) {
                                    return WrongAnswerCard(answer: answerText);
                                  } else if (correctAnswerId == answer.id) {
                                    return CorrectAnswerCard(answer: answerText);
                                  }

                                  return AnswerCard(
                                    isSelected: false,
                                    onTap: () {},
                                    answer: answerText,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
