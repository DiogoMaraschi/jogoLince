import 'package:audioplayers/audioplayers.dart';
import 'package:untitled/model/cores.dart';

class SoundRepository {
  final sonsCores = {
    Cores.red: 'sounds/soundR.wav',
    Cores.green: 'sounds/soundG.wav',
    Cores.blue: 'sounds/soundB.wav',
    Cores.yellow: 'sounds/soundY.wav',
  };

  final player = AudioPlayer();

  Future<void> tocarCores(Cores cor) async {
    await player.play(AssetSource(sonsCores[cor]!));
  }
}
