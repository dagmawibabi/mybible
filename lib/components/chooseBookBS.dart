// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mybible/components/eachBookButton.dart';
import 'package:mybible/components/eachTestament.dart';

class ChooseBookBS extends StatefulWidget {
  const ChooseBookBS({
    super.key,
    required this.setTestamentAndBook,
    required this.englishToAmharicMap,
    required this.currentBook,
    required this.currentTestament,
  });

  final Function setTestamentAndBook;
  final Map englishToAmharicMap;
  final String currentBook;
  final String currentTestament;

  @override
  State<ChooseBookBS> createState() => _ChooseBookBSState();
}

class _ChooseBookBSState extends State<ChooseBookBS> {
  bool isOT = true;

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

  Map abbrv = {
    "GEN": "Genesis",
    "EXO": "Exodus",
    "LEV": "Leviticus",
    "NUM": "Numbers",
    "DEU": "Deuteronomy",
    "JOS": "Joshua",
    "JDG": "Judges",
    "RUT": "Ruth",
    "1SA": "1 Samuel",
    "2SA": "2 Samuel",
    "1KI": "1 Kings",
    "2KI": "2 Kings",
    "1CH": "1 Chronicles",
    "2CH": "2 Chronicles",
    "EZR": "Ezra",
    "NAM": "Nehemiah",
    "EST": "Esther",
    "JOB": "Job",
    "PSA": "Psalms",
    "PRO": "Proverbs",
    "ECC": "Ecclesiastes",
    "SNG": "Song of Solomon",
    "ISA": "Isaiah",
    "JER": "Jeremiah",
    "LAM": "Lamentations",
    "EZK": "Ezekiel",
    "DAN": "Daniel",
    "HOS": "Hosea",
    "JOL": "Joel",
    "AMO": "Amos",
    "OBA": "Obadiah",
    "JON": "Jonah",
    "MIC": "Micah",
    "NAH": "Nahum",
    "HAB": "Habakkuk",
    "ZEP": "Zephaniah",
    "HAG": "Haggai",
    "ZEC": "Zechariah",
    "MAL": "Malachi",
    "MAT": "Matthew",
    "MRK": "Mark",
    "LUK": "Luke",
    "JHN": "John",
    "ACT": "Acts",
    "ROM": "Romans",
    "1CO": "1 Corinthians",
    "2CO": "2 Corinthians",
    "GAL": "Galatians",
    "EPH": "Ephesians",
    "PHP": "Philippians",
    "COL": "Colossians",
    "1TH": "1 Thessalonians",
    "2TH": "2 Thessalonians",
    "1TI": "1 Timothy",
    "2TI": "2 Timothy",
    "TIT": "Titus",
    "PHM": "Philemon",
    "HEB": "Hebrews",
    "JAS": "James",
    "1PE": "1 Peter",
    "2PE": "2 Peter",
    "1JN": "1 John",
    "2JN": "2 John",
    "3JN": "3 John",
    "JUD": "Jude",
    "REV": "Revelation",
  };

  String selectedTestament = "Old Testament";

  void setSelectedTestament(String testament) {
    isOT = !isOT;
    selectedTestament = testament;
    isOT = testament == "Old Testament" ? true : false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isOT = widget.currentTestament == "OT" ? true : false;
    selectedTestament =
        widget.currentTestament == "OT" ? "Old Testament" : "New Testament";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 10.0),
        margin: const EdgeInsets.only(top: 2.0),
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 19, 19, 19),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Books",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "  |  ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[800]!,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "መጽሐፍት",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isOT = true;
                            setState(() {});
                          },
                          child: EachTestament(
                            english: "Old Testament",
                            amharic: "ብሉይ ኪዳን",
                            selectedTestament: selectedTestament,
                            setSelectedTestament: setSelectedTestament,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            isOT = false;
                            setState(() {});
                          },
                          child: EachTestament(
                            english: "New Testament",
                            amharic: "አዲስ ኪዳን",
                            selectedTestament: selectedTestament,
                            setSelectedTestament: setSelectedTestament,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                ),

                // Each Book
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 15.0,
                    // left: 15.0,
                    // right: 15.0,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                  ),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          for (var eachBook
                              in (isOT == true ? otBooks : ntBooks))
                            GestureDetector(
                              onTap: () {
                                String otORnt = isOT == true ? "OT" : "NT";
                                widget.setTestamentAndBook(otORnt, eachBook);
                                setState(() {});
                              },
                              child: EachBookButton(
                                isSelected:
                                    eachBook == abbrv[widget.currentBook]
                                        ? true
                                        : false,
                                english: eachBook,
                                amharic: widget.englishToAmharicMap[eachBook]
                                    .toString()
                                    .substring(
                                      3,
                                      widget.englishToAmharicMap[eachBook]
                                              .length -
                                          5,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
