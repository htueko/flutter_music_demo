import 'package:flutter_music_demo/service/audio_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServiceModule {
  @lazySingleton
  AudioService get audioService;
}
