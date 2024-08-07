import 'package:beanmind_flutter/widgets/dialogs/youtube_video_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/loading_status.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_overview_screen.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class QuizeScreen extends GetView<QuizController> {
  const QuizeScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizescreen';

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
              child: Obx(
                () => CountdownTimer(
                  time: controller.time.value,
                  color: kOnSurfaceTextColor,
                ),
              ),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: kOnSurfaceTextColor, width: 2)),
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
                        child: ContentArea(child: QuizScreenPlaceHolder())),
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
                                  builder: (context) {
                                    return GridView.builder(
                                      itemCount: controller.currentQuestionApi
                                          .value!.question!.questionAnswers!.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing:
                                            10, // Space between columns
                                        mainAxisSpacing:
                                            10, // Space between rows
                                        childAspectRatio:
                                            5, // Adjust the aspect ratio as needed
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestionApi
                                            .value!.question!
                                            .questionAnswers![index];
                                        return AnswerCard(
                                          isSelected: answer.id ==
                                              controller.currentQuestionApi.value!
                                                  .question!.selectedAnswer,
                                          onTap: () {
                                            controller.selectAnswerApi(
                                                answer);
                                          },
                                          answer:
                                              '${answer.content}',
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Xem video hướng dẫn',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      const videoId = 'TaBt6snSlgU';
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            YoutubeVideoDialog(
                                                videoId: videoId),
                                      );
                                    }),
                            ),
                            // child: MainButton(
                            //   onTap: () {
                            //     const videoId = 'TaBt6snSlgU';
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) => YoutubeVideoDialog(videoId: videoId),
                            //     );
                            //   },
                            //   title: 'Xem video hướng dẫn',
                            // ),
                          ),
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
                                      child:
                                          const Icon(Icons.arrow_back_ios_new),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => Visibility(
                                    visible: controller.loadingStatusApi.value ==
                                        LoadingStatus.completed,
                                    child: MainButton(
                                      onTap: () {
                                        controller.islastQuestionApi
                                            ? Get.toNamed(
                                                QuizOverviewScreen.routeName)
                                            : controller.nextQuestionApi();
                                      },
                                      title: controller.islastQuestionApi
                                          ? 'Complete'
                                          : 'Next',
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
          )),
    );
  }
}
