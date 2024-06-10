import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:beanmind_flutter/game/class/drag_and_drop/math_sort.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/split_panels.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  List<String> numberPad = [
    'CHECK RESULT',
    'RESET',
  ];

  String userAnswer = '';
  int userPoint = 0;

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
      _showDialog('Incorrect!', 'assets/lotties/wrong.json', false, true);
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

    if (isSorted && upper.length == 10) {
      userPoint += 1;
      _playSuccessSound();
      _showDialog(
          'Congratulations!', 'assets/lotties/success.json', true, false);
    } else if (isSorted) {
      _showDialog('Correct!', 'assets/lotties/success.json', false, false);
    } else {
      _showDialog('Incorrect!', 'assets/lotties/wrong.json', false, true);
    }
  }

  void _showDialog(String message, String lottieAsset, bool showNextQuestion,
      bool showVideo) {
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
              height: 60,
              color: Colors.deepPurple,
              child: Center(
                child: Text(
                  'Total point : ' + userPoint.toString(),
                  style: whiteTextStyle,
                ),
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
