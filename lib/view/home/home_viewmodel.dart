import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_music_demo/service/audio_service.dart';
import 'package:flutter_music_demo/util/helper.dart';
import 'package:flutter_music_demo/util/logger_printer.dart';
import 'package:stacked/stacked.dart';

// to get the name of the class
String className = (HomeViewModel).toString();

class HomeViewModel extends BaseViewModel {
  // get the logger
  final _logger = getLogger(className);

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
    _logger.i('loading the audio files');
    audioCache.loadAll(
        AudioData.allAudioData.map((element) => element.songUrl).toList());
    _eventListener();
  }

  /// event listener for audio state changed
  void _eventListener() {
    _logger.i('attach the event listener');
    audioPlayer.onAudioPositionChanged.listen((event) {
      currentProgress = event.inSeconds;
      _logger.i('current song progress: $currentProgress');
      notifyListeners();
    });
    audioPlayer.onDurationChanged.listen((event) {
      maxProgress = event.inSeconds;
      _logger.i('current song max progress: $maxProgress');
      notifyListeners();
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        isPaused = false;
        _logger.i('song is playing: $isPaused');
      } else {
        isPaused = true;
        _logger.i('song is playing: $isPaused');
      }
      notifyListeners();
    });
  }

  /// Callback for carousal page change.
  onCarousalPageChanged(int index, CarouselPageChangedReason reason) async {
    currentIndex = index;
    _logger.i(
        'Currently playing song: ${AudioData.allAudioData[currentIndex].title}');
    audioPlayer.play(audioCache
        .loadedFiles[AudioData.allAudioData[currentIndex].songUrl].path);
  }

  /// play and pause event handler
  void togglePlayPause() async {
    if (audioPlayer != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {
        audioPlayer.pause();
        _logger.i('Song state: pause');
      } else if (audioPlayer.state == AudioPlayerState.PAUSED) {
        _logger.i('Song state: resume');
        audioPlayer.resume();
      } else if (audioPlayer.state == AudioPlayerState.COMPLETED ||
          audioPlayer.state == null) {
        _logger.i('Song state: completed');
        audioPlayer.play(audioCache
            .loadedFiles[AudioData.allAudioData[currentIndex].songUrl].path);
      }
    }
  }

  /// slider value change event handler
  void handleSliderValueChange(double value) {
    _logger.i('Song Progress Indicator Change: $value');
    if (audioPlayer != null) {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    }
  }

  /// Convert seconds into minute:second format for start time
  String getCurrentProgressInMinuteAndSecond() {
    Duration duration = Duration(seconds: currentProgress);
    _logger.i(
        'Current time of the song: ${Helper.getStringFromDuration(duration)}');
    return Helper.getStringFromDuration(duration);
  }

  /// Convert seconds into minute:second format for length of the song
  String getMaxProgressInMinuteAndSecond() {
    Duration duration = Duration(seconds: maxProgress);
    _logger.i(
        'Current max time of the song: ${Helper.getStringFromDuration(
            duration)}');
    return Helper.getStringFromDuration(duration);
  }
}
