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

  List ervTitle = [];

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
    ervTitle = jsonResult["text"];
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

  List otBooksAM = [
    "01_ኦሪት ዘፍጥረት.json",
    "02_ኦሪት ዘጸአት.json",
    "03_ኦሪት ዘሌዋውያን.json",
    "04_ኦሪት ዘኍልቍ.json",
    "05_ኦሪት ዘዳግም.json",
    "06_መጽሐፈ ኢያሱ ወልደ ነዌ.json",
    "07_መጽሐፈ መሣፍንት.json",
    "08_መጽሐፈ ሩት.json",
    "09_መጽሐፈ ሳሙኤል ቀዳማዊ.json",
    "10_መጽሐፈ ሳሙኤል ካል.json",
    "11_መጽሐፈ ነገሥት ቀዳማዊ።.json",
    "12_መጽሐፈ ነገሥት ካልዕ።.json",
    "13_መጽሐፈ ዜና መዋዕል ቀዳማዊ።.json",
    "14_መጽሐፈ ዜና መዋዕል ካልዕ።.json",
    "15_መጽሐፈ ዕዝራ።.json",
    "16_መጽሐፈ ነህምያ።.json",
    "17_መጽሐፈ አስቴር።.json",
    "18_መጽሐፈ ኢዮብ።.json",
    "19_መዝሙረ ዳዊት.json",
    "20_መጽሐፈ ምሳሌ.json",
    "21_መጽሐፈ መክብብ.json",
    "22_መኃልየ መኃልይ ዘሰሎሞን.json",
    "23_ትንቢተ ኢሳይያስ.json",
    "24_ትንቢተ ኤርምያስ.json",
    "25_ሰቆቃው ኤርምያስ.json",
    "26_ትንቢተ ሕዝቅኤል.json",
    "27_ትንቢተ ዳንኤል.json",
    "28_ትንቢተ ሆሴዕ.json",
    "29_ትንቢተ ኢዮኤል.json",
    "30_ትንቢተ አሞጽ.json",
    "31_ትንቢተ አብድዩ.json",
    "32_ትንቢተ ዮናስ.json",
    "33_ትንቢተ ሚክያስ.json",
    "34_ትንቢተ ናሆም.json",
    "35_ትንቢተ ዕንባቆም.json",
    "36_ትንቢተ ሶፎንያስ.json",
    "37_ትንቢተ ሐጌ.json",
    "38_ትንቢተ ዘካርያስ.json",
    "39_ትንቢተ ሚልክያ.json",
  ];

  List ntBooksAM = [
    "40_የማቴዎስ ወንጌል.json",
    "41_የማርቆስ ወንጌል.json",
    "42_የሉቃስ ወንጌል.json",
    "43_የዮሐንስ ወንጌል.json",
    "44_የሐዋርያት ሥራ.json",
    "45_ወደ ሮሜ ሰዎች.json",
    "46_1ኛ ወደ ቆሮንቶስ ሰዎች.json",
    "47_2ኛ ወደ ቆሮንቶስ ሰዎች.json",
    "48_ወደ ገላትያ ሰዎች.json",
    "49_ወደ ኤፌሶን ሰዎች.json",
    "50_ወደ ፊልጵስዩስ ሰዎች.json",
    "51_ወደ ቆላስይስ ሰዎች.json",
    "52_1ኛ ወደ ተሰሎንቄ ሰዎች.json",
    "53_2ኛ ወደ ተሰሎንቄ ሰዎች.json",
    "54_1ኛ ወደ ጢሞቴዎስ.json",
    "55_2ኛ ወደ ጢሞቴዎስ.json",
    "56_ወደ ቲቶ.json",
    "57_ወደ ፊልሞና.json",
    "58_ወደ ዕብራውያን.json",
    "59_የያዕቆብ መልእክት.json",
    "60_1ኛ የጴጥሮስ መልእክት.json",
    "61_2ኛ የጴጥሮስ መልእክት.json",
    "62_1ኛ የዮሐንስ መልእክት.json",
    "63_2ኛ የዮሐንስ መልእክት.json",
    "64_3ኛ የዮሐንስ መልእክት.json",
    "65_የይሁዳ መልእክት.json",
    "66_የዮሐንስ ራእይ.json",
  ];

  bool isAmharic = false;
  void loadAmharicBible() async {
    var pathOfJSON = "assets/holybooks/AM/${otBooksAM[0]}";
    String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
    final jsonResult = jsonDecode(data);
    // content = jsonResult["text"][1]["text"];
    chapterLength = jsonResult["chapters"].length;
    print(chapterLength);
    content = jsonResult["chapters"][currentChapter - 1];
    print(jsonResult["chapters"]);
    print(content["verses"].length);
    print(content["verses"]);
    print(content["verses"][0]);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setContent("ESV", "OT", "GEN", 1);
    // loadAmharicBible();
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
                                          isAmharic = false;
                                          setState(() {});
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
                                      GestureDetector(
                                        onTap: () {
                                          isAmharic = true;
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 10.0),
                                          child: Text(
                                            "አማ",
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
                            isAmharic == true
                                ? Container(
                                    child: Column(
                                      children: [
                                        for (var eachVerse in content["verses"])
                                          Container(
                                            decoration: BoxDecoration(),
                                            padding: const EdgeInsets.only(
                                              right: 10.0,
                                              top: 5.0,
                                              bottom: 5.0,
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "$eachVerse",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                : currentVersion == "ERV" &&
                                        ervTitle.isNotEmpty == true
                                    ? Column(
                                        children: [
                                          for (var eachTitle in ervTitle)
                                            Column(
                                              children: [
                                                showComments == true
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 15.0,
                                                          bottom: 5.0,
                                                        ),
                                                        child: Text(
                                                          eachTitle["title"] ==
                                                                  null
                                                              ? ""
                                                              : eachTitle[
                                                                  "title"],
                                                          style: TextStyle(
                                                            color: Colors
                                                                .greenAccent,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                                for (var eachVerse
                                                    in eachTitle["text"])
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDifferentVersions(
                                                            int.parse(eachVerse[
                                                                "ID"]),
                                                          );
                                                        },
                                                        child: EachVerse(
                                                          verseData: eachVerse,
                                                        ),
                                                      ),
                                                      showComments == true
                                                          ? eachVerse["comments"] !=
                                                                  null
                                                              ? Column(
                                                                  children: [
                                                                    for (var eachComment
                                                                        in eachVerse[
                                                                            "comments"])
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              30.0,
                                                                        ),
                                                                        margin: const EdgeInsets.only(
                                                                            bottom:
                                                                                10.0),
                                                                        child:
                                                                            Text(
                                                                          eachComment,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey[500]!,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                )
                                                              : Container()
                                                          : Container(),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          for (var eachVerse in content)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDifferentVersions(
                                                      int.parse(
                                                          eachVerse["ID"]),
                                                    );
                                                  },
                                                  child: EachVerse(
                                                    verseData: eachVerse,
                                                  ),
                                                ),
                                                currentVersion == "ERV" &&
                                                        showComments == true
                                                    ? eachVerse["comments"] !=
                                                            null
                                                        ? Column(
                                                            children: [
                                                              for (var eachComment
                                                                  in eachVerse[
                                                                      "comments"])
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        30.0,
                                                                  ),
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0),
                                                                  child: Text(
                                                                    eachComment,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          600]!,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          )
                                                        : Container()
                                                    : Container(),
                                              ],
                                            ),
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
