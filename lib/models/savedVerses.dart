// ignore_for_file: file_names

import 'package:hive/hive.dart';

part 'savedVerses.g.dart';

@HiveType(typeId: 0)
class SavedVerse extends HiveObject {
  @HiveField(0)
  late String version;
  @HiveField(1)
  late String testament;
  @HiveField(2)
  late String book;
  @HiveField(3)
  late int chapter;
  @HiveField(4)
  late int number;
  @HiveField(5)
  late String verse;
}
