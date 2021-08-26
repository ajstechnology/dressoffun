import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempLists extends GetxController {
  static List<String> recentSearch = [
    'Calculate p4 profit',
    'UX design workshop',
    'Using medium for article',
    'EIN meaning',
  ];

  /*static List<String> stringTagsList = [
    'Politics',
    'Entertainment',
    'Movies',
    'Photos',
  ].obs;*/

  static Map<String, bool> stringTagsMap = {
      'Politics' : false,
      'Entertainment' : false,
      'Movies' : false,
      'Photos' : false,
  }.obs;

  static List<String> typeFilterLabels = [
    'Article',
    'Video',
    'Image',
  ];

  static List<Text> timeFilterLabels = [
    Text('Today'),
    Text('Last 7 Days'),
    Text('Last 30 Days'),
    Text('Last 90 Days'),
    Text('Last Year'),
    Text('Custom Date Range'),
  ];

  static List<String> graphBottomSheetTimeLines = [
    'Today',
    'Last 7 Days',
    'Last 30 Days',
    'Last 90 Days',
    'Last Year',
  ];


}
