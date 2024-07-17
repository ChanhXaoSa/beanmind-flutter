import 'package:just_audio/just_audio.dart';

class Audio {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundMusic = AudioPlayer();

  void playSuccessSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/success.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing success sound: $e');
      print(stacktrace);
    }
  }

  void playWrongSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/wrong.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing wrong sound: $e');
      print(stacktrace);
    }
  }

  void playCompleteSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/completed.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing complete sound: $e');
      print(stacktrace);
    }
  }

  void playMouseClickSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/mouse-click.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing click sound: $e');
      print(stacktrace);
    }
  }

  void playDropSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/drop.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing drop sound: $e');
      print(stacktrace);
    }
  }

  void playButtonSound() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/button.mp3');
      _audioPlayer.play();
    } catch (e, stacktrace) {
      print('Error playing button sound: $e');
      print(stacktrace);
    }
  }

  void playBackgroundMusicHappyFarm() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      await _backgroundMusic
          .setAsset('assets/sounds/music_background/music_happy_farm.mp3');
      _backgroundMusic.setLoopMode(LoopMode.one);
      _backgroundMusic.play();
    } catch (e, stacktrace) {
      print('Error playing background music: $e');
      print(stacktrace);
    }
  }

  void playBackgroundMusicAdventure() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      await _backgroundMusic
          .setAsset('assets/sounds/music_background/music_adventure.mp3');
      _backgroundMusic.setLoopMode(LoopMode.one);
      _backgroundMusic.play();
    } catch (e, stacktrace) {
      print('Error playing background music: $e');
      print(stacktrace);
    }
  }

  void stopBackgroundMusic() {
    _backgroundMusic.stop();
  }
}
