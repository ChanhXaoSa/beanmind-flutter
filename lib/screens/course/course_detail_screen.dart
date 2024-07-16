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
          width: MediaQuery.of(context).size.width,
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
                                    image: AssetImage(
                                      'images/background/background.png',
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
                                      child: Container(
                                      decoration : BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'images/background/background.png',
                                          ),
                                        ),
                                      ),
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
                                            width: 200,
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
                                                                child: Icon(Icons.heart_broken, color: Colors.black,),
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
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.8,
                                                child: Text(
                                                  'Vue (pronounced /vjuː/, like view) is a progressive framework for building user interfaces. Unlike other monolithic frameworks, Vue is designed from the ground up to be incrementally adoptable. The core library is focused on the view layer only, and is easy to pick up and integrate with other libraries or existing projects. On the other hand, Vue is also perfectly capable of powering sophisticated Single-Page Applications when used in combination with modern tooling and supporting libraries.',
                                                  style: GoogleFonts.getFont(
                                                    'Roboto Condensed',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    height: 1.5,
                                                    color: Color(0x991B1B1B),
                                                  ),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
