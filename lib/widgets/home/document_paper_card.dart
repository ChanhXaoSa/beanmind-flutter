import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/controllers/quiz_paper/quiz_papers_controller.dart';
import 'package:beanmind_flutter/models/quiz_paper_model.dart';
import 'package:beanmind_flutter/screens/screens.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class DocumentPaperCard extends GetView<QuizPaperController> {
  const DocumentPaperCard({Key? key, required this.model}) : super(key: key);

  final QuizPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          controller.navigateToDocument('https://www.clickdimensions.com/links/TestPDFfile.pdf');
        },
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: UIParameters.cardBorderRadius,
                      child: ColoredBox(
                          color:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: model.imageUrl == null ||  model.imageUrl!.isEmpty ? null : Image.network(model.imageUrl!),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tài Liệu 1',
                              style: cardTitleTs(context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 15),
                              child: Text('Tài liệu học tập 1'),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: EasySeparatedRow(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(width: 15);
                                },
                                children: [
                                  // IconWithText(
                                  //     icon: Icon(Icons.help_outline_sharp,
                                  //         color: Colors.green[700]),
                                  //     text: Text(
                                  //       '${model.questionsCount} quizzes',
                                  //       style: kDetailsTS.copyWith(
                                  //           color: Colors.green[700]),
                                  //     )),
                                  IconWithText(
                                      icon: const Icon(Icons.find_in_page_outlined,
                                          color: Colors.blueGrey),
                                      text: Text(
                                        // model.timeInMinits(),
                                        '5 pages',
                                        style: kDetailsTS.copyWith(
                                            color: Colors.blueGrey),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                      behavior : HitTestBehavior.translucent,
                      onTap: () {
                        // Get.find<NotificationService>().showQuizCompletedNotification(id: 1, title: 'Sampole', body: 'Sample', imageUrl: model.imageUrl, payload: json.encode(model.toJson())  );
                        // Get.toNamed(LeaderBoardScreen.routeName, arguments:model );
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        // child: const Icon(AppIcons.trophyoutline),
                        child: const Icon(Icons.read_more),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kCardBorderrRadius),
                                bottomRight:
                                Radius.circular(kCardBorderrRadius)),
                            color: Colors.green),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}