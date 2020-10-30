import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_demo/service/audio_service.dart';
import 'package:flutter_music_demo/view/ui_helper/shared_style.dart';
import 'package:flutter_music_demo/view/ui_helper/shared_widget.dart';
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
                      /// Progress Dots Widget
                      DotsIndicator(
                        dotsCount: AudioData.allAudioData.length,
                        position: model.currentIndex.toDouble(),
                        decorator: dotSDecoration,
                      ),
                      verticalSpaceSmall,

                      /// Image Slider with Slide function Widget
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Image.asset(
                                  AudioData.allAudioData[itemIndex].imageUrl),
                            ),
                        carouselController: model.carouselController,
                      ),
                      verticalSpaceSmall,

                      /// Song Title Text Widget
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AudioData.allAudioData[model.currentIndex].title,
                          textAlign: TextAlign.center,
                          style: titleTextStyle,
                        ),
                      ),

                      /// Song Vocalist Text Widget
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AudioData.allAudioData[model.currentIndex].singer,
                          textAlign: TextAlign.center,
                          style: singerTextStyle,
                        ),
                      ),
                    ],
                  ),

                  /// Control Group Widget (previous, play/pause, next)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// Previous Image Widget
                      InkWell(
                        child: Image.asset('assets/icon/ic_previous.png'),
                        onTap: () {
                          model.carouselController.previousPage();
                        },
                      ),

                      /// Play/Pause Image Widget
                      InkWell(
                        child: (model.isPaused)
                            ? Image.asset('assets/icon/ic_play.png')
                            : Image.asset('assets/icon/ic_pause.png'),
                        onTap: () {
                          model.togglePlayPause();
                        },
                      ),

                      /// Next Image Widget
                      InkWell(
                        child: Image.asset('assets/icon/ic_next.png'),
                        onTap: () {
                          model.carouselController.nextPage();
                        },
                      ),
                    ],
                  ),

                  /// Progress Indicator and Time Widget Group
                  Column(
                    children: [

                      /// Song Progress Widget
                      Slider(
                        value: model.currentProgress.toDouble(),
                        max: model.maxProgress.toDouble(),
                        onChanged: model.handleSliderValueChange,
                        activeColor: Colors.black87,
                        inactiveColor: Colors.black38,
                      ),

                      /// Song Start Minute and Second and Song Total Minute and Second Widget
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.getCurrentProgressInMinuteAndSecond(),
                              textAlign: TextAlign.center,
                              style: timeTextStyle,
                            ),
                            Text(
                              model.getMaxProgressInMinuteAndSecond(),
                              textAlign: TextAlign.center,
                              style: timeTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
