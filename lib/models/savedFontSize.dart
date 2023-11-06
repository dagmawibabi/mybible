// ignore_for_file: file_names

import 'package:hive/hive.dart';

part 'savedFontSize.g.dart';

@HiveType(typeId: 1)
class SavedFontSize extends HiveObject {
  @HiveField(0)
  late double eachVerseFontSize;
  @HiveField(1)
  late double eachNumberFontSize;
  @HiveField(2)
  late double eachCommentFontSize;
  @HiveField(3)
  late double eachTopicFontSize;
}
