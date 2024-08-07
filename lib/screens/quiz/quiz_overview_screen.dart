import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class QuizOverviewScreen extends GetView<QuizController> {
  const QuizOverviewScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizeoverview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  CustomAppBar(
        quizAppBar: true,
        title: controller.completedQuizApi,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                  child: Column(
                children: [
                  Row(
                    children: [
                      CountdownTimer(
                        color: UIParameters.isDarkMode(context)
                            ? Theme.of(context).textTheme.bodySmall!.color
                            : Theme.of(context).primaryColor, time: '',
                      ),
                      Obx(
                        () => Text(
                          'Thời gian còn lại: ${controller.time}',
                          style: countDownTimerTs(context),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                      child: GridView.builder(
                          itemCount: controller.allQuestionsApi.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      UIParameters.getWidth(context) ~/ 75,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                           AnswerStatus? _answerStatus;
                            if(controller.allQuestionsApi[index].question!.selectedAnswer != null){
                              _answerStatus = AnswerStatus.answered;
                            }
                            return QuizNumberCard(
                              index: index+1, status: _answerStatus, onTap: () {
                                controller.jumpToQuestionApi(index);
                                },
                            );
                          }))
                ],
              )),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.screenPadding,
                child: MainButton(
                  onTap: () {
                    controller.completeApi();
                  },
                  title: 'Nộp bài',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
