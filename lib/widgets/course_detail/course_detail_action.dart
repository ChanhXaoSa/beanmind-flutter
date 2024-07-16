import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';

class CourseDetailAction extends GetView<CourseDetailController> {
  const CourseDetailAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 0, 15.5, 0),
                        child: SizedBox(
                          width: 123,
                          child: Text(
                            'US\$22.40',
                            style:
                            kDetailsTS.copyWith(
                              fontWeight:
                              FontWeight.w700,
                              fontSize: 24,
                              height: 1.3,
                              color:
                              const Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 3, 0, 4),
                        child: Text(
                          '\$30.13',
                          style: kDetailsTS.copyWith(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 16,
                            decoration: TextDecoration
                                .lineThrough,
                            height: 1.5,
                            color: const Color(0x991B1B1B),
                            decorationColor:
                            const Color(0x991B1B1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  0.5, 0, 0.5, 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFA04AE3),
                    borderRadius:
                    BorderRadius.circular(2),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(
                        4, 4, 4, 4),
                    child: Text(
                      '20% OFF',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.3,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin:
              const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3DCBB1),
                  borderRadius:
                  BorderRadius.circular(18),
                ),
                child: Container(
                  width: 338,
                  padding: const EdgeInsets.fromLTRB(
                      0, 12, 5, 12),
                  child: Center(
                    child: Text(
                      'Mua ngay',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.3,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   margin:
            //   const EdgeInsets.fromLTRB(0, 0, 0, 24),
            //   width: 338,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //         color: const Color(0x991B1B1B)),
            //     borderRadius:
            //     BorderRadius.circular(18),
            //   ),
            //   child: Container(
            //     padding:
            //     const EdgeInsets.fromLTRB(0, 11, 0, 11),
            //     child: Row(
            //       mainAxisAlignment:
            //       MainAxisAlignment.center,
            //       crossAxisAlignment:
            //       CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           margin: const EdgeInsets.fromLTRB(
            //               0, 3.4, 10.2, 3.4),
            //           width: 26,
            //           height: 26,
            //           child: const SizedBox(
            //             width: 21.7,
            //             height: 19.1,
            //             child: Icon(Icons.error, color: Colors.black,),
            //           ),
            //         ),
            //         Text(
            //           'Wishlist',
            //           style: kDetailsTS.copyWith(
            //             fontWeight: FontWeight.w700,
            //             fontSize: 20,
            //             height: 1.3,
            //             color: const Color(0x991B1B1B),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              margin:
              const EdgeInsets.fromLTRB(3, 0, 3, 14),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(
                          0, 3, 19, 3),
                      width: 24,
                      height: 24,
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(Icons.book, color: Colors.black,),
                      ),
                    ),
                    Text(
                      '22 Học phần',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        color: const Color(0xE51B1B1B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin:
              const EdgeInsets.fromLTRB(1, 0, 1, 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(
                          0, 3.5, 17, 3.5),
                      width: 24,
                      height: 24,
                      child: const SizedBox(
                        width: 22,
                        height: 17,
                        child: Icon(Icons.person, color: Colors.black,),
                      ),
                    ),
                    Text(
                      '15 giảng viên',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        color: const Color(0xE51B1B1B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin:
              const EdgeInsets.fromLTRB(1, 0, 1, 13),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(
                          0, 1.1, 17, 3.1),
                      width: 24,
                      height: 24,
                      child: const SizedBox(
                        width: 22,
                        height: 19.8,
                        child: Icon(Icons.watch_later, color: Colors.black,),
                      ),
                    ),
                    Text(
                      '21 giờ 33 phút thời gian học',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        color: const Color(0xE51B1B1B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(
                          0, 3.5, 19, 3.5),
                      width: 24,
                      height: 24,
                      child: const SizedBox(
                        width: 18,
                        height: 16.9,
                        child: Icon(Icons.category, color: Colors.black,),
                      ),
                    ),
                    Text(
                      'Toán',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        color: const Color(0xE51B1B1B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}