import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioButton extends StatefulWidget {
  @override
  _AudioButtonState createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    //player.setAsset('assets/sounds/music_background/music_happy_farm.mp3');
    //player.setAsset('assets/sounds/music_background/music_adventure.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  void _togglePlayPause() {
    if (isPlaying) {
      player.pause();
    } else {
      player.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _togglePlayPause,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10), // Điều chỉnh kích thước nút
      ),
      child: Icon(
        isPlaying ? Icons.music_note_sharp : Icons.music_off_sharp,
        size: 30, // Điều chỉnh kích thước biểu tượng
      ),
    );
  }
}
