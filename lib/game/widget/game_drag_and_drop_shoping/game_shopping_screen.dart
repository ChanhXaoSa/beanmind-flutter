import 'dart:async';

import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/game/class/audio.dart';
import 'package:beanmind_flutter/game/class/save_game_result.dart';
import 'package:beanmind_flutter/game/class/timer.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_split_panels.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_split_panels_mobie.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import '../../../models/game_model.dart';

class GameShoppingScreen extends StatefulWidget {
  @override
  _GameShoppingScreenState createState() => _GameShoppingScreenState();
}

class _GameShoppingScreenState extends State<GameShoppingScreen> {
  final FocusNode _resultFocusNode = FocusNode();
  final _audio = Audio();
  late VideoPlayerController _videoPlayerController;
  late ShopingSplitPanels _shopingSplitPanels;
  late ShopingSplitPanelsMobie _shopingSplitPanelsMobie;
  TimeRecord _timeRecord = TimeRecord();

  bool showResultDialog = false;
  bool _isLoading = true;
  String gameId = 'game004';

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  List<String> numberPad = [
    'CHECK RESULT',
    'RESET',
  ];

  int userPoint = 0;
  int userProgress = 0;
  int totalQuestion = 3;

  // time

  void buttonTapped(String button) {
    try {
      if (button == 'RESET') {
        setState(() {
          balance = 100;
          lastbalance = 20;
          upperItemModel.clear();
          lowerItemModel = List.from(startLowerItemModel);
          _shopingSplitPanels = ShopingSplitPanels();
          _shopingSplitPanelsMobie = ShopingSplitPanelsMobie();
        });
      }
      if (button == 'CHECK RESULT') {
        checkResult();
      }
    } catch (e) {
      print(e);
    }
  }

  void resetGame() {
    try {
      Navigator.of(context).pop();
      setState(() {
        balance = 100;
        lastbalance = 20;
        userPoint = 0;
        userProgress = 0;
        _timeRecord.seconds = 0;
        _timeRecord.startTimer();
        upperItemModel = [];
        lowerItemModel = List<ItemModel>.from(startLowerItemModel);
        _shopingSplitPanels = ShopingSplitPanels();
        _shopingSplitPanelsMobie = ShopingSplitPanelsMobie();
      });
    } catch (e) {
      print(e);
    }
  }

  void backtoHome() {
    // go to GameList
    Get.offAll(GameListScreen.routeName);
  }

  void checkResult() {
    try {
      if (upperItemModel.isEmpty) {
        _showDialogError('Bạn chưa chọn sản phẩm nào!');
        return;
      }

      userProgress += 1;
      setState(() {
        showResultDialog = true;
      });
      if (balance == lastbalance) {
        userPoint += 1;
        _audio.playSuccessSound();
        ();
        if (userProgress == totalQuestion) {
          _audio.playCompleteSound();
          ();
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
          ();
          String lottieAsset = _getLottieAsset(userPoint);
          _timeRecord.stopTimer();
          saveGameResults(
              gameId, userPoint, userPoint, userProgress, _timeRecord.seconds);
          _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
              lottieAsset, false, userPoint);
          return;
        }
        _audio.playWrongSound();
        ();
        _showDialog('Sai rồi!', 'assets/lotties/wrong.json', false, true, true);
      }
    } catch (e) {
      print(e);
    }
  }

  String _getLottieAsset(int userPoint) {
    print(userPoint);
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
    try {
      if (showResultDialog) {
        Navigator.of(context).pop();
        setState(() {
          balance = 100;
          lastbalance = 20;
          upperItemModel.clear();
          lowerItemModel = List.from(startLowerItemModel);
          _shopingSplitPanels = ShopingSplitPanels();
          _shopingSplitPanelsMobie = ShopingSplitPanelsMobie();
        });
        setState(() {
          showResultDialog = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
    _shopingSplitPanels = ShopingSplitPanels();
    _shopingSplitPanelsMobie = ShopingSplitPanelsMobie();
    // delay 3s to show the dialog
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _timeRecord.startTimer();
      });
    });
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
    const double thresholdWidth = 600;
    final bool isWideScreen = screenSize.width > thresholdWidth;
    FocusScope.of(context).requestFocus(_resultFocusNode);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    if (_isLoading) {
      return Center(child: ProgressWidgets());
    } else {
      return Container(
        decoration: BoxDecoration(gradient: mainGradient(context)),
        child: KeyboardListener(
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
              }
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white70,
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 60,
                  decoration: BoxDecoration(gradient: mainGradient(context)),
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
                                content: const Text(
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
                  decoration: BoxDecoration(gradient: mainGradient(context)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Kéo thả sản phẩm cho đến khi số tiền bạn có bằng với số tiền cần giữ lại theo yêu cầu',
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: isWideScreen
                      ? Container(
                          color: Colors.white70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  child: _shopingSplitPanelsMobie,
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
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, // Số cột
                                      childAspectRatio: 4, // Tỷ lệ khung hình
                                    ),
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
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: _shopingSplitPanelsMobie,
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
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, // Số cột
                                    childAspectRatio: 4, // Tỷ lệ khung hình
                                  ),
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
                        ),
                ),
                Focus(
                  focusNode: _resultFocusNode,
                  child: const SizedBox(
                    height: 0,
                    width: 0,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
