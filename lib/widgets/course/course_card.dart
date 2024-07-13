import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/controllers/quiz_paper/quiz_papers_controller.dart';

class CourseCard extends GetView<QuizPaperController> {
  const CourseCard({super.key});

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
        },
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child:                               Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: SizedBox(
                    width: 285,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10.5, 8, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8.5, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3DCBB1),
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(4, 4, 8.1, 4),
                                      child:
                                      Text(
                                        'Best Seller',
                                        style: kDetailsTS.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 8,
                                          height: 1.3,
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA04AE3),
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(4, 4, 8.5, 4),
                                    child:
                                    Text(
                                      '20% OFF',
                                      style: kDetailsTS.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8,
                                        height: 1.3,
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 126, 0, 0),
                            width: 12,
                            height: 12,
                            child:
                            const SizedBox(
                              width: 12,
                              height: 12,
                              // child: SvgPicture.network(
                              //   'assets/vectors/iconsocialperson_outline_24_px_344_x2.svg',
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'VUE JS SCRATCH COURSE',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.3,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(3, 0, 3, 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 3, 7, 3),
                          width: 12,
                          height: 12,
                          child:
                          const SizedBox(
                            width: 12,
                            height: 12,
                            // child: SvgPicture.network(
                            //   'assets/vectors/iconsocialperson_outline_24_px_430_x2.svg',
                            // ),
                          ),
                        ),
                        Text(
                          'Kitani Studio',
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.3,
                            color: const Color(0xFF3DCBB1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 9.4, 22),
                  child: Text(
                    'More than 8yr Experience as Illustrator. Learn how to becoming professional Illustrator Now...',
                    style: kDetailsTS.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.3,
                      color: const Color(0xE51B1B1B),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(2.3, 0, 2.3, 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 3.5, 5.3, 3.5),
                          child: SizedBox(
                            width: 83.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 6.6, 0),
                                  width: 11.4,
                                  height: 10.9,
                                  child:
                                  const SizedBox(
                                    width: 11.4,
                                    height: 10.9,
                                    // child: SvgPicture.network(
                                    //   'assets/vectors/icontogglestar_purple_50024_px_711_x2.svg',
                                    // ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 6.6, 0),
                                  width: 11.4,
                                  height: 10.9,
                                  child:
                                  const SizedBox(
                                    width: 11.4,
                                    height: 10.9,
                                    // child: SvgPicture.network(
                                    //   'assets/vectors/icontogglestar_purple_50024_px_780_x2.svg',
                                    // ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 6.6, 0),
                                  width: 11.4,
                                  height: 10.9,
                                  child:
                                  const SizedBox(
                                    width: 11.4,
                                    height: 10.9,
                                    // child: SvgPicture.network(
                                    //   'assets/vectors/icontogglestar_purple_50024_px_784_x2.svg',
                                    // ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 6.6, 0),
                                  width: 11.4,
                                  height: 10.9,
                                  child:
                                  const SizedBox(
                                    width: 11.4,
                                    height: 10.9,
                                    // child: SvgPicture.network(
                                    //   'assets/vectors/icontogglestar_purple_50024_px_476_x2.svg',
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 11.4,
                                  height: 10.9,
                                  child:
                                  SizedBox(
                                    width: 11.4,
                                    height: 10.9,
                                    // child: SvgPicture.network(
                                    //   'assets/vectors/icontogglestar_half_24_px_115_x2.svg',
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '(1.2K)',
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.3,
                            color: const Color(0x991B1B1B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 6.7, 0),
                        child: Text(
                          '\$24.92',
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            height: 1.3,
                            color: const Color(0xE51B1B1B),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                        child: Text(
                          '\$32.90',
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            height: 1.5,
                            color: const Color(0x991B1B1B),
                            decorationColor: const Color(0x991B1B1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
