import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_music_demo/app/di/app_module.dart';
import 'package:flutter_music_demo/service/audio_service.dart';
import 'package:flutter_music_demo/util/helper.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final audioService = locator<AudioService>();

  void initialise() {
    loadAudio();
    notifyListeners();
  }

  int currentProgress = 0;
  int maxProgress = 0;
  int currentIndex = 0;
  bool isPaused = true;
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  CarouselController carouselController = CarouselController();

  /// load the audio from the demo audio list and notify the listener
  void loadAudio() {
    audioCache.loadAll(
        AudioData.allAudioData.map((element) => element.songUrl).toList());
    _eventListener();
  }

  /// event listener for audio state changed
  void _eventListener() {
    audioPlayer.onAudioPositionChanged.listen((event) {
      currentProgress = event.inSeconds;
      notifyListeners();
    });
    audioPlayer.onDurationChanged.listen((event) {
      maxProgress = event.inSeconds;
      notifyListeners();
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        isPaused = false;
      } else {
        isPaused = true;
      }
      notifyListeners();
    });
  }

  /// Callback for carousal page change.
  onCarousalPageChanged(int index, CarouselPageChangedReason reason) async {
    currentIndex = index;
    audioPlayer.play(audioCache
        .loadedFiles[AudioData.allAudioData[currentIndex].songUrl].path);
  }

  /// play and pause event handler
  void togglePlayPause() async {
    if (audioPlayer != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {
        audioPlayer.pause();
      } else if (audioPlayer.state == AudioPlayerState.PAUSED) {
        audioPlayer.resume();
      } else if (audioPlayer.state == AudioPlayerState.COMPLETED ||
          audioPlayer.state == null) {
        audioPlayer.play(audioCache
            .loadedFiles[AudioData.allAudioData[currentIndex].songUrl].path);
      }
    }
  }

  /// slider value change event handler
  void handleSliderValueChange(double value) {
    if (audioPlayer != null) {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    }
  }

  /// Convert seconds into minute:second format for start time
  String getCurrentProgressInMinuteAndSecond() {
    var dur = Duration(seconds: currentProgress);
    return Helper.getStringFromDuration(dur);
  }

  /// Convert seconds into minute:second format for length of the song
  String getMaxProgressInMinuteAndSecond() {
    var dur = Duration(seconds: maxProgress);
    return Helper.getStringFromDuration(dur);
  }
}
