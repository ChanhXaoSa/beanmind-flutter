import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/screens/quiz/result_screen.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class AnswersCheckScreen extends GetView<QuizController> {
  const AnswersCheckScreen({Key? key}) : super(key: key);

  static const String routeName = '/answercheck';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        quizAppBar: true,
        titleWidget: Obx(() => Text(
            'Câu hỏi thứ ${(controller.questionIndexApi.value + 1).toString().padLeft(2, '0')}', style: kAppBarTS,)),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(Resultcreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestionApi.value!.question!.content!,
                          style: kQuizeTS,
                        ),
                        GetBuilder<QuizController>(
                            id: 'answers_review_list',
                            builder: (context) {
                              return ListView.separated(
                                itemCount: controller
                                    .currentQuestionApi.value!.question!.questionAnswers!.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25),
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller
                                      .currentQuestionApi.value!.question!.questionAnswers![index];
                                  final selectedAnswer = controller
                                      .currentQuestionApi.value!.question!.selectedAnswer;
                                  final correctAnswer = controller
                                      .currentQuestionApi.value!.question!.questionAnswers!.where((element) => element.isCorrect == true,).first;

                                  final String answerText =
                                      '${answer.content}';

                                  if (answer == correctAnswer && selectedAnswer == answer) {
                                    return CorrectAnswerCard(
                                        answer: answerText);
                                  } else if (selectedAnswer == null) {
                                    return NotAnswerCard(answer: answerText);
                                  } else if (correctAnswer != selectedAnswer && answer == selectedAnswer) {
                                    return WrongAnswerCard(answer: answerText);
                                  } else if (correctAnswer == answer) {
                                    return CorrectAnswerCard(answer: answerText);
                                  }

                                  return AnswerCard(
                                    isSelected: false,
                                    onTap: () {},
                                    answer: answerText,
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.screenPadding,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: MainButton(
                          onTap: () {
                            controller.prevQuestionApi();
                          },
                          child: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            controller.nextQuestionApi();
                          },
                          title: 'Câu tiếp theo',
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
