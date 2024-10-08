import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/loading_status.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_overview_screen.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class QuizAttemptScreen extends GetView<QuizController> {
  const QuizAttemptScreen({super.key});

  // static const String routeName = '/quiz_attempt/course_id=:course_id&worksheet_id=:worksheet_id&worksheet_attempt_id=:worksheet_attempt_id_input';
  static const String routeName = '/quiz_attempt/course_id=:course_id&worksheet_id=:worksheet_id&worksheet_attempt_id=:worksheet_attempt_id';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onExitOfQuiz,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          quizAppBar: true,
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(color: kOnSurfaceTextColor, width: 2),
              ),
            ),
            child: Obx(
                  () => CountdownTimer(
                time: controller.time.value,
                color: kOnSurfaceTextColor,
              ),
            ),
          ),
          showActionIcon: true,
          titleWidget: Obx(() => Text(
            'Câu hỏi thứ ${(controller.questionIndexApi.value + 1).toString().padLeft(2, '0')}',
            style: kAppBarTS,
          )),
        ),
        body: BackgroundDecoration(
          child: Obx(
                () => Column(
              children: [
                if (controller.loadingStatusApi.value == LoadingStatus.loading)
                  const Expanded(
                    child: ContentArea(child: QuizScreenPlaceHolder()),
                  ),
                if (controller.loadingStatusApi.value == LoadingStatus.completed)
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
                          id: 'answers_list',
                          builder: (controller) {
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                final crossAxisCount = UIParameters.isTablet(context) ? 2 : 1;
                                return GridView.builder(
                                  itemCount: controller.currentQuestionApi.value!.question!.questionAnswers!.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: crossAxisCount == 1 ? 5 : 4,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    final answer = controller.currentQuestionApi.value!.question!.questionAnswers![index];
                                    return AnswerCard(
                                      isSelected: answer == controller.currentQuestionApi.value!.question!.selectedAnswer,
                                      onTap: () {
                                        controller.selectAnswerApi(answer);
                                      },
                                      answer: '${answer.content}',
                                    );
                                  },
                                );
                              },
                            );
                          },
                        )
                        ],
                        ),
                      ),
                    ),
                  ),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParameters.screenPadding,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Visibility(
                              visible: controller.isFirstQuestionApi,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: MainButton(
                                    onTap: () {
                                      controller.prevQuestionApi();
                                    },
                                    child: const Icon(Icons.arrow_back_ios_new),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                    () => Visibility(
                                  visible: controller.loadingStatusApi.value == LoadingStatus.completed,
                                  child: MainButton(
                                    onTap: () {
                                      controller.islastQuestionApi
                                          ? Get.toNamed(QuizOverviewScreen.routeName)
                                          : controller.nextQuestionApi();
                                    },
                                    title: controller.islastQuestionApi ? 'Nộp bài' : 'Câu tiếp theo',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
