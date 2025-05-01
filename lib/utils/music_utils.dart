import 'package:audioplayers/audioplayers.dart';

class MusicUtils {
  void success()async{
    final player = AudioPlayer();
    await player.play(AssetSource('music/success.mp3'));

  }
}