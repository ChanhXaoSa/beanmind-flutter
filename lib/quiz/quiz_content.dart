import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuizContent extends StatefulWidget {
  @override
  _QuizContentState createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {
  FlutterTts flutterTts = FlutterTts();
  String question = "Chữ A là chữ nào ?";
  String answer = ""; // store user's answer
  String correctAnswer = "A"; // example correct answer

  // void showVideoTutorial() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.deepPurple,
  //           content: Container(
  //             height: 400,
  //             color: Colors.deepPurple,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Text(
  //                   'Incorrect!',
  //                   style: whiteTextStyle,
  //                 ),
  //                 Lottie.asset('assets/lotties/wrong.json', height: 100),
  //                 Center(
  //                   child: _videoPlayerController.value.isInitialized
  //                       ? AspectRatio(aspectRatio: _videoPlayerController.value.aspectRatio, child: VideoPlayer(_videoPlayerController),)
  //                       : Container(),
  //                 ),
  //                 FloatingActionButton(onPressed: () {
  //                   setState(() {
  //                     _videoPlayerController.value.isPlaying ?
  //                     _videoPlayerController.pause() : _videoPlayerController.play();
  //                   });
  //                 },
  //                   child: Icon(_videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                speak(question);
              },
              child: Icon(Icons.volume_up_outlined),
            ),
            SizedBox(height: 20),
            Text(question), // Display question
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 'A',
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value!;
                    });
                  },
                ),
                Text('A'),
                Radio(
                  value: 'B',
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value!;
                    });
                  },
                ),
                Text('B'),
                Radio(
                  value: 'C',
                  groupValue: answer,
                  onChanged: (value) {
                    setState(() {
                      answer = value!;
                    });
                  },
                ),
                Text('C'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Check answer
                if (answer == correctAnswer) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Kết quả"),
                        content: Text("Đúng!"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Kết quả"),
                        content: Text("Sai!"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit Answer'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Video Tutorial')),
          ],
        ),
      ),
    );
  }

  Future speak(String text) async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
