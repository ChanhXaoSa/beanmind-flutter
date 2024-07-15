import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailScreen extends GetView<CourseDetailController> {
  const CourseDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/course_detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Detail'),
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: SizedBox(
          width: 1440,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: 1440,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(118, 8, 122, 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 6.8, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF3DCBB1),
                                      borderRadius: BorderRadius.circular(43),
                                    ),
                                    child: SizedBox(
                                      width: 43,
                                      height: 43,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            4.7, 4.7, 4.7, 4.7),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF3DCBB1),
                                                borderRadius:
                                                    BorderRadius.circular(16.8),
                                              ),
                                              child: Container(
                                                width: 33.6,
                                                height: 33.6,
                                              ),
                                            ),
                                            Positioned(
                                              left: 0.7,
                                              bottom: -17.4,
                                              child: SizedBox(
                                                height: 51,
                                                child: Text(
                                                  'm',
                                                  style: GoogleFonts.getFont(
                                                    'Roboto Condensed',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 38.7,
                                                    height: 1.3,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 9.8, 0, 10.2),
                                  child: Text(
                                    'MyCourse.io',
                                    style: GoogleFonts.getFont(
                                      'Roboto Condensed',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17.8,
                                      height: 1.3,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 2),
                              child: SizedBox(
                                width: 808,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 29, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xE5F9F9F9),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: SizedBox(
                                          width: 400,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 8, 15, 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 10.5, 0),
                                                  child: SizedBox(
                                                    width: 128,
                                                    child: Text(
                                                      'Search for course',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Roboto Condensed',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        height: 1.3,
                                                        color:
                                                            Color(0x991B1B1B),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 3, 0, 3),
                                                  width: 21,
                                                  height: 21,
                                                  child: SizedBox(
                                                    width: 14.9,
                                                    height: 14.9,
                                                    child: SvgPicture.network(
                                                      'assets/vectors/iconactionsearch_24_px_52_x2.svg',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: Text(
                                        'Become Instructor',
                                        style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          height: 1.3,
                                          color: Color(0xFF1B1B1B),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 8, 19.5, 9),
                                      width: 24,
                                      height: 24,
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.network(
                                          'assets/vectors/iconactionshopping_cart_24_px_44_x2.svg',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 2, 19.5, 3),
                                      padding:
                                          EdgeInsets.fromLTRB(15, 7, 19.3, 7),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xE51B1B1B)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: GoogleFonts.getFont(
                                          'Roboto Condensed',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          height: 1.3,
                                          color: Color(0xE51B1B1B),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 2, 0, 3),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF3DCBB1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: SizedBox(
                                          width: 99,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                17.3, 8, 0, 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 1.3, 9.3, 1.3),
                                                  width: 16,
                                                  height: 16,
                                                  child: SizedBox(
                                                    width: 13.3,
                                                    height: 13.3,
                                                    child: SvgPicture.network(
                                                      'assets/vectors/iconimagetimelapse_24_px_33_x2.svg',
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Sign Up',
                                                  style: GoogleFonts.getFont(
                                                    'Roboto Condensed',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    height: 1.3,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(120, 0, 120, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 1, 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'assets/images/placeholder_119.png',
                                    ),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 372,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(0, -1),
                                            end: Alignment(0, 1),
                                            colors: <Color>[
                                              Color(0x001B1B1B),
                                              Color(0xCC1B1B1B)
                                            ],
                                            stops: <double>[0, 1],
                                          ),
                                        ),
                                        child: Container(
                                          width: 793,
                                          height: 76,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 793,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 16, 8),
                                            child: SizedBox(
                                              width: 761,
                                              height: 14,
                                              child: SvgPicture.network(
                                                'assets/vectors/seekbar_x2.svg',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                22.9, 0, 21, 16),
                                            child: SizedBox(
                                              width: 749.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                5.8,
                                                                19,
                                                                5.8),
                                                        width: 24,
                                                        height: 24,
                                                        child: SizedBox(
                                                          width: 10.1,
                                                          height: 12.4,
                                                          child: SvgPicture
                                                              .network(
                                                            'assets/vectors/iconavplay_arrow_24_px_21_x2.svg',
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                2.4,
                                                                16.1,
                                                                2.4),
                                                        width: 24,
                                                        height: 24,
                                                        child: SizedBox(
                                                          width: 15.9,
                                                          height: 19.3,
                                                          child: SvgPicture
                                                              .network(
                                                            'assets/vectors/iconavreplay_1024_px_5_x2.svg',
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                2.4,
                                                                15,
                                                                2.4),
                                                        width: 24,
                                                        height: 24,
                                                        child: SizedBox(
                                                          width: 15.9,
                                                          height: 19.3,
                                                          child: SvgPicture
                                                              .network(
                                                            'assets/vectors/iconavforward_1024_px_x2.svg',
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                3.5,
                                                                11,
                                                                3.5),
                                                        width: 24,
                                                        height: 24,
                                                        child: SizedBox(
                                                          width: 18,
                                                          height: 16.9,
                                                          child: SvgPicture
                                                              .network(
                                                            'assets/vectors/iconavvolume_up_24_px_10_x2.svg',
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '12:00 / 59:00',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto Condensed',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color:
                                                              Color(0x99F9F9F9),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 2, 0, 2),
                                                    child: SizedBox(
                                                      width: 120,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 1,
                                                                    14, 1),
                                                            width: 24,
                                                            height: 24,
                                                            child: SizedBox(
                                                              width: 18,
                                                              height: 18,
                                                              child: SvgPicture
                                                                  .network(
                                                                'assets/vectors/iconavhd_24_px_1_x2.svg',
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 2,
                                                                    13.3, 2),
                                                            width: 24,
                                                            height: 24,
                                                            child: SizedBox(
                                                              width: 18,
                                                              height: 16,
                                                              child: SvgPicture
                                                                  .network(
                                                                'assets/vectors/iconavclosed_caption_24_px_5_x2.svg',
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    15.3, 0),
                                                            width: 24,
                                                            height: 24,
                                                            child: SizedBox(
                                                              width: 19.5,
                                                              height: 20,
                                                              child: SvgPicture
                                                                  .network(
                                                                'assets/vectors/iconactionsettings_24_px_19_x2.svg',
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 3, 0, 3),
                                                            width: 24,
                                                            height: 24,
                                                            child: SizedBox(
                                                              width: 14,
                                                              height: 14,
                                                              child: SvgPicture
                                                                  .network(
                                                                'assets/vectors/iconnavigationfullscreen_24_px_3_x2.svg',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
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
                                  padding: EdgeInsets.fromLTRB(24, 24, 24, 46),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            width: 178.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 15.5, 0),
                                                  child: SizedBox(
                                                    width: 123,
                                                    child: Text(
                                                      'US\$22.40',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Roboto Condensed',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                        height: 1.3,
                                                        color:
                                                            Color(0xFF000000),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 3, 0, 4),
                                                  child: Text(
                                                    '\$30.13',
                                                    style: GoogleFonts.getFont(
                                                      'Roboto Condensed',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      height: 1.5,
                                                      color: Color(0x991B1B1B),
                                                      decorationColor:
                                                          Color(0x991B1B1B),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0.5, 0, 0.5, 32),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFA04AE3),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  4, 4, 4, 4),
                                              child: Text(
                                                '20% OFF',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  height: 1.3,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF3DCBB1),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Container(
                                            width: 338,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 12, 5, 12),
                                            child: Text(
                                              'Buy',
                                              style: GoogleFonts.getFont(
                                                'Roboto Condensed',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                height: 1.3,
                                                color: Color(0xFFFFFFFF),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 24),
                                        width: 338,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0x991B1B1B)),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 11, 0, 11),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 3.4, 10.2, 3.4),
                                                width: 26,
                                                height: 26,
                                                child: SizedBox(
                                                  width: 21.7,
                                                  height: 19.1,
                                                  child: SvgPicture.network(
                                                    'assets/vectors/iconactionfavorite_border_24_px_9_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Wishlist',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  height: 1.3,
                                                  color: Color(0x991B1B1B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(3, 0, 3, 14),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 3, 19, 3),
                                                width: 24,
                                                height: 24,
                                                child: SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child: SvgPicture.network(
                                                    'assets/vectors/iconcommunicationlist_alt_24_px_7_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '22 Section',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Color(0xE51B1B1B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(1, 0, 1, 15),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 3.5, 17, 3.5),
                                                width: 24,
                                                height: 24,
                                                child: SizedBox(
                                                  width: 22,
                                                  height: 17,
                                                  child: SvgPicture.network(
                                                    'assets/vectors/iconactionchrome_reader_mode_24_px_6_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '152 Lectures',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Color(0xE51B1B1B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(1, 0, 1, 13),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 1.1, 17, 3.1),
                                                width: 24,
                                                height: 24,
                                                child: SizedBox(
                                                  width: 22,
                                                  height: 19.8,
                                                  child: SvgPicture.network(
                                                    'assets/vectors/iconnotificationlive_tv_24_px_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '21h 33m total lenghts',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Color(0xE51B1B1B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 3.5, 19, 3.5),
                                                width: 24,
                                                height: 24,
                                                child: SizedBox(
                                                  width: 18,
                                                  height: 16.9,
                                                  child: SvgPicture.network(
                                                    'assets/vectors/iconavvolume_up_24_px_18_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'English',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Color(0xE51B1B1B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 19, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 24),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'VUE JS SCRATCH COURSE',
                                              style: GoogleFonts.getFont(
                                                'Roboto Condensed',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                                height: 1.3,
                                                color: Color(0xFF000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, 3.2, 16),
                                          child: SizedBox(
                                            width: 794,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 8, 0),
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              'assets/images/general_image_square_3.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 3, 0, 5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 1),
                                                            child: Text(
                                                              'Kitani Studio',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFF3DCBB1),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    7.1, 0),
                                                            child: Text(
                                                              'Design Studio',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10,
                                                                height: 1.5,
                                                                color: Color(
                                                                    0x991B1B1B),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 10),
                                                  child: SizedBox(
                                                    width: 126.8,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      0, 6, 0),
                                                              width: 24,
                                                              height: 24,
                                                              child: SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child: SvgPicture
                                                                    .network(
                                                                  'assets/vectors/iconactionsupervised_user_circle_24_px_10_x2.svg',
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      1, 0, 1),
                                                              child: Text(
                                                                '2.3k',
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Roboto Condensed',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  height: 1.3,
                                                                  color: Color(
                                                                      0x991B1B1B),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      0, 6, 0),
                                                              width: 24,
                                                              height: 24,
                                                              child: SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child: SvgPicture
                                                                    .network(
                                                                  'assets/vectors/iconmapsrate_review_24_px_10_x2.svg',
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      1, 0, 1),
                                                              child: Text(
                                                                '1.4k',
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Roboto Condensed',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  height: 1.3,
                                                                  color: Color(
                                                                      0x991B1B1B),
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
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 16),
                                          child: Opacity(
                                            opacity: 0.04,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF1B1B1B),
                                              ),
                                              child: Container(
                                                width: 794,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, 14.6, 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 16),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'About Course',
                                                    style: GoogleFonts.getFont(
                                                      'Roboto Condensed',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      height: 1.3,
                                                      color: Color(0xFF000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Vue (pronounced /vjuː/, like view) is a progressive framework for building user interfaces. Unlike other monolithic frameworks, Vue is designed from the ground up to be incrementally adoptable. The core library is focused on the view layer only, and is easy to pick up and integrate with other libraries or existing projects. On the other hand, Vue is also perfectly capable of powering sophisticated Single-Page Applications when used in combination with modern tooling and supporting libraries.',
                                                style: GoogleFonts.getFont(
                                                  'Roboto Condensed',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Color(0x991B1B1B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 16),
                                          child: Opacity(
                                            opacity: 0.04,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF1B1B1B),
                                              ),
                                              child: Container(
                                                width: 794,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 9.3, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 16),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Review',
                                                    style: GoogleFonts.getFont(
                                                      'Roboto Condensed',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      height: 1.3,
                                                      color: Color(0xFF000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 16),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 16, 25),
                                                        width: 33,
                                                        height: 33,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.5),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                'assets/images/general_image_square_14.png',
                                                              ),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            width: 33,
                                                            height: 33,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 2),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                'Leonardo  Da Vinci',
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Roboto Condensed',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 16,
                                                                  height: 1.3,
                                                                  color: Color(
                                                                      0xFF3DCBB1),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 2),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                'Today',
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Roboto Condensed',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 10,
                                                                  height: 1.5,
                                                                  color: Color(
                                                                      0x1A1B1B1B),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              'Loved the course. Ive learned some very subtle tecniques, expecially on leaves.',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0x991B1B1B),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 11, 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 16, 43),
                                                      width: 33,
                                                      height: 33,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.5),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              'assets/images/general_image_square_5.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 33,
                                                          height: 33,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Titania  S',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFF3DCBB1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Today',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10,
                                                                height: 1.5,
                                                                color: Color(
                                                                    0x1A1B1B1B),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'I loved the course, it had been a long time since I had experimented with watercolors and now I will do it more often thanks to Kitani Studio',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Roboto Condensed',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              height: 1.3,
                                                              color: Color(
                                                                  0x991B1B1B),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 16, 43),
                                                      width: 33,
                                                      height: 33,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.5),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              'assets/images/general_image_square_13.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 33,
                                                          height: 33,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Zhirkov',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFF3DCBB1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Today',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10,
                                                                height: 1.5,
                                                                color: Color(
                                                                    0x1A1B1B1B),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Yes. I just emphasize that the use of Photoshop, for non-users, becomes difficult to follow. What requires a course to master it. Safe and very didactic teacher.',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Roboto Condensed',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              height: 1.3,
                                                              color: Color(
                                                                  0x991B1B1B),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 2.2, 24),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 16, 79),
                                                      width: 33,
                                                      height: 33,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.5),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              'assets/images/general_image_square_20.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          width: 33,
                                                          height: 33,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Miphoska',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFF3DCBB1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 2),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Today',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 10,
                                                                height: 1.5,
                                                                color: Color(
                                                                    0x1A1B1B1B),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            '',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Roboto Condensed',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              height: 1.3,
                                                              color: Color(
                                                                  0x991B1B1B),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    6.3, 0, 0, 0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 7, 15, 7),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xE51B1B1B)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Text(
                                                      'Load more review',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Roboto Condensed',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        height: 1.3,
                                                        color:
                                                            Color(0xE51B1B1B),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 149),
                                    child: SizedBox(
                                      width: 387,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 1, 0, 0),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      'assets/images/image_3.png',
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 387,
                                                  height: 626,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                gradient: LinearGradient(
                                                  begin: Alignment(0, -1),
                                                  end: Alignment(0, 1),
                                                  colors: <Color>[
                                                    Color(0x00000000),
                                                    Color(0xE0000000)
                                                  ],
                                                  stops: <double>[0, 1],
                                                ),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 403, 0, 40),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 4),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF3DCBB1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
                                                          ),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(4, 4,
                                                                    10.9, 4),
                                                            child: Text(
                                                              'WEBINAR',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Roboto Condensed',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                height: 1.3,
                                                                color: Color(
                                                                    0xFFFFFFFF),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 4),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'Ana Kursova',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Roboto Condensed',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20,
                                                            height: 1.5,
                                                            color: Color(
                                                                0xE5F9F9F9),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Masterclass in Design Thinking, Innovation & Creativity',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto Condensed',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 32,
                                                          height: 1.3,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF2273D1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 1200,
                                padding: EdgeInsets.fromLTRB(60, 16, 60, 51),
                                child: Container(
                                  width: 1200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            769.2, 0, 0, 13.8),
                                        width: 384,
                                        height: 184,
                                        child: SizedBox(
                                          width: 21.2,
                                          height: 21.2,
                                          child: SvgPicture.network(
                                            'assets/vectors/shape_13_x2.svg',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1080,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 4),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      'Join and get amazing discount',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Roboto Condensed',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 32,
                                                        height: 1.3,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'With our responsive themes and mobile and desktop apps',
                                                  style: GoogleFonts.getFont(
                                                    'Roboto Condensed',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 24,
                                                    height: 1.5,
                                                    color: Color(0x99FFFFFF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 21, 0, 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 16, 0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x4DF9F9F9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: SizedBox(
                                                        width: 243,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(12, 10,
                                                                  15, 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        10.5,
                                                                        0),
                                                                child: SizedBox(
                                                                  width: 101,
                                                                  child: Text(
                                                                    'Email Address',
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Roboto Condensed',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          16,
                                                                      height:
                                                                          1.3,
                                                                      color: Color(
                                                                          0x99F9F9F9),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        3,
                                                                        0,
                                                                        3),
                                                                width: 21,
                                                                height: 21,
                                                                child: SizedBox(
                                                                  width: 14.9,
                                                                  height: 14.9,
                                                                  child: SvgPicture
                                                                      .network(
                                                                    'assets/vectors/iconactionsearch_24_px_26_x2.svg',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF3DCBB1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Container(
                                                      width: 110,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              18, 10, 18, 10),
                                                      child: Text(
                                                        'Subscribe',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Roboto Condensed',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                          height: 1.3,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 412,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1B1B1B),
                        ),
                        child: Container(
                          width: 1440,
                          height: 302,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1440,
                      height: 302,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(105, 0, 105, 22),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 764.6, 431),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 16.9, 0),
                                    child: Text(
                                      'Browse',
                                      style: GoogleFonts.getFont(
                                        'Roboto Condensed',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 1.3,
                                        color: Color(0xFF1B1B1B),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 7.6, 0, 7.6),
                                    width: 21,
                                    height: 21,
                                    child: SizedBox(
                                      width: 9.8,
                                      height: 5.8,
                                      child: SvgPicture.network(
                                        'assets/vectors/iconnavigationexpand_more_24_px_59_x2.svg',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Image.network(
          'https://via.placeholder.com/600x200', // Replace with actual image URL
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VUE JS SCRATCH COURSE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'US\$22.40',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Buy'),
              ),
              SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {},
                child: Text('Wishlist'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'About Course',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Here is the course description...',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3, // Replace with actual number of reviews
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/50'), // Replace with actual image URL
                ),
                title: Text('Reviewer Name'),
                subtitle: Text('Review content goes here...'),
              );
            },
          ),
        ],
      ),
    );
  }
}
