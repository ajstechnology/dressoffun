// import 'package:audioplayer/audioplayer.dart';
import 'package:dress_the_fan/usage/app_enum.dart';
import 'package:dress_the_fan/usage/app_strings.dart';
import 'package:just_audio/just_audio.dart';

import 'app_assets.dart';
import 'app_common.dart';

class AppAudioPlayer{
  /*static AudioPlayer _audioPlayer = AudioPlayer();
  static AudioPlayerState _audioPlayerState = AudioPlayerState.STOPPED;

  static initAudioPlayer(){
    _audioPlayer.play(AppAssets.backgroundMusic);
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if(AudioPlayerState.COMPLETED == event)
        _audioPlayer.seek(0);
    }, onError: (msg){
      print("Audio Player Error = $msg");
    });
  }

  static togglePlayer(isPlaying){
    // if(_audioPlayer.state != AudioPlayerState.PLAYING){
    if(isPlaying){
      _audioPlayer.seek(0);
      _audioPlayer.play(AppAssets.backgroundMusic);
    } else {
      _audioPlayer.pause();
    }
  }*/

  static AudioPlayer player = AudioPlayer();
  static AudioPlayer clickSoundPlayer = AudioPlayer();

  static initAudioPlayer() async {
    await player.setAsset(AppAssets.bgSound1);
    await clickSoundPlayer.setAsset(AppAssets.buttonClickSound);
    // player.setVolume(0.09);

    player.setLoopMode(LoopMode.one);
    player.play();

    clickSoundPlayer.setLoopMode(LoopMode.off);
    clickSoundPlayer.setVolume(0);
    clickSoundPlayer.play();
    clickSoundPlayer.setVolume(1.0);
  }

  PlayerState get playerState => player.playerState;

  static togglePlayer(){
    // if(_audioPlayer.state != AudioPlayerState.PLAYING){
    if(AppCommon.vnMusicState.value == EnumSoundState.On){
      player.pause();
      // AppCommon.vnMusicState.value = EnumSoundState.Off;
    } else {
      player.play();
      // AppCommon.vnMusicState.value = EnumSoundState.On;
    }

  }

  static startPlaying(){
    player.play();
    // AppCommon.vnMusicState.value = EnumSoundState.On;
  }

  static stopPlaying(){
    player.pause();
    // AppCommon.vnMusicState.value = EnumSoundState.Off;
  }

  static changeMusicTrack(String musicTrack) async {
    await AppAudioPlayer.player.setAsset(musicTrack);
    player.setLoopMode(LoopMode.one);
    if(AppCommon.vnMusicState.value == EnumSoundState.On)
      player.play();
  }

}