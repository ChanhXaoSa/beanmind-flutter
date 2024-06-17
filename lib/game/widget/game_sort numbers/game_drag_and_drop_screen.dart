import 'dart:math';

import 'package:beanmind_flutter/game/class/drag_and_drop/math_sort.dart';
import 'package:beanmind_flutter/game/game_list.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/split_panels.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class MathDragAndDropScreen extends StatefulWidget {
  @override
  _MathDragAndDropScreenState createState() => _MathDragAndDropScreenState();
}

class _MathDragAndDropScreenState extends State<MathDragAndDropScreen> {
  final FocusNode _resultFocusNode = FocusNode();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late VideoPlayerController _videoPlayerController;
  late SplitPanels _splitPanels;
  bool showResultDialog = false;

  int userPoint = 0;
  int userProgress = 0;
  int totalQuestion = 3;
  String userAnswer = '';
  var randomNumber = Random();

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  List<String> numberPad = [
    'CHECK RESULT',
    'RESET',
  ];

  void buttonTapped(String button) {
    setState(() {
      if (button == 'CHECK RESULT') {
        checkResult();
      } else if (button == 'RESET') {
        upper.clear();
        lower = List.from(startLower);
        _splitPanels = SplitPanels();
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

  void checkResult() {
    setState(() {
      showResultDialog = true;
    });

    // Check if the upper list is empty
    if (upper.isEmpty) {
      _showDialogError(
          'Bạn chưa đặt các thẻ số lên phía trên \nhãy xếp số theo thứ tự từ bé đến lớn!');
      return;
    }

    // Check if the upper list is sorted in ascending order
    bool isSorted = true;
    for (int i = 0; i < upper.length - 1; i++) {
      if (upper[i] > upper[i + 1]) {
        isSorted = false;
        break;
      }
    }

    if (upper.length == 10) {
      userProgress += 1;
      if (isSorted) {
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
            'Correct!', 'assets/lotties/success.json', false, true, false);
      } else {
        if (userProgress == totalQuestion) {
          _playSuccessSound();
          String lottieAsset = _getLottieAsset(userPoint);
          _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
              lottieAsset, false, userPoint);
          return;
        }
        _showDialog(
            'Incorrect!', 'assets/lotties/wrong.json', false, true, true);
      }
    } else if (isSorted) {
      _showDialog(
          'Correct!', 'assets/lotties/success.json', true, false, false);
    } else {
      _showDialog('Incorrect!', 'assets/lotties/wrong.json', true, false, true);
    }
  }

  void goToNextQuestion() {
    if (showResultDialog) {
      Navigator.of(context).pop();
      setState(() {
        resetGameSortNumber();
        lower = List.from(startLower);
        _splitPanels = SplitPanels();
        userAnswer = '';
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
    _splitPanels = SplitPanels();
  }

  void resetGame() {
    Navigator.of(context).pop();
    setState(() {
      userPoint = 0;
      userProgress = 0;
      upper.clear();
      lower = List.from(startLower);
      _splitPanels = SplitPanels();
    });
  }

  void backtoHome() {
    // go to GameList
    Get.offAll(() => GameList());
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
            Container(
              height: 60,
              color: Colors.deepPurple,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Xếp số theo thứ tự từ bé đến lớn',
                      style: whiteTextStyle,
                    ),
                  ],
                ),
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
                            child: _splitPanels,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: GridView.builder(
                              itemCount: numberPad.length,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, // Số cột
                                childAspectRatio: 4, // Tỷ lệ khung hình
                              ),
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
                            child: _splitPanels,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: GridView.builder(
                              itemCount: numberPad.length,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, // Số cột
                                childAspectRatio: 4, // Tỷ lệ khung hình
                              ),
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
