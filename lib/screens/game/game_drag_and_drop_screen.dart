import 'dart:math';
import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/widgets/game/class/audio.dart';
import 'package:beanmind_flutter/widgets/game/class/drag_and_drop/math_sort_level.dart';
import 'package:beanmind_flutter/widgets/game/class/drag_and_drop/math_sort_user.dart';
import 'package:beanmind_flutter/widgets/game/class/save_game_result.dart';
import 'package:beanmind_flutter/widgets/game/class/timer.dart';
import 'package:beanmind_flutter/widgets/game/widget/game_sort%20numbers/split_panels.dart';
import 'package:beanmind_flutter/widgets/game/widget/game_sort%20numbers/split_panels_mobie.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
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
  final Audio _audio = Audio();
  late VideoPlayerController _videoPlayerController;
  late SplitPanels _splitPanels;
  late SplitPanelsMobie _splitPanelsMobie;
  late TimeRecord _timeRecord = TimeRecord();

  bool showResultDialog = false;
  bool _isLoading = true;

  int userPoint = 0;
  int userProgress = 0;
  int totalQuestion = 3;
  String userAnswer = '';
  var randomNumber = Random();
  String gameId = 'game003';
  String background =
      'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_1.png?alt=media&token=39e27f13-3fc8-42b8-9365-0b635c9ee860';

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  List<String> numberPad = [
    'XONG',
    'KHÔI PHỤC',
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
    resetGameSortNumber();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((value) => {setState(() {})});
    _splitPanels = SplitPanels();
    _splitPanelsMobie = SplitPanelsMobie();
    generateSortingQuestion();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _timeRecord.startTimer();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double thresholdWidth = 600;
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
      return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Container(
            key: ValueKey<String>(background),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    background), // Thay 'url' bằng đường dẫn URL thực tế của hình ảnh
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 25,
                  ),
                  height: 60,
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          question,
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: isWideScreen
                      ? Container(
                          padding: EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  alignment: Alignment.topCenter,
                                  child: _splitPanelsMobie,
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
                                child: _splitPanelsMobie,
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
                  child: Container(
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

  void buttonTapped(String button) {
    setState(() {
      if (button == 'XONG') {
        checkResult();
      } else if (button == 'KHÔI PHỤC') {
        upper.clear();
        lower = List.from(startLower);
        _splitPanels = SplitPanels();
        _splitPanelsMobie = SplitPanelsMobie();
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
          'Bạn chưa đặt các thẻ số lên phía trên \nhãy xếp số theo thứ tự đề bài yêu cầu!');
      return;
    }

    // Check if the upper list is sorted in ascending order
    bool isSortedAscending = true;
    for (int i = 0; i < upper.length - 1; i++) {
      if (upper[i] > upper[i + 1]) {
        isSortedAscending = false;
        break;
      }
    }

    // Check if the upper list is sorted in descending order
    bool isSortedDescending = true;
    for (int i = 0; i < upper.length - 1; i++) {
      if (upper[i] < upper[i + 1]) {
        isSortedDescending = false;
        break;
      }
    }

    if (upper.length == 10) {
      userProgress += 1;
      setState(() {
        changeBackgroundColor();
      });
      if ((sortingOrder == 'ascending' && isSortedAscending) ||
          (sortingOrder == 'descending' && isSortedDescending)) {
        userPoint += 1;
        _audio.playSuccessSound();
        if (userProgress == totalQuestion) {
          _audio.playCompleteSound();
          String lottieAsset = _getLottieAsset(userPoint);
          _timeRecord.stopTimer();
          saveGameResults(
              gameId, userPoint, userPoint, userProgress, _timeRecord.seconds);
          setState(() {
            resetGameSortNumber();
          });
          _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
              lottieAsset, false, userPoint);
          return;
        }
        setState(() {
          resetGameSortNumber();
        });
        _showDialog(
            'Đúng rồi !', 'assets/lotties/success.json', false, true, false);
      } else {
        if (userProgress == totalQuestion) {
          _audio.playCompleteSound();
          String lottieAsset = _getLottieAsset(userPoint);
          _timeRecord.stopTimer();
          saveGameResults(
              gameId, userPoint, userPoint, userProgress, _timeRecord.seconds);
          setState(() {
            resetGameSortNumber();
          });
          _showDialogCompleted('Xin chúc mừng bạn đã hoàn thành trò chơi!',
              lottieAsset, false, userPoint);
          return;
        }
        setState(() {
          resetGameSortNumber();
        });
        _showDialog(
            'Sai rồi !', 'assets/lotties/wrong.json', false, true, true);
      }
    } else if ((sortingOrder == 'ascending' && isSortedAscending) ||
        (sortingOrder == 'descending' && isSortedDescending)) {
      _showDialog(
          'Đúng rồi !', 'assets/lotties/success.json', true, false, false);
    } else {
      _audio.playWrongSound();
      _showDialog('Sai rồi !', 'assets/lotties/wrong.json', true, false, true);
    }
  }

  void goToNextQuestion() {
    if (showResultDialog) {
      Navigator.of(context).pop();
      setState(() {
        resetGameSortNumber();
        lower = List.from(startLower);
        _splitPanels = SplitPanels();
        _splitPanelsMobie = SplitPanelsMobie();
        userAnswer = '';
        generateSortingQuestion();
      });
      setState(() {
        showResultDialog = false;
      });
    }
  }

  void resetGame() {
    Navigator.of(context).pop();
    setState(() {
      userPoint = 0;
      userProgress = 0;
      resetGameSortNumber();
      _timeRecord.seconds = 0;
      _timeRecord.startTimer();
      _splitPanels = SplitPanels();
      _splitPanelsMobie = SplitPanelsMobie();
      generateSortingQuestion();
      changeBackgroundColor();
    });
  }

  void backtoHome() {
    // go to GameList
    final GameController controller = Get.find();
    setState(() {
      controller.shouldReset.value = true;
      Get.offAllNamed(GameListScreen.routeName);
    });
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

  void changeBackgroundColor() {
    setState(() {
      if (userProgress == 0) {
        background =
            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_1.png?alt=media&token=39e27f13-3fc8-42b8-9365-0b635c9ee860';
      } else if (userProgress == 1) {
        background =
            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_2.png?alt=media&token=e408883e-3659-40a8-98c2-8f67f652aaf7';
      } else if (userProgress == 2) {
        background =
            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_3.png?alt=media&token=4ef2ebe9-0629-4016-b813-3aae768bfc7e';
      } else {
        background =
            'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_1.png?alt=media&token=39e27f13-3fc8-42b8-9365-0b635c9ee860';
      }
    });
  }
}
