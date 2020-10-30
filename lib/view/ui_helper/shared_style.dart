import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

/// Progress Dot Decoration
DotsDecorator dotSDecoration = DotsDecorator(
  size: const Size.square(10.0),
  activeSize: const Size(16.0, 16.0),
  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
);

/// Song Title Text Style
TextStyle titleTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24);

/// Song Vocalist Text Style
TextStyle singerTextStyle =
    TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 16);

/// Song Minutes And Second Text Style
TextStyle timeTextStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 12);
