// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mybible/components/eachBookButton.dart';
import 'package:mybible/components/eachTestament.dart';

class ChooseBookBS extends StatefulWidget {
  const ChooseBookBS({
    super.key,
    required this.setTestamentAndBook,
  });

  final Function setTestamentAndBook;

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
      margin: EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey[900]!,
          borderRadius: BorderRadius.circular(20.0),
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
                    "Books",
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
                    children: const [
                      EachTestament(
                        testament: "Old Testament",
                      ),
                      EachTestament(
                        testament: "New Testament",
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     isOT = true;
                      //     setState(() {});
                      //   },
                      //   child: Text(
                      //     "Old Testament",
                      //   ),
                      // ),
                      // SizedBox(width: 10.0),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     isOT = false;
                      //     setState(() {});
                      //   },
                      //   child: Text(
                      //     "New Testament",
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                ),
                // for (var eachBook in (isOT == true ? otBooks : ntBooks))
                //   GestureDetector(
                //     onTap: () {
                //       String otORnt = isOT == true ? "OT" : "NT";
                //       widget.setTestamentAndBook(otORnt, eachBook);
                //       setState(() {});
                //     },
                //     child: EachBookButton(book: eachBook),
                //   ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                            book: eachBook,
                          ),

                          //           //     Container(
                          //           //   decoration: BoxDecoration(
                          //           //     color: Colors.blue,
                          //           //     borderRadius: BorderRadius.circular(10.0),
                          //           //   ),
                          //           //   child: Center(
                          //           //     child: Text(
                          //           //       eachBook,
                          //           //       style: TextStyle(
                          //           //         color: Colors.white,
                          //           //       ),
                          //           //     ),
                          //           //   ),
                          //           // ),
                        )
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
