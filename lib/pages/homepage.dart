// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybible/components/chooseBookBS.dart';
import 'package:mybible/components/chooseChapter.dart';
import 'package:mybible/components/eachVerse.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic content;
  String currentVersion = "ESV";
  String currentTestament = "OT";
  String currentBook = "GEN";
  int currentChapter = 1;
  int chapterLength = 0;
  bool isOT = true;

  Map abbrv = {
    "1CH": "1 Chronicles",
    "1KI": "1 Kings",
    "1SA": "1 Samuel",
    "2CH": "2 Chronicles",
    "2SA": "2 Samuel",
    "AMO": "Amos",
    "DAN": "Daniel",
    "DEU": "Deuteronomy",
    "ECC": "Ecclesiastes",
    "EST": "Esther",
    "EXO": "Exodus",
    "EZK": "Ezekiel",
    "EZR": "Ezra",
    "GEN": "Genesis",
    "HAB": "Habakkuk",
    "HAG": "Haggai",
    "HOS": "Hosea",
    "ISA": "Isaiah",
    "JDG": "Judges",
    "JER": "Jeremiah",
    "JOB": "Job",
    "JOL": "Joel",
    "JON": "Jonah",
    "JOS": "Joshua",
    "LAM": "Lamentations",
    "LEV": "Leviticus",
    "MAL": "Malachi",
    "MIC": "Micah",
    "NAH": "Nahum",
    "NAM": "Nehemiah",
    "NUM": "Numbers",
    "OBA": "Obadiah",
    "PRO": "Proverbs",
    "PSA": "Psalms",
    "RUT": "Ruth",
    "SNG": "Song of Solomon",
    "ZEC": "Zechariah",
    "ZEP": "Zephaniah",
    "1JN": "1 John",
    "1PE": "1 Peter",
    "1TH": "1 Thessalonians",
    "1TI": "1 Timothy",
    "2TI": "2 Timothy",
    "2JN": "2 John",
    "2PE": "2 Peter",
    "2TH": "2 Thessalonians",
    "3JN": "3 John",
    "ACT": "Acts",
    "COL": "Colossians",
    "EPH": "Ephesians",
    "GAL": "Galatians",
    "HEB": "Hebrews",
    "JAS": "James",
    "JHN": "John",
    "JUD": "Jude",
    "LKA": "Luke",
    "MAT": "Matthew",
    "MRK": "Mark",
    "PHM": "Philemon",
    "PHP": "Philippians",
    "REV": "Revelation",
    "ROM": "Romans",
    "TIT": "Titus",
  };

  void setContent(version, testament, book, chapter) async {
    currentVersion = version;
    currentTestament = testament;
    currentBook = book;
    currentChapter = chapter;

    var pathOfJSON = "assets/holybooks/EN/$testament/$book/$version.json";
    String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
    final jsonResult = jsonDecode(data);
    chapterLength = jsonResult["text"].length;
    content = jsonResult["text"][chapter]["text"];
    setState(() {});
  }

  void getBooks() async {}

  void showBooks() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseBookBS();
      },
    );
  }

  void showChapters() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseChapterBS();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getBibleVersions();
    // getBibleData();
    setContent("ESV", "OT", "GEN", 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[200],
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 20.0,
                ),
                content != null
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5.0,
                                left: 15.0,
                                right: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showBooks();
                                    },
                                    child: Text(
                                      "${abbrv[currentBook]} ${currentChapter + 1}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showChapters();
                                    },
                                    child: Text(
                                      "$currentVersion",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[700],
                            ),
                            for (var eachVerse in content)
                              EachVerse(
                                verseData: eachVerse,
                              ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       "${eachVerse["ID"]} ",
                            //       textAlign: TextAlign.left,
                            //       style: TextStyle(
                            //         fontSize: 10.0,
                            //         // color: Colors.red,
                            //       ),
                            //     ),
                            //     Text(
                            //       "${eachVerse["text"]}",
                            //       textAlign: TextAlign.left,
                            //       style: TextStyle(
                            //         // color: Colors.red,
                            //         fontSize: 15.0,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 200.0),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              backgroundColor: Colors.grey[800],
              mini: true,
              onPressed: () {
                if (currentChapter != 0) {
                  setContent(
                    currentVersion,
                    currentTestament,
                    currentBook,
                    currentChapter - 1,
                  );
                }
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.grey[800],
            mini: true,
            onPressed: () {
              if (currentChapter < chapterLength - 1) {
                setContent(
                  currentVersion,
                  currentTestament,
                  currentBook,
                  currentChapter + 1,
                );
              }
            },
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
