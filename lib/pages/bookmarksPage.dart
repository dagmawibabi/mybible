// ignore_for_file: file_names

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mybible/models/savedVerses.dart';
import 'package:flip_card/flip_card.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  bool isMemorizing = false;
  Controller scrollController = Controller();
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
    setState(() {});
  }

  void deleteAllBookmarks() async {
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    await savedVersesBox.delete("savedVerses");
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

  void copyAllBookmarks() async {
    var copyableText = "";
    for (var eachBookmark in savedVerses) {
      print(eachBookmark.version);
      if (eachBookmark.version == "አማ 1954") {
        copyableText += eachBookmark.book +
            " " +
            eachBookmark.chapter.toString() +
            ":" +
            eachBookmark.number.toString() +
            " (አማ 1954)\n\"" +
            eachBookmark.verse +
            "\"\n\n";
      } else {
        copyableText += abbrv[eachBookmark.book] +
            " " +
            eachBookmark.chapter.toString() +
            ":" +
            eachBookmark.number.toString() +
            " (" +
            eachBookmark.version +
            ")\n\"" +
            eachBookmark.verse +
            "\"\n\n";
      }
    }

    if (copyableText == "") {
      Fluttertoast.showToast(
        msg: "No Bookmarked Verses To Copy",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    await FlutterClipboard.copy(copyableText).then(
      (value) {},
    );
    Fluttertoast.showToast(
      msg: "All Bookmarked Verses Copied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
          isMemorizing == true ? "Memorize" : "Bookmarks",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          isMemorizing == true
              ? Container()
              : IconButton(
                  onPressed: () {
                    copyAllBookmarks();
                  },
                  icon: const Icon(
                    Icons.copy_all_outlined,
                  ),
                ),
          IconButton(
            icon: isMemorizing == true
                ? const Icon(Icons.bookmark_border_rounded)
                : const Icon(
                    LineIcons.brain,
                  ),
            onPressed: () {
              isMemorizing = !isMemorizing;
              setState(() {});
            },
          ),
        ],
      ),
      body: savedVerses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isMemorizing == true
                        ? "You have no saved verses to memorize!"
                        : "You have no saved verses!",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
                    child: Text(
                      "Press and hold on a bible verse then click on the bookmark icon at the bottom of the screen to add to bookmarks.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 200.0),
                ],
              ),
            )
          : isMemorizing == true
              ? TikTokStyleFullPageScroller(
                  controller: scrollController,
                  contentSize: savedVerses.length,
                  swipePositionThreshold: 0.2,
                  swipeVelocityThreshold: 2000,
                  animationDuration: const Duration(
                    milliseconds: 400,
                  ),
                  builder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey[900]!,
                      child: FlipCard(
                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL,
                        side: CardSide.FRONT,
                        front: Column(
                          children: [
                            Container(
                              height: 400.0,
                              margin: const EdgeInsets.only(
                                left: 20.0,
                                right: 15.0,
                                top: 120.0,
                                bottom: 220.0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 15.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 26, 26, 26),
                                border: Border.all(
                                  color: Colors.grey[850]!,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 1.0,
                                    offset: Offset(4, 5),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Text(
                                    savedVerses[index].verse,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.2,
                                    ),
                                  ),
                                  Text(
                                    "Click to know location of verse",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[700]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Swipe up for the next verse to memorize",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[700]!,
                              ),
                            ),
                          ],
                        ),
                        back: Container(
                          margin: const EdgeInsets.only(
                            left: 20.0,
                            right: 15.0,
                            top: 120.0,
                            bottom: 250.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 26, 26, 26),
                            border: Border.all(
                              color: Colors.grey[850]!,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1.0,
                                offset: Offset(4, 5),
                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  savedVerses[index].version == "አማ 1954"
                                      ? "አማ 1954"
                                      : savedVerses[index].version,
                                  style: TextStyle(
                                    color: Colors.grey[500]!,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                savedVerses[index].version == "አማ 1954"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            savedVerses[index].book + " ",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          Text(
                                            "${savedVerses[index].chapter}:${savedVerses[index].number}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        abbrv[savedVerses[index].book] +
                                            " " +
                                            savedVerses[index]
                                                .chapter
                                                .toString() +
                                            ":" +
                                            savedVerses[index]
                                                .number
                                                .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                const SizedBox(height: 40.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : ListView(
                  children: [
                    Column(
                      children: [
                        for (var eachSavedVerse in savedVerses)
                          GestureDetector(
                            onTap: () async {
                              var copyableText =
                                  "\"${eachSavedVerse.verse}\"\n — ${eachSavedVerse.version == "አማ 1954" ? eachSavedVerse.book : abbrv[eachSavedVerse.book]} ${eachSavedVerse.chapter}:${eachSavedVerse.number} (${eachSavedVerse.version == "አማ" ? "አማ (1954" : eachSavedVerse.version})";
                              await FlutterClipboard.copy(copyableText).then(
                                (value) {},
                              );
                              Fluttertoast.showToast(
                                msg: "Bookmarked Verse Copied",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            onLongPress: () {
                              deleteIndividualBookmark(eachSavedVerse);
                              Fluttertoast.showToast(
                                msg: "Bookmarked Verse Deleted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 10.0,
                              ),
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 14.0,
                                left: 14.0,
                                right: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 26, 26, 26),
                                border: Border.all(
                                  color: Colors.grey[850]!,
                                ),
                                borderRadius: const BorderRadius.all(
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
                                      eachSavedVerse.version == "አማ 1954"
                                          ? Row(
                                              children: [
                                                Text(
                                                  eachSavedVerse.book + " ",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                Text(
                                                  "${eachSavedVerse.chapter}:${eachSavedVerse.number}",
                                                  style: const TextStyle(
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
                                                  eachSavedVerse.number
                                                      .toString(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                      Text(
                                        eachSavedVerse.version == "አማ 1954"
                                            ? "አማ 1954"
                                            : eachSavedVerse.version,
                                        style: TextStyle(
                                          color: Colors.grey[600]!,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    eachSavedVerse.verse,
                                    style: const TextStyle(
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
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        "Tap on individual bookmarks to copy.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[700]!,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 0.0,
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
                    const SizedBox(height: 250.0),
                    GestureDetector(
                      onLongPress: () {
                        deleteAllBookmarks();
                        Fluttertoast.showToast(
                          msg: "All Bookmarks Deleted",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.redAccent,
                              size: 30.0,
                            ),
                          ),
                          const Text(
                            "Delete All",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 100.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              "Long press the delete icon to delete all bookmarks",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[700]!,
                                fontSize: 14.0,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
    );
  }
}
