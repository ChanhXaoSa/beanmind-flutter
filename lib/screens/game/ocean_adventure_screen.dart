import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:beanmind_flutter/controllers/game/game_chapter_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/widgets/game/class/audio.dart';
import 'package:beanmind_flutter/widgets/game/class/font_style.dart';
import 'package:beanmind_flutter/widgets/game/class/ocean_adventure/ocean_adventure_level.dart';
import 'package:beanmind_flutter/widgets/game/class/ocean_adventure/ocean_adventure_user.dart';
import 'package:beanmind_flutter/widgets/game/class/save_game_result.dart';
import 'package:beanmind_flutter/widgets/game/class/score_cal.dart';
import 'package:beanmind_flutter/widgets/game/class/timer.dart';
import 'package:beanmind_flutter/widgets/game/widget/game_ocean_adventure/ocean_adventure.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class OceanAdventureScreen extends StatefulWidget {
  final int level;
  final String gameid;
  OceanAdventureScreen({required this.level, required this.gameid});
  @override
  _OceanAdventureScreenState createState() => _OceanAdventureScreenState();
}

class _OceanAdventureScreenState extends State<OceanAdventureScreen> {
  final FocusNode _resultFocusNode = FocusNode();
  final Audio _audio = Audio();
  late VideoPlayerController _videoPlayerController;
  late GameOceanAdventure _gameOceanAdventure;
  TimeRecord _timeRecord = TimeRecord();
  var randomNumber = Random();

  bool _isLoading = true;
  bool isCorrect = false;

  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    '\u2190',
    '1',
    '2',
    '3',
    '=',
    '0',
    '/'
  ];

  List<String> numberPadMobie = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    'C',
    '\u2190',
    '/',
    '='
  ];

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
    userAnswer = '';
    userPoint = 0;
    userProgress = 0;
    _gameOceanAdventure = GameOceanAdventure(level: widget.level);
    generateQuestion(widget.level);
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
                buttonTapped('\u2190');
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Focean_adventure%2Focean_tutorial_1.png?alt=media&token=558d17d3-c341-44b2-9b5e-b75938bc6e49',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: const Text(
                                            'Tên của các loại động vật hiển thị trên màn hình',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Focean_adventure%2Focean_tutorial_2.png?alt=media&token=d8a4ca58-e536-4028-8cd6-ced9d933c67f',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: const Text(
                                            'Bạn sẽ đếm số lượng các động vật hiển thị trên màn hình, đọc câu hỏi đang hiển thị và nhập kết quả',
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
                Container(
                    height: 60,
                    color: Colors.deepPurple,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            question,
                            style: whiteTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            color: Colors.blue[100],
                            child: Text(
                              '$userAnswer',
                              style:
                                  whiteTextStyle.copyWith(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: isWideScreen
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(
                                    top: 15, left: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 5,
                                      color: Theme.of(context)
                                          .cardColor
                                          .withAlpha(100)),
                                ),
                                child: GameWidget(game: _gameOceanAdventure),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: GridView.builder(
                                  itemCount: numberPad.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 0.9),
                                  itemBuilder: (context, index) {
                                    return MyButton(
                                      child: numberPad[index],
                                      onTap: () =>
                                          buttonTapped(numberPad[index]),
                                    );
                                  },
                                ),
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
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 5,
                                      color: Theme.of(context)
                                          .cardColor
                                          .withAlpha(100)),
                                ),
                                child: GameWidget(game: _gameOceanAdventure),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: GridView.builder(
                                  itemCount: numberPadMobie.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7,
                                          childAspectRatio: 2.2),
                                  itemBuilder: (context, index) {
                                    return MyButton(
                                      child: numberPadMobie[index],
                                      onTap: () =>
                                          buttonTapped(numberPadMobie[index]),
                                    );
                                  },
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

  // show dialog corect or wrong
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
      if (button == '=') {
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == '\u2190') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 4) {
        userAnswer += button;
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
      _gameOceanAdventure = GameOceanAdventure(level: widget.level);
      resetAnimalOcean();
      generateQuestion(widget.level);
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
    if (userAnswer.isEmpty) {
      _showDialogError('Bạn chưa nhập số !');
      return;
    }
    userProgress += 1;
    setState(() {
      showResultDialog = true;
    });

    if (widget.level == 1) {
      // Level 1: Counting
      int correctCount = getAnimalCountByType(currentQuestionType);
      isCorrect = correctCount == int.parse(userAnswer);
    } else if (widget.level == 2 || widget.level == 3) {
      // Level 2 and Level 3
      List<String> questionParts = currentQuestionType.split(' ');
      int num1 = getAnimalCountByType(questionParts[0]); // First animal
      int num2 = getAnimalCountByType(questionParts[2]); // Second animal
      String operator = questionParts[1];

      if (operator == '/' && userAnswer.contains('/')) {
        // Handle division with remainder for level 3
        int correctAnswerQuotient = calculateAnswerLevel3(num1, num2, '/');
        int correctAnswerRemainder = calculateAnswerLevel3(num1, num2, '%');

        List<String> parts = userAnswer.split('/');
        int numerator = int.parse(parts[0]);
        int denominator = int.parse(parts[1]);

        int quotient = calculateAnswerLevel3(numerator, denominator, '/');
        int remainder = calculateAnswerLevel3(numerator, denominator, '%');

        isCorrect = (quotient == correctAnswerQuotient &&
            remainder == correctAnswerRemainder);
      } else {
        int correctAnswer = widget.level == 2
            ? calculateAnswerLevel2(num1, num2, operator)
            : calculateAnswerLevel3(num1, num2, operator);
        isCorrect = correctAnswer == int.parse(userAnswer);
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
          'Đúng rồi !', 'assets/lotties/success.json', false, true, false);
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
        userAnswer = '';
        _gameOceanAdventure = GameOceanAdventure(level: widget.level);
        resetAnimalOcean();
        generateQuestion(widget.level);
      });
      setState(() {
        showResultDialog = false;
      });
    }
  }

  Future<void> delay3Seconds() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showGuide = prefs.getBool('showGuideGameAdventure') ?? true;

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
                          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Focean_adventure%2Focean_tutorial_1.png?alt=media&token=558d17d3-c341-44b2-9b5e-b75938bc6e49',
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            'Tên của các loại động vật hiển thị trên màn hình',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/game_tutorial_images%2Focean_adventure%2Focean_tutorial_2.png?alt=media&token=d8a4ca58-e536-4028-8cd6-ced9d933c67f',
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            'Bạn sẽ đếm số lượng các động vật hiển thị trên màn hình, đọc câu hỏi đang hiển thị và nhập kết quả',
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
                      prefs.setBool('showGuideGameAdventure', false);
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
  }
}
