import 'dart:math';
import 'package:beanmind_flutter/game/game_list.dart';
import 'package:beanmind_flutter/game/widget/game_odd_and_even/odd_and_even.dart';
import 'package:beanmind_flutter/models/game_animal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class GameOddAndEvenScreen extends StatefulWidget {
  @override
  _GameOddAndEvenScreenState createState() => _GameOddAndEvenScreenState();
}

class _GameOddAndEvenScreenState extends State<GameOddAndEvenScreen> {
  final FocusNode _resultFocusNode = FocusNode();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late VideoPlayerController _videoPlayerController;
  late GameOddAndEven _gameOddAndEven;
  bool isFirstKeyEvent = true;
  bool showResultDialog = false;

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0'
  ];

  String userAnswer = '';
  int userPoint = 0;
  var randomNumber = Random();
  int userProgress = 0;
  int totalQuestion = 3;

  void buttonTapped(String button) {
    setState(() {
      if (button == '1') {
        userAnswer = 'số lẻ';
        checkResult();
      } else if (button == '2') {
        userAnswer = 'số chẵn';
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
      _gameOddAndEven = GameOddAndEven(animalslist: animalslist);
      resetAnimal();
    });
  }

  void backtoHome() {
    // go to GameList
    Get.offAll(() => GameList());
  }

  void checkResult() {
    userProgress += 1;

    setState(() {
      showResultDialog = true;
    });

    if (userAnswer.isEmpty) {
      _showDialog('Incorrect!', 'assets/lotties/wrong.json', true, true, true);
    }

    if (userAnswer == 'số lẻ' &&
        (globalRedBirdCount + globalBlueBirdCount) % 2 == 1) {
      userPoint += 1;
      _playSuccessSound();
      if (userProgress == totalQuestion) {
        _playSuccessSound();
        String lottieAsset = _getLottieAsset(userPoint);
        _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
            lottieAsset, false, userPoint);
        return;
      }
      _showDialog(
          'Congratulations!', 'assets/lotties/success.json', true, true, false);
    } else if (userAnswer == 'số chẵn' &&
        (globalRedBirdCount + globalBlueBirdCount) % 2 == 0) {
      userPoint += 1;
      _playSuccessSound();
      if (userProgress == totalQuestion) {
        _playSuccessSound();
        String lottieAsset = _getLottieAsset(userPoint);
        _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
            lottieAsset, false, userPoint);
        return;
      }
      _showDialog(
          'Congratulations!', 'assets/lotties/success.json', true, true, false);
    } else {
      if (userProgress == totalQuestion) {
        _playSuccessSound();
        String lottieAsset = _getLottieAsset(userPoint);
        _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
            lottieAsset, false, userPoint);
        return;
      }
      _showDialog('Incorrect!', 'assets/lotties/wrong.json', true, true, true);
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
        resetAnimal();
        userAnswer = '';
        _gameOddAndEven = GameOddAndEven(animalslist: animalslist);
        resetAnimal();
      });
      setState(() {
        showResultDialog = false;
      });
    }
  }

  void _playSuccessSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/success.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing success sound: $e');
      print(stacktrace);
    }
  }

  @override
  void dispose() {
    _resultFocusNode.dispose();
    _audioPlayer.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((value) => {setState(() {})});

    _gameOddAndEven = GameOddAndEven(animalslist: animalslist);
    resetAnimal();
  }

  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    resetAnimal();
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
        animalslist = List<GameAnimalModel>.from(items);
        _gameOddAndEven = GameOddAndEven(animalslist: animalslist);
        resetAnimal();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
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
                      'Thời gian hoàn thành trò chơi: ',
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double thresholdWidth = 600;
    final bool isWideScreen = screenSize.width > thresholdWidth;
    FocusScope.of(context).requestFocus(_resultFocusNode);

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
                    child: const Text('Hướng dẫn'),
                  ),
                ],
              ),
            ),
            Expanded(
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
            Container(
                height: 120,
                color: Colors.deepPurple,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Số lượng chim là',
                        style: whiteTextStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          buttonTapped('1');
                        },
                        child: const Text(
                          'số lẻ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.green),
                        ),
                      ),
                      Text(
                        'hay',
                        style: whiteTextStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          buttonTapped('2');
                        },
                        child: const Text(
                          'số chẵn',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.red),
                        ),
                      )
                    ],
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
    );
  }
}
