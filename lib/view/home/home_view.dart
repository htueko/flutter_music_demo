import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_demo/service/audio_service.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      DotsIndicator(
                        dotsCount: AudioData.allAudioData.length,
                        position: model.currentIndex.toDouble(),
                        decorator: DotsDecorator(
                          size: const Size.square(10.0),
                          activeSize: const Size(16.0, 16.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          initialPage: 1,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: model.onCarousalPageChanged,
                        ),
                        itemCount: AudioData.allAudioData.length,
                        itemBuilder: (BuildContext context, int itemIndex) =>
                            Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                              AudioData.allAudioData[itemIndex].imageUrl),
                        ),
                        carouselController: model.carouselController,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AudioData.allAudioData[model.currentIndex].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AudioData.allAudioData[model.currentIndex].singer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Image.asset('assets/icon/ic_previous.png'),
                        onTap: () {
                          model.carouselController.previousPage();
                        },
                      ),
                      InkWell(
                        child: (model.isPaused)
                            ? Image.asset('assets/icon/ic_play.png')
                            : Image.asset('assets/icon/ic_pause.png'),
                        onTap: () {
                          model.togglePlayPause();
                        },
                      ),
                      InkWell(
                        child: Image.asset('assets/icon/ic_next.png'),
                        onTap: () {
                          model.carouselController.nextPage();
                        },
                      ),
                    ],
                  ),
                  Slider(
                    value: model.currentProgress.toDouble(),
                    max: model.maxProgress.toDouble(),
                    onChanged: model.handleSliderValueChange,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.getCurrentProgressInMinuteAndSecond(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                        Text(
                          model.getMaxProgressInMinuteAndSecond(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
