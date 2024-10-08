import 'dart:math';
import 'package:beanmind_flutter/controllers/game/game_chapter_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/widgets/game/class/audio.dart';
import 'package:beanmind_flutter/widgets/game/class/bird_fly/bird_fly_level.dart';
import 'package:beanmind_flutter/widgets/game/class/bird_fly/bird_fly_user.dart';
import 'package:beanmind_flutter/widgets/game/class/save_game_result.dart';
import 'package:beanmind_flutter/widgets/game/class/score_cal.dart';
import 'package:beanmind_flutter/widgets/game/class/timer.dart';
import 'package:beanmind_flutter/widgets/game/widget/game_odd_and_even/odd_and_even.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class GameOddAndEvenScreen extends StatefulWidget {
  final int level;
  final String gameid;
  GameOddAndEvenScreen({required this.level, required this.gameid});
  @override
  _GameOddAndEvenScreenState createState() => _GameOddAndEvenScreenState();
}

class _GameOddAndEvenScreenState extends State<GameOddAndEvenScreen> {
  final FocusNode _resultFocusNode = FocusNode();
  final Audio _audio = Audio();
  late VideoPlayerController _videoPlayerController;
  late GameOddAndEven _gameOddAndEven;
  late TimeRecord _timeRecord = TimeRecord();
  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  bool isFirstKeyEvent = true;
  bool showResultDialog = false;
  bool _isLoading = true;

  String userAnswer = '';
  int userPoint = 0;
  var randomNumber = Random();
  int userProgress = 0;
  int totalQuestion = 3;

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
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((value) => {setState(() {})});
    _gameOddAndEven = GameOddAndEven();
    generateQuestion(widget.level);
    delay3Seconds();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isWideScreen = screenSize.width / screenSize.height > 16 / 9;
    double fontSize;
    if (MediaQuery.of(context).size.width < 1200 ||
        MediaQuery.of(context).size.height < 850) {
      fontSize =
          40; // Assuming you want a smaller font size for smaller screens
    } else if (MediaQuery.of(context).size.width < 1400 ||
        MediaQuery.of(context).size.height < 1100) {
      fontSize = 48;
    } else {
      fontSize = 56;
    }
    FocusScope.of(context).requestFocus(_resultFocusNode);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    return Stack(
      children: [
        KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: (KeyEvent event) {
            if (event is KeyDownEvent) {
              final logicalKey = event.logicalKey;
              if (logicalKey == LogicalKeyboardKey.enter) {
                if (showResultDialog) {
                  goToNextQuestion();
                } else {
                  checkResult();
                }
              } else if (logicalKey == LogicalKeyboardKey.backspace) {
                buttonTapped('DEL');
              }
              final input = logicalKey.keyLabel;
              if (RegExp(r'^[0-9]$').hasMatch(input)) {
                handleNumberButtonPress(input);
              }
            }
          },
          child: Scaffold(
            backgroundColor: Colors.deepPurple[300],
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
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
                            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Fodd_and_even%2Fodd_and_even.png?alt=media&token=2abb288a-259f-4b13-8b84-8cd6fd770cc5',
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              'Xem đề bài, số động vật hiển thị, sau đó chọn đáp án đúng theo yêu cầu của câu hỏi.',
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
                  flex: 5,
                  child: isWideScreen
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: GameWidget(game: _gameOddAndEven),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: GameWidget(game: _gameOddAndEven),
                              ),
                            ),
                          ],
                        ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[600],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                question,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (widget.level == 1) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      buttonTapped('1');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'số lẻ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'hay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  TextButton(
                                    onPressed: () {
                                      buttonTapped('2');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'số chẵn',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ] else if (widget.level == 2) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      buttonTapped('3');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'lớn hơn',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  TextButton(
                                    onPressed: () {
                                      buttonTapped('4');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'bé hơn',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  TextButton(
                                    onPressed: () {
                                      buttonTapped('5');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'bằng nhau',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    )),
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

  void _showDialogCompleted(
      String message, String lottieAsset, bool lockScreen, int userPoint) {
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
                                'Trở về trang khoá học',
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

  void buttonTapped(String button) {
    _audio.playButtonSound();
    setState(() {
      if (button == '1') {
        userAnswer = 'số lẻ';
        checkResult();
      } else if (button == '2') {
        userAnswer = 'số chẵn';
        checkResult();
      } else if (button == '3') {
        userAnswer = 'lớn hơn';
        checkResult();
      } else if (button == '4') {
        userAnswer = 'bé hơn';
        checkResult();
      } else if (button == '5') {
        userAnswer = 'bằng nhau';
        checkResult();
      }
    });
  }

  void handleNumberButtonPress(String number) {
    setState(() {
      if (userAnswer.length < 4) {
        userAnswer += number;
      }
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
      _gameOddAndEven = GameOddAndEven();
      resetAnimalSky();
    });
  }

  void backtoHome() {
    // go to GameList
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

    if (userAnswer.isEmpty) {
      _audio.playWrongSound();
      _showDialog('Sai rồi!', 'assets/lotties/wrong.json', false, true, true);
      return;
    }

    bool isCorrect = false;

    if (widget.level == 1) {
      // Level 1: Check if the answer is even or odd
      int count;
      if (currentQuestionType == 'bluebird') {
        count = globalBlueBirdCount;
      } else if (currentQuestionType == 'redbird') {
        count = globalRedBirdCount;
      } else if (currentQuestionType == 'all') {
        count = globalRedBirdCount + globalBlueBirdCount;
      } else {
        count = 0;
      }

      if (userAnswer == 'số lẻ' && count % 2 == 1) {
        isCorrect = true;
      } else if (userAnswer == 'số chẵn' && count % 2 == 0) {
        isCorrect = true;
      }

    } else if (widget.level == 2) {
      // Level 2: Compare the number of blue birds and red birds
      if (userAnswer == 'lớn hơn' && globalBlueBirdCount > globalRedBirdCount) {
        isCorrect = true;
      } else if (userAnswer == 'bé hơn' &&
          globalBlueBirdCount < globalRedBirdCount) {
        isCorrect = true;
      } else if (userAnswer == 'bằng nhau' &&
          globalBlueBirdCount == globalRedBirdCount) {
        isCorrect = true;
      }
    }

    if (isCorrect) {
      userPoint += 1;
      _audio.playSuccessSound();
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
      _showDialog(
          'Đúng rồi!', 'assets/lotties/success.json', false, true, false);
    } else {
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
      _audio.playWrongSound();
      _showDialog('Sai rồi!', 'assets/lotties/wrong.json', false, true, true);
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
        resetAnimalSky();
        userAnswer = '';
        _gameOddAndEven = GameOddAndEven();
        resetAnimalSky();
      });
      setState(() {
        showResultDialog = false;
        generateQuestion(widget.level);
      });
    }
  }

  void delay3Seconds() {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool showGuide = prefs.getBool('showGuideOddAndEven') ?? true;

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
                            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Fodd_and_even%2Fodd_and_even.png?alt=media&token=2abb288a-259f-4b13-8b84-8cd6fd770cc5',
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              'Xem đề bài, số động vật hiển thị, sau đó chọn đáp án đúng theo yêu cầu của câu hỏi.',
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
                        prefs.setBool('showGuideOddAndEven', false);
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
}
