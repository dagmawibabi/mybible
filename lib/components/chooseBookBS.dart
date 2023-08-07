// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mybible/components/eachBookButton.dart';
import 'package:mybible/components/eachTestament.dart';

class ChooseBookBS extends StatefulWidget {
  const ChooseBookBS({
    super.key,
    required this.setTestamentAndBook,
    required this.englishToAmharicMap,
    required this.isAmharic,
  });

  final Function setTestamentAndBook;
  final Map englishToAmharicMap;
  final bool isAmharic;

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
        padding: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(top: 2.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey[900]!,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: Text(
                    widget.isAmharic == true ? "መፅሀፍቶች" : "Books",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isOT = true;
                          setState(() {});
                        },
                        child: EachTestament(
                          testament: widget.isAmharic == true
                              ? "ብሉይ ኪዳን"
                              : "Old Testament",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isOT = false;
                          setState(() {});
                        },
                        child: EachTestament(
                          testament: widget.isAmharic == true
                              ? "አዲስ ኪዳን"
                              : "New Testament",
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.54,
                  padding: EdgeInsets.only(
                    top: 5.0,
                    bottom: 15.0,
                    // left: 15.0,
                    // right: 15.0,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 0.0,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    children: [
                      for (var eachBook in (isOT == true ? otBooks : ntBooks))
                        GestureDetector(
                          onTap: () {
                            String otORnt = isOT == true ? "OT" : "NT";
                            widget.setTestamentAndBook(otORnt, eachBook);
                            setState(() {});
                          },
                          child: EachBookButton(
                            isAmharic: widget.isAmharic,
                            book: widget.isAmharic == true
                                ? widget.englishToAmharicMap[eachBook]
                                    .toString()
                                    .substring(
                                      3,
                                      widget.englishToAmharicMap[eachBook]
                                              .length -
                                          5,
                                    )
                                : eachBook,
                          ),
                        )
                    ],
                  ),
                ),
                // SizedBox(height: 100.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
