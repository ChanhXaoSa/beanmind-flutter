import 'dart:math';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/widgets/game/class/audio.dart';
import 'package:beanmind_flutter/widgets/game/class/font_style.dart';
import 'package:beanmind_flutter/widgets/game/class/ocean_adventure/ocean_adventure_level.dart';
import 'package:beanmind_flutter/widgets/game/class/ocean_adventure/ocean_adventure_user.dart';
import 'package:beanmind_flutter/widgets/game/class/save_game_result.dart';
import 'package:beanmind_flutter/widgets/game/class/timer.dart';
import 'package:beanmind_flutter/widgets/game/widget/game_ocean_adventure/ocean_adventure.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class OceanAdventureScreen extends StatefulWidget {
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
  String gameId = 'game001';

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
    fetchData();
    generateQuestion();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _timeRecord.startTimer();
      });
    });
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
    if (_isLoading) {
      return Center(child: ProgressWidgets());
    } else {
      return KeyboardListener(
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
                              content: Text(
                                'Nội dung hướng dẫn người chơi...',
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                                    onTap: () => buttonTapped(numberPad[index]),
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
      );
    }
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
                          onTap: backtoHome,
                          child: Row(
                            children: [
                              Text(
                                'Trở về trang chủ ',
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
      _gameOceanAdventure = GameOceanAdventure(animalslist: animalslist);
      resetAnimalOcean();
      generateQuestion();
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

  void checkResult() {
    if (userAnswer.isEmpty) {
      _showDialogError('Bạn chưa nhập số !');
      return;
    }
    userProgress += 1;
    setState(() {
      showResultDialog = true;
    });

    if (currentLevel == 1) {
      // Level 1: Counting
      int correctCount = getAnimalCountByType(currentQuestionType);
      isCorrect = correctCount == int.parse(userAnswer);
    } else if (currentLevel == 2 || currentLevel == 3) {
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
        int correctAnswer = currentLevel == 2
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
            gameId, userPoint, userPoint, userProgress, _timeRecord.seconds);
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
            gameId, userPoint, userPoint, userProgress, _timeRecord.seconds);
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
        _gameOceanAdventure = GameOceanAdventure(animalslist: animalslist);
        resetAnimalOcean();
        generateQuestion();
      });
      setState(() {
        showResultDialog = false;
      });
    }
  }

  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    resetAnimalOcean();
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('animal').get();

      List<GameAnimalModel> items = snapshot.docs
          .map((doc) => GameAnimalModel.fromSnapshot(doc))
          .toList();
      print('Number of items fetched: ${items.length}');
      items.forEach((item) {
        print('Item: ${item.id}, ImageUrl: ${item.imageurl}');
      });

      // Update startLower and lower with the fetched items
      setState(() {
        resetAnimalOcean();
        animalslist = List<GameAnimalModel>.from(items);
        _gameOceanAdventure = GameOceanAdventure(animalslist: animalslist);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
