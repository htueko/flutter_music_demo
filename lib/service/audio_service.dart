import 'package:flutter_music_demo/model/audio_model.dart';

/// service class for background service for future dev
class AudioService {}

// Raw data to test
mixin AudioData {
  static final allAudioData = [
    AudioFile(
        title: 'Creative',
        songUrl: "audio/creative.mp3",
        singer: 'Ben',
        imageUrl: "assets/icon/music_note.png"),
    AudioFile(
        title: 'Cute',
        songUrl: "audio/cute.mp3",
        singer: 'Tom',
        imageUrl: "assets/icon/music_note.png"),
    AudioFile(
        title: 'Hey',
        songUrl: "audio/hey.mp3",
        singer: 'Jerry',
        imageUrl: "assets/icon/music_note.png"),
    AudioFile(
        title: 'A New Beginning',
        songUrl: "audio/begin.mp3",
        singer: 'Hello Kitty',
        imageUrl: "assets/icon/music_note.png"),
    AudioFile(
        title: 'Summer Breeze',
        songUrl: "audio/breeze.mp3",
        singer: 'South Wind',
        imageUrl: "assets/icon/music_note.png"),
    AudioFile(
        title: 'Ukulele',
        songUrl: "audio/ukulele.mp3",
        singer: 'Mother Earth',
        imageUrl: "assets/icon/music_note.png"),
  ];
}
