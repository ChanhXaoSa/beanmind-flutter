import 'package:beanmind_flutter/controllers/game/game_chapter_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/widgets/game/class/audio.dart';
import 'package:beanmind_flutter/widgets/game/class/math_game/math_game_level.dart';
import 'package:beanmind_flutter/widgets/game/class/math_game/math_game_user.dart';
import 'package:beanmind_flutter/widgets/game/class/save_game_result.dart';
import 'package:beanmind_flutter/widgets/game/class/score_cal.dart';
import 'package:beanmind_flutter/widgets/game/class/timer.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class MathGameScreeen extends StatefulWidget {
  final int level;
  final String gameid;
  const MathGameScreeen({Key? key, required this.level, required this.gameid})
      : super(key: key);
  static const String routeName = '/math_game';
  @override
  State<MathGameScreeen> createState() => _MathGameScreeenState();
}

class _MathGameScreeenState extends State<MathGameScreeen> {
  final FocusNode _resultFocusNode = FocusNode();
  final Audio _audio = Audio();
  late VideoPlayerController _videoPlayerController;
  TimeRecord _timeRecord = TimeRecord();

  bool _isLoading = true;
  bool isCorrect = false;
  String background =
      'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_1.png?alt=media&token=39e27f13-3fc8-42b8-9365-0b635c9ee860';

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  @override
  void dispose() {
    _resultFocusNode.dispose();
    _videoPlayerController.dispose();
    _timeRecord.timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    restartGame(widget.level);
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((value) => setState(() {}));
    delay3Seconds();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isWideScreen = screenSize.width / screenSize.height > 16 / 9;
    FocusScope.of(context).requestFocus(_resultFocusNode);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.blue[100],
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 25,
                ),
                height: 60,
                color: Colors.deepPurple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Số điểm của bạn : ' + userPoint.toString(),
                        style: whiteTextStyle,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Hướng dẫn'),
                  content: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Fmath_game%2Fmath_game.png?alt=media&token=d2291958-0a2d-4b47-8a91-970fbe6a13bf',
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              'Xem bài toán hiển thị trên màn hình và chọn đáp án đúng',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding:
                            EdgeInsets.all(10), // Điều chỉnh kích thước nút
                      ),
                      child: Icon(
                        Icons.help,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isWideScreen
                    ? Row(
                        // desktop view
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(
                                  top: 15, left: 15, bottom: 15, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 5,
                                    color: Theme.of(context)
                                        .cardColor
                                        .withAlpha(100)),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  width: double.infinity,
                                                  key: ValueKey<String>(
                                                      background),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          background),
                                                      fit: BoxFit.fill,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.black
                                                            .withOpacity(0.5),
                                                        BlendMode.darken,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Câu số ${userProgress + 1}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          50,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  // timer 60s count down
                                                                ],
                                                              ),
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.2),
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Text(
                                                                    formattedQuestion,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          50,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children:
                                                                  List.generate(
                                                                      choice
                                                                          .length,
                                                                      (index) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    answer(
                                                                        index:
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 220,
                                                                    height: 100,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        choice
                                                                            .elementAt(index)
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              50,
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          )
                                                        ],
                                                      ),
                                                      Visibility(
                                                        visible: isAnswered,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                isCorrect
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            100,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            100,
                                                                      ),
                                                                Text(
                                                                  isCorrect
                                                                      ? "Chính xác"
                                                                      : "Sai rồi",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _isLoading,
                                    child: Center(
                                      child: ProgressWidgets(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        // mobile view
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 5,
                                    color: Theme.of(context)
                                        .cardColor
                                        .withAlpha(100)),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  width: double.infinity,
                                                  key: ValueKey<String>(
                                                      background),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          background),
                                                      fit: BoxFit.fill,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.black
                                                            .withOpacity(0.5),
                                                        BlendMode.darken,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Câu số ${userProgress + 1}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          50,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  // timer 60s count down
                                                                ],
                                                              ),
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.2),
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Text(
                                                                    formattedQuestion,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          50,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children:
                                                                  List.generate(
                                                                      choice
                                                                          .length,
                                                                      (index) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    answer(
                                                                        index:
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 220,
                                                                    height: 100,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        choice
                                                                            .elementAt(index)
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              50,
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          )
                                                        ],
                                                      ),
                                                      Visibility(
                                                        visible: isAnswered,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                isCorrect
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            100,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            100,
                                                                      ),
                                                                Text(
                                                                  isCorrect
                                                                      ? "Chính xác"
                                                                      : "Sai rồi",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _isLoading,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Focus(
                focusNode: _resultFocusNode,
                child: Container(
                  height: 0,
                  width: 0,
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: _isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: ProgressWidgets(),
            ),
          ),
        ),
      ],
    );
  }

  // show dialog error
  void _showDialogError(
    String message,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      message,
                      style: whiteTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // show dialog completed
  void _showDialogCompleted(
      String message, String lottieAsset, bool lockScreens, int userPoint) {
    showDialog(
        context: context,
        barrierDismissible: lockScreens,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      message,
                      style: whiteTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Lottie.asset(lottieAsset, height: 100),
                    SizedBox(height: 16),
                    Text(
                      'Số điểm của bạn: ' +
                          userPoint.toString() +
                          '/' +
                          totalQuestion.toString(),
                      style: whiteTextStyle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Thời gian hoàn thành trò chơi: ${_timeRecord.seconds} giây',
                      style: whiteTextStyle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Số điểm bạn đạt được: ${calculateScore(userPoint, totalQuestion, _timeRecord.seconds).toString()}',
                      style: whiteTextStyle,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: resetGame,
                          child: Row(
                            children: [
                              Text(
                                'Chơi lại ',
                                style: whiteTextStyle,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[300],
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: backtoCourseLearning,
                          child: Row(
                            children: [
                              Text(
                                'Trở về trang khoá học ',
                                style: whiteTextStyle,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[300],
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
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
            ),
          );
        });
  }

  // show dialog correct or wrong
  void _showDialog(String message, String lottieAsset, bool lockScreen,
      bool showNextQuestion, bool showVideo) {
    showDialog(
        context: context,
        barrierDismissible: lockScreen,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      message,
                      style: whiteTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Lottie.asset(lottieAsset, height: 100),
                    SizedBox(height: 16),
                    if (showVideo)
                      Center(
                        child: _videoPlayerController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              )
                            : Container(),
                      )
                    else
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    if (showVideo) SizedBox(height: 16),
                    if (showVideo)
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _videoPlayerController.value.isPlaying
                                ? _videoPlayerController.pause()
                                : _videoPlayerController.play();
                          });
                        },
                        child: Icon(_videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                      ),
                    if (showNextQuestion) SizedBox(height: 16),
                    if (showNextQuestion)
                      GestureDetector(
                        onTap: goToNextQuestion,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void resetGame() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
      userPoint = 0;
      userProgress = 0;
      _timeRecord.seconds = 0;
      _timeRecord.startTimer();
      nextQuestion(widget.level);
    });
  }

  void backtoHome() {
    final GameController controller = Get.find();
    resetGame();
    setState(() {
      controller.shouldReset.value = true;
      Get.offAllNamed(GameListScreen.routeName);
    });
  }

  void backtoCourseLearning() {
    final GameChapterController controller = Get.find();
    setState(() {
      Get.offAllNamed(CourseLearningScreen.routeName
          .replaceFirst(':id', controller.courseId));
    });
  }

  void checkResult() {
    userProgress += 1;
    setState(() {
      showResultDialog = true;
    });

    if (userProgress == totalQuestion) {
      _audio.playCompleteSound();
      String lottieAsset = _getLottieAsset(userPoint);
      _timeRecord.stopTimer();
      saveGameResults(
          widget.gameid,
          calculateScore(userPoint, totalQuestion, _timeRecord.seconds),
          _timeRecord.seconds);
      _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
          lottieAsset, false, userPoint);
      return;
    }
  }

  String _getLottieAsset(int userPoint) {
    switch (userPoint) {
      case 1:
        return 'assets/lotties/bronze_medal.json';
      case 2:
        return 'assets/lotties/silver_medal.json';
      case 3:
        return 'assets/lotties/gold_medal.json';
      default:
        return 'assets/lotties/wrong.json';
    }
  }

  void goToNextQuestion() {
    if (showResultDialog) {
      Navigator.of(context).pop();
      setState(() {
        userAnswer = '';
        nextQuestion(widget.level);
        showResultDialog = false;
      });
    }
  }

  void delay3Seconds() {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool showGuide = prefs.getBool('showGuideMathScreen') ?? true;

      setState(() {
        if (showGuide) {
          Future.delayed(Duration.zero, () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Hướng dẫn'),
                  content: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Fmath_game%2Fmath_game.png?alt=media&token=d2291958-0a2d-4b47-8a91-970fbe6a13bf',
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              'Xem bài toán hiển thị trên màn hình và chọn đáp án đúng',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        prefs.setBool('showGuideMathScreen', false);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          });
        }
        _timeRecord.startTimer();
      });
    });
  }

  void answer({index}) {
    if (!isAnswered) {
      setState(() {
        userProgress += 1;
        isAnswered = true;
        if (choice.elementAt(index) == correctAnswer) {
          isCorrect = true;
          userPoint = userPoint + 1;
        } else {
          isCorrect = false;
        }
      });

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          isAnswered = false;
        });
      });
    }
    setState(() {
      showResultDialog = true;
    });

    if (userProgress == totalQuestion) {
      _audio.playCompleteSound();
      String lottieAsset = _getLottieAsset(userPoint);
      _timeRecord.stopTimer();
      saveGameResults(
          widget.gameid,
          calculateScore(userPoint, totalQuestion, _timeRecord.seconds),
          _timeRecord.seconds);
      _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
          lottieAsset, false, userPoint);
      return;
    }
    nextQuestion(widget.level);
  }
}
