// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

class ChooseBookBS extends StatefulWidget {
  const ChooseBookBS({
    super.key,
    required this.setContent,
  });

  final Function setContent;

  @override
  State<ChooseBookBS> createState() => _ChooseBookBSState();
}

class _ChooseBookBSState extends State<ChooseBookBS> {
  List otBooks = [
    "Genesis",
    "Exodus",
    "Leviticus",
    "Numbers",
    "Deuteronomy",
    "Joshua",
    "Judges",
    "Ruth",
    "1 Samuel",
    "2 Samuel",
    "1 Kings",
    "2 Kings",
    "1 Chronicles",
    "2 Chronicles",
    "Ezra",
    "Nehemiah",
    "Esther",
    "Job",
    "Psalms",
    "Proverbs",
    "Ecclesiastes",
    "Song of Solomon",
    "Isaiah",
    "Jeremiah",
    "Lamentations",
    "Ezekiel",
    "Daniel",
    "Hosea",
    "Joel",
    "Amos",
    "Obadiah",
    "Jonah",
    "Micah",
    "Nahum",
    "Habakkuk",
    "Zephaniah",
    "Haggai",
    "Zechariah",
    "Malachi",
  ];

  List ntBooks = [
    "Matthew",
    "Mark",
    "Luke",
    "John",
    "Acts",
    "Romans",
    "1 Corinthians",
    "2 Corinthians",
    "Galatians",
    "Ephesians",
    "Philippians",
    "Colossians",
    "1 Thessalonians",
    "2 Thessalonians",
    "1 Timothy",
    "2 Timothy",
    "Titus",
    "Philemon",
    "Hebrews",
    "James",
    "1 Peter",
    "2 Peter",
    "1 John",
    "2 John",
    "3 John",
    "Jude",
    "Revelation",
  ];

  String chosenVersion = "ESV";
  List currentTestament = [];

  String chosenBook = "";
  String chosenBookReadable = "";

  Map abbrv = {
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

  bool listChapters = false;

  List chapterLength = [];

  int chosenChapter = 0;

  String otORnt = "OT";

  void getChapters() async {
    otORnt = currentTestament == otBooks ? "OT" : "NT";
    String data = await DefaultAssetBundle.of(context).loadString(
        "assets/holybooks/EN/$otORnt/$chosenBook/$chosenVersion.json");
    final jsonResult = jsonDecode(data);
    print(jsonResult);
    chapterLength = [];
    for (var i = 0; i < jsonResult["text"].length; i++) {
      chapterLength.add(i + 1);
    }
    listChapters = true;
    setState(() {});
  }

  dynamic bibleVersionsInfo;
  void getBibleVersions() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/holybooks/EN/index.json");
    final jsonResult = jsonDecode(data);
    bibleVersionsInfo = jsonResult["versions"];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTestament = otBooks;
    getBibleVersions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey[900]!,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListView(
          primary: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    "Versions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                bibleVersionsInfo != null
                    ? Container(
                        // color: Colors.red,
                        height: 95,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        width: double.infinity,
                        child: GridView.count(
                          crossAxisCount: 4,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          children: [
                            for (var eachVersion in bibleVersionsInfo)
                              ElevatedButton(
                                onPressed: () {
                                  chosenVersion = eachVersion["ID"];
                                  setState(() {});
                                  // Navigator.pop(context);
                                },
                                child: Text(eachVersion["ID"]),
                              ),
                          ],
                        ),
                      )
                    : Container(),
                Divider(
                  color: Colors.white,
                  indent: 15.0,
                  endIndent: 15.0,
                  height: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Text(
                    "Testaments",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          currentTestament = otBooks;
                          listChapters = false;
                          setState(() {});
                        },
                        child: Text("Old Testament"),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          currentTestament = ntBooks;
                          listChapters = false;
                          setState(() {});
                        },
                        child: Text("New Testament"),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                  child: Text(
                    listChapters == false ? "Books" : chosenBookReadable,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                listChapters == false
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 3.0,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          children: [
                            for (var eachBook in currentTestament)
                              GestureDetector(
                                onTap: () {
                                  chosenBook = abbrv[eachBook];
                                  chosenBookReadable = eachBook;
                                  getChapters();
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      eachBook,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: GridView.count(
                          crossAxisCount: 8,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          children: [
                            for (var eachChapter in chapterLength)
                              GestureDetector(
                                onTap: () {
                                  chosenChapter = eachChapter - 1;
                                  widget.setContent(chosenVersion, otORnt,
                                      chosenBook, chosenChapter);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      eachChapter.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
              ],
            ),
            Divider(
              color: Colors.white,
              indent: 15.0,
              endIndent: 15.0,
            ),
            SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }
}
