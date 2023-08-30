// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mybible/models/savedVerses.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
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

  List savedVerses = [];
  void getSavedVerse() async {
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    var result = await savedVersesBox.get("savedVerses");
    if (result != null) {
      savedVerses = result;
    }
    await Hive.close();
    print(savedVerses);
    setState(() {});
  }

  void deleteAllBookmarks() async {
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    await savedVersesBox.clear();
    await Hive.close();
    savedVerses = [];
    setState(() {});
  }

  void deleteIndividualBookmark(SavedVerse currentBookmark) async {
    var newSavedVerses = [];
    for (SavedVerse eachSavedVerse in savedVerses) {
      if (eachSavedVerse.version == currentBookmark.version &&
          eachSavedVerse.book == currentBookmark.book &&
          eachSavedVerse.chapter == currentBookmark.chapter &&
          eachSavedVerse.number == currentBookmark.number) {
      } else {
        newSavedVerses.add(eachSavedVerse);
      }
    }
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    await savedVersesBox.put("savedVerses", newSavedVerses);
    await Hive.close();
    savedVerses = newSavedVerses;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSavedVerse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        title: Text(
          "Bookmarks",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: savedVerses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You have no saved verses!",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 30.0),
                    child: Text(
                      "Press and hold on a bible verse then click on the bookmark icon at the bottom of the screen to add to bookmarks.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 200.0),
                ],
              ),
            )
          : ListView(
              children: [
                Column(
                  children: [
                    for (var eachSavedVerse in savedVerses)
                      GestureDetector(
                        onLongPress: () {
                          deleteIndividualBookmark(eachSavedVerse);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 10.0,
                          ),
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 12.0,
                            left: 12.0,
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 26, 26, 26),
                            // border: Border(
                            //   left: BorderSide(
                            //     color: Colors.greenAccent,
                            //     width: 1.0,
                            //   ),
                            // ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1.0,
                                offset: Offset(3, 4),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  eachSavedVerse.version == "አማ"
                                      ? Row(
                                          children: [
                                            Text(
                                              eachSavedVerse.book + " ",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            Text(
                                              "${eachSavedVerse.chapter}:${eachSavedVerse.number}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          abbrv[eachSavedVerse.book] +
                                              " " +
                                              eachSavedVerse.chapter
                                                  .toString() +
                                              ":" +
                                              eachSavedVerse.number.toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                  Text(
                                    eachSavedVerse.version,
                                    style: TextStyle(
                                      color: Colors.grey[600]!,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                eachSavedVerse.verse,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    "Long press on individual bookmarks to delete individually.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                SizedBox(height: 250.0),
                GestureDetector(
                  onLongPress: () {
                    deleteAllBookmarks();
                  },
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.redAccent,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        "Delete All",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          "Long press the delete icon to delete all bookmarks.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
    );
  }
}
