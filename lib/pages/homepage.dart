// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybible/components/chooseBookBS.dart';
import 'package:mybible/components/chooseChapterBS.dart';
import 'package:mybible/components/chooseVersionBS.dart';
import 'package:mybible/components/differentVersionBS.dart';
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
  bool showComments = true;

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

  Map revAbbrv = {
    "1 Chronicles": "1CH",
    "1 Kings": "1KI",
    "1 Samuel": "1SA",
    "2 Chronicles": "2CH",
    "2 Samuel": "2SA",
    "Amos": "AMO",
    "Daniel": "DAN",
    "Deuteronomy": "DEU",
    "Ecclesiastes": "ECC",
    "Esther": "EST",
    "Exodus": "EXO",
    "Ezekiel": "EZK",
    "Ezra": "EZR",
    "Genesis": "GEN",
    "Habakkuk": "HAB",
    "Haggai": "HAG",
    "Hosea": "HOS",
    "Isaiah": "ISA",
    "Judges": "JDG",
    "Jeremiah": "JER",
    "Job": "JOB",
    "Joel": "JOL",
    "Jonah": "JON",
    "Joshua": "JOS",
    "Lamentations": "LAM",
    "Leviticus": "LEV",
    "Malachi": "MAL",
    "Micah": "MIC",
    "Nahum": "NAH",
    "Nehemiah": "NAM",
    "Numbers": "NUM",
    "Obadiah": "OBA",
    "Proverbs": "PRO",
    "Psalms": "PSA",
    "Ruth": "RUT",
    "Song of Solomon": "SNG",
    "Zechariah": "ZEC",
    "Zephaniah": "ZEP",
    "1 John": "1JN",
    "1 Peter": "1PE",
    "1 Thessalonians": "1TH",
    "1 Timothy": "1TI",
    "2 Timothy": "2TI",
    "2 John": "2JN",
    "2 Peter": "2PE",
    "2 Thessalonians": "2TH",
    "3 John": "3JN",
    "Acts": "ACT",
    "Colossians": "COL",
    "Ephesians": "EPH",
    "Galatians": "GAL",
    "Hebrews": "HEB",
    "James": "JAS",
    "John": "JHN",
    "Jude": "JUD",
    "Luke": "LKA",
    "Matthew": "MAT",
    "Mark": "MRK",
    "Philemon": "PHM",
    "Philippians": "PHP",
    "Revelation": "REV",
    "Romans": "ROM",
    "Titus": "TIT",
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
    content = jsonResult["text"][chapter - 1]["text"];
    setState(() {});
  }

  void setTestamentAndBook(testament, book) async {
    currentTestament = testament;
    currentBook = book;
    setContent(currentVersion, currentTestament, revAbbrv[book], 1);
    Navigator.pop(context);
    showChapters();
    setState(() {});
  }

  void setChapter(chapter) async {
    currentChapter = chapter;
    setContent(currentVersion, currentTestament, currentBook, chapter);
    setState(() {});
  }

  void setVersion(version) async {
    currentVersion = version;
    setContent(currentVersion, currentTestament, currentBook, currentChapter);
    setState(() {});
  }

  void showBooks() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseBookBS(
          setTestamentAndBook: setTestamentAndBook,
        );
      },
    );
  }

  void showChapters() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseChapterBS(
          otORnt: currentTestament,
          chosenBook: currentBook,
          chosenVersion: currentVersion,
          setChapter: setChapter,
        );
      },
    );
  }

  void showVersions() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseVersionBS(
          setVersion: setVersion,
        );
      },
    );
  }

  void showDifferentVersions(currentVerse) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return DifferentVersions(
          testament: currentTestament,
          book: currentBook,
          chapter: currentChapter,
          verse: currentVerse,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setContent("ESV", "OT", "GEN", 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
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
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showBooks();
                                        },
                                        child: Text(
                                          "${abbrv[currentBook]} ",
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
                                          " $currentChapter",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      currentVersion == "ERV"
                                          ? IconButton(
                                              onPressed: () {
                                                showComments = !showComments;
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                showComments == true
                                                    ? Icons
                                                        .comments_disabled_outlined
                                                    : Icons
                                                        .insert_comment_outlined,
                                                color: Colors.grey[700]!,
                                              ),
                                            )
                                          : Container(
                                              height: 50.0,
                                              color: Colors.red,
                                            ),
                                      GestureDetector(
                                        onTap: () {
                                          showVersions();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 10.0),
                                          child: Text(
                                            currentVersion,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[700],
                            ),
                            for (var eachVerse in content)
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDifferentVersions(
                                        int.parse(eachVerse["ID"]),
                                      );
                                    },
                                    child: EachVerse(
                                      verseData: eachVerse,
                                    ),
                                  ),
                                  currentVersion == "ERV" &&
                                          showComments == true
                                      ? eachVerse["comments"] != null
                                          ? Column(
                                              children: [
                                                for (var eachComment
                                                    in eachVerse["comments"])
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 30.0,
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: Text(
                                                      eachComment,
                                                      style: TextStyle(
                                                        color:
                                                            Colors.grey[600]!,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            )
                                          : Container()
                                      : Container(),
                                ],
                              ),
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
          currentChapter - 1 >= 1
              ? Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey[800],
                    mini: true,
                    onPressed: () {
                      if (currentChapter - 1 >= 1) {
                        currentChapter -= 1;
                        setContent(
                          currentVersion,
                          currentTestament,
                          currentBook,
                          currentChapter,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(height: 1.0),
          currentChapter + 1 <= chapterLength
              ? FloatingActionButton(
                  backgroundColor: Colors.grey[800],
                  mini: true,
                  onPressed: () {
                    if (currentChapter + 1 <= chapterLength) {
                      currentChapter += 1;
                      setContent(
                        currentVersion,
                        currentTestament,
                        currentBook,
                        currentChapter,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              : Container(height: 1.0)
        ],
      ),
    );
  }
}
