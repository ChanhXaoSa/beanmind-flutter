import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';

class CourseDetailInformation extends GetView<CourseDetailController> {
  const CourseDetailInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'VUE JS SCRATCH COURSE',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.3,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'images/background/background.png',
                                    ),
                                  ),
                                ),
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 3, 0, 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 1),
                                    child: Text(
                                      'Kitani Studio',
                                      style: kDetailsTS.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        height: 1.3,
                                        color: const Color(0xFF3DCBB1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 7.1, 0),
                                    child: Text(
                                      'Design Studio',
                                      style: kDetailsTS.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        height: 1.5,
                                        color: const Color(0x991B1B1B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: SizedBox(
                            width: 126.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      width: 24,
                                      height: 24,
                                      child: const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Icon(
                                          Icons.account_circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                      child: Text(
                                        '2.3k',
                                        style: kDetailsTS.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 1.3,
                                          color: const Color(0x991B1B1B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      width: 24,
                                      height: 24,
                                      child: const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                      child: Text(
                                        '1.4k',
                                        style: kDetailsTS.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 1.3,
                                          color: const Color(0x991B1B1B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Opacity(
                    opacity: 0.04,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B1B1B),
                      ),
                      child: const SizedBox(
                        width: 794,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'About Course',
                            style: kDetailsTS.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              height: 1.3,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          'Vue (pronounced /vjuː/, like view) is a progressive framework for building user interfaces. Unlike other monolithic frameworks, Vue is designed from the ground up to be incrementally adoptable. The core library is focused on the view layer only, and is easy to pick up and integrate with other libraries or existing projects. On the other hand, Vue is also perfectly capable of powering sophisticated Single-Page Applications when used in combination with modern tooling and supporting libraries.',
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5,
                            color: const Color(0x991B1B1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Opacity(
                    opacity: 0.04,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B1B1B),
                      ),
                      child: const SizedBox(
                        width: 794,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}