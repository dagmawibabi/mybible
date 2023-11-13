import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:mybible/components/chooseBookBS.dart';
import 'package:mybible/components/chooseChapterBS.dart';
import 'package:mybible/components/chooseVersionBS.dart';
import 'package:mybible/components/differentVersionBS.dart';
import 'package:mybible/components/eachVerse.dart';
import 'package:mybible/models/savedVerses.dart';
import 'package:mybible/pages/bookmarksPage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic content;
  String currentVersion = "NASB";
  String currentTestament = "OT";
  String currentBook = "GEN";
  int currentChapter = 1;
  int chapterLength = 0;
  bool isOT = true;
  bool showComments = true;

  late double eachVerseFontSize;
  late double eachNumberFontSize;
  late double eachCommentFontSize;
  late double eachTopicFontSize;

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

  Map revAbbrv = {
    "Genesis": "GEN",
    "Exodus": "EXO",
    "Leviticus": "LEV",
    "Numbers": "NUM",
    "Deuteronomy": "DEU",
    "Joshua": "JOS",
    "Judges": "JDG",
    "Ruth": "RUT",
    "1 Samuel": "1SA",
    "2 Samuel": "2SA",
    "1 Kings": "1KI",
    "2 Kings": "2KI",
    "1 Chronicles": "1CH",
    "2 Chronicles": "2CH",
    "Ezra": "EZR",
    "Nehemiah": "NAM",
    "Esther": "EST",
    "Job": "JOB",
    "Psalms": "PSA",
    "Proverbs": "PRO",
    "Ecclesiastes": "ECC",
    "Song of Solomon": "SNG",
    "Isaiah": "ISA",
    "Jeremiah": "JER",
    "Lamentations": "LAM",
    "Ezekiel": "EZK",
    "Daniel": "DAN",
    "Hosea": "HOS",
    "Joel": "JOL",
    "Amos": "AMO",
    "Obadiah": "OBA",
    "Jonah": "JON",
    "Micah": "MIC",
    "Nahum": "NAH",
    "Habakkuk": "HAB",
    "Zephaniah": "ZEP",
    "Haggai": "HAG",
    "Zechariah": "ZEC",
    "Malachi": "MAL",
    "Matthew": "MAT",
    "Mark": "MRK",
    "Luke": "LUK",
    "John": "JHN",
    "Acts": "ACT",
    "Romans": "ROM",
    "1 Corinthians": "1CO",
    "2 Corinthians": "2CO",
    "Galatians": "GAL",
    "Ephesians": "EPH",
    "Philippians": "PHP",
    "Colossians": "COL",
    "1 Thessalonians": "1TH",
    "2 Thessalonians": "2TH",
    "1 Timothy": "1TI",
    "2 Timothy": "2TI",
    "Titus": "TIT",
    "Philemon": "PHM",
    "Hebrews": "HEB",
    "James": "JAS",
    "1 Peter": "1PE",
    "2 Peter": "2PE",
    "1 John": "1JN",
    "2 John": "2JN",
    "3 John": "3JN",
    "Jude": "JUD",
    "Revelation": "REV",
  };

  dynamic ervTitle = [];

  Future<void> setContent(version, testament, book, chapter) async {
    currentVersion = version;
    currentTestament = testament;
    currentBook = book;
    currentChapter = chapter;

    var pathOfJSON = "";
    if (isAmharic == true) {
      var chosenBookAM = englishToAmharicMap[abbrv[currentBook]];
      pathOfJSON = "assets/holybooks/AM/$chosenBookAM";
    } else {
      pathOfJSON = "assets/holybooks/EN/$testament/$book/$version.json";
    }

    String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
    final jsonResult = jsonDecode(data);

    if (isAmharic == true) {
      chapterLength = jsonResult["chapters"].length;
      content = jsonResult["chapters"][chapter - 1]["verses"];
      amharicBible = [];
      for (var i = 0; i < content.length; i++) {
        amharicBible.add({
          "text": content[i],
          "ID": i + 1,
        });
      }
    } else {
      chapterLength = jsonResult["text"].length;
      content = jsonResult["text"][chapter - 1]["text"];
      ervTitle = jsonResult["text"][chapter - 1];
    }

    try {
      Box savedVersesBox = await Hive.openBox("SavedVersesBox");
      if (!savedVersesBox.isOpen) {
        savedVersesBox = await Hive.openBox("SavedVersesBox");
      }
      if (savedVersesBox.isOpen) {
        await savedVersesBox.put("lastVersion", currentVersion);
        await savedVersesBox.put("lastTestament", currentTestament);
        await savedVersesBox.put("lastBook", currentBook);
        await savedVersesBox.put("lastChapter", currentChapter);
        await savedVersesBox.put("wasAmharic", isAmharic);
        await savedVersesBox.close();
      }
    } catch (error) {
      print(HiveError('${error.toString()}'));
    }
    setState(() {});
  }

  void changeToAmharic() async {
    isAmharic = true;
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    await savedVersesBox.put("wasAmharic", isAmharic);
    await savedVersesBox.close();
    setState(() {});
    loadAmharicBible();
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
    isAmharic = false;
    currentVersion = version;
    await setContent(
        currentVersion, currentTestament, currentBook, currentChapter);
    setState(() {});
  }

  void showBooks() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: const Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseBookBS(
          setTestamentAndBook: setTestamentAndBook,
          englishToAmharicMap: englishToAmharicMap,
          currentBook: currentBook,
          currentTestament: currentTestament,
        );
      },
    );
  }

  void showChapters() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: const Offset(0, 100),
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
            currentChapter: currentChapter);
      },
    );
  }

  void showVersions() async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: const Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return ChooseVersionBS(
          setVersion: setVersion,
          changeToAmharic: changeToAmharic,
          currentVersion: currentVersion,
          isAmharic: isAmharic,
        );
      },
    );
  }

  void showDifferentVersions(currentVerse) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: const Offset(0, 100),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
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
          abbrv: abbrv,
          englishToAmharicMap: englishToAmharicMap,
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
    "11_መጽሐፈ ነገሥት ቀዳማዊ.json",
    "12_መጽሐፈ ነገሥት ካልዕ.json",
    "13_መጽሐፈ ዜና መዋዕል ቀዳማዊ.json",
    "14_መጽሐፈ ዜና መዋዕል ካልዕ.json",
    "15_መጽሐፈ ዕዝራ.json",
    "16_መጽሐፈ ነህምያ.json",
    "17_መጽሐፈ አስቴር.json",
    "18_መጽሐፈ ኢዮብ.json",
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

  Map englishToAmharicMap = {
    "Genesis": "01_ኦሪት ዘፍጥረት.json",
    "Exodus": "02_ኦሪት ዘጸአት.json",
    "Leviticus": "03_ኦሪት ዘሌዋውያን.json",
    "Numbers": "04_ኦሪት ዘኍልቍ.json",
    "Deuteronomy": "05_ኦሪት ዘዳግም.json",
    "Joshua": "06_መጽሐፈ ኢያሱ ወልደ ነዌ.json",
    "Judges": "07_መጽሐፈ መሣፍንት.json",
    "Ruth": "08_መጽሐፈ ሩት.json",
    "1 Samuel": "09_መጽሐፈ ሳሙኤል ቀዳማዊ.json",
    "2 Samuel": "10_መጽሐፈ ሳሙኤል ካል.json",
    "1 Kings": "11_መጽሐፈ ነገሥት ቀዳማዊ.json",
    "2 Kings": "12_መጽሐፈ ነገሥት ካልዕ.json",
    "1 Chronicles": "13_መጽሐፈ ዜና መዋዕል ቀዳማዊ.json",
    "2 Chronicles": "14_መጽሐፈ ዜና መዋዕል ካልዕ.json",
    "Ezra": "15_መጽሐፈ ዕዝራ.json",
    "Nehemiah": "16_መጽሐፈ ነህምያ.json",
    "Esther": "17_መጽሐፈ አስቴር.json",
    "Job": "18_መጽሐፈ ኢዮብ.json",
    "Psalms": "19_መዝሙረ ዳዊት.json",
    "Proverbs": "20_መጽሐፈ ምሳሌ.json",
    "Ecclesiastes": "21_መጽሐፈ መክብብ.json",
    "Song of Solomon": "22_መኃልየ መኃልይ ዘሰሎሞን.json",
    "Isaiah": "23_ትንቢተ ኢሳይያስ.json",
    "Jeremiah": "24_ትንቢተ ኤርምያስ.json",
    "Lamentations": "25_ሰቆቃው ኤርምያስ.json",
    "Ezekiel": "26_ትንቢተ ሕዝቅኤል.json",
    "Daniel": "27_ትንቢተ ዳንኤል.json",
    "Hosea": "28_ትንቢተ ሆሴዕ.json",
    "Joel": "29_ትንቢተ ኢዮኤል.json",
    "Amos": "30_ትንቢተ አሞጽ.json",
    "Obadiah": "31_ትንቢተ አብድዩ.json",
    "Jonah": "32_ትንቢተ ዮናስ.json",
    "Micah": "33_ትንቢተ ሚክያስ.json",
    "Nahum": "34_ትንቢተ ናሆም.json",
    "Habakkuk": "35_ትንቢተ ዕንባቆም.json",
    "Zephaniah": "36_ትንቢተ ሶፎንያስ.json",
    "Haggai": "37_ትንቢተ ሐጌ.json",
    "Zechariah": "38_ትንቢተ ዘካርያስ.json",
    "Malachi": "39_ትንቢተ ሚልክያ.json",
    "Matthew": "40_የማቴዎስ ወንጌል.json",
    "Mark": "41_የማርቆስ ወንጌል.json",
    "Luke": "42_የሉቃስ ወንጌል.json",
    "John": "43_የዮሐንስ ወንጌል.json",
    "Acts": "44_የሐዋርያት ሥራ.json",
    "Romans": "45_ወደ ሮሜ ሰዎች.json",
    "1 Corinthians": "46_1ኛ ወደ ቆሮንቶስ ሰዎች.json",
    "2 Corinthians": "47_2ኛ ወደ ቆሮንቶስ ሰዎች.json",
    "Galatians": "48_ወደ ገላትያ ሰዎች.json",
    "Ephesians": "49_ወደ ኤፌሶን ሰዎች.json",
    "Philippians": "50_ወደ ፊልጵስዩስ ሰዎች.json",
    "Colossians": "51_ወደ ቆላስይስ ሰዎች.json",
    "1 Thessalonians": "52_1ኛ ወደ ተሰሎንቄ ሰዎች.json",
    "2 Thessalonians": "53_2ኛ ወደ ተሰሎንቄ ሰዎች.json",
    "1 Timothy": "54_1ኛ ወደ ጢሞቴዎስ.json",
    "2 Timothy": "55_2ኛ ወደ ጢሞቴዎስ.json",
    "Titus": "56_ወደ ቲቶ.json",
    "Philemon": "57_ወደ ፊልሞና.json",
    "Hebrews": "58_ወደ ዕብራውያን.json",
    "James": "59_የያዕቆብ መልእክት.json",
    "1 Peter": "60_1ኛ የጴጥሮስ መልእክት.json",
    "2 Peter": "61_2ኛ የጴጥሮስ መልእክት.json",
    "1 John": "62_1ኛ የዮሐንስ መልእክት.json",
    "2 John": "63_2ኛ የዮሐንስ መልእክት.json",
    "3 John": "64_3ኛ የዮሐንስ መልእክት.json",
    "Jude": "65_የይሁዳ መልእክት.json",
    "Revelation": "66_የዮሐንስ ራእይ.json",
  };

  void setFontSize(formerEachVerseFontSize, formerEachNumberFontSize,
      formerEachCommentFontSize, formerEachTopicFontSize) {
    setState(() {
      eachVerseFontSize = formerEachVerseFontSize ?? 16.0;
      eachNumberFontSize = formerEachNumberFontSize ?? 10.0;
      eachCommentFontSize = formerEachCommentFontSize ?? 14.0;
      eachTopicFontSize = formerEachTopicFontSize ?? 17.0;
    });
  }

  void increaseFontSize() async {
    eachVerseFontSize++;
    eachNumberFontSize++;
    eachCommentFontSize++;
    eachTopicFontSize++;
    Box savedFontSizeBox = await Hive.openBox("SavedFontSizeBox");
    await savedFontSizeBox.put("eachVerseFontSize", eachVerseFontSize);
    await savedFontSizeBox.put("eachNumberFontSize", eachNumberFontSize);
    await savedFontSizeBox.put("eachCommentFontSize", eachCommentFontSize);
    await savedFontSizeBox.put("eachTopicFontSize", eachTopicFontSize);
    await savedFontSizeBox.close();
    setState(() {});
  }

  void decreaseFontSize() async {
    if (eachNumberFontSize >= 1) {
      eachVerseFontSize--;
      eachNumberFontSize--;
      eachCommentFontSize--;
      eachTopicFontSize--;
      Box savedFontSizeBox = await Hive.openBox("SavedFontSizeBox");
      await savedFontSizeBox.put("eachVerseFontSize", eachVerseFontSize);
      await savedFontSizeBox.put("eachNumberFontSize", eachNumberFontSize);
      await savedFontSizeBox.put("eachCommentFontSize", eachCommentFontSize);
      await savedFontSizeBox.put("eachTopicFontSize", eachTopicFontSize);
      await savedFontSizeBox.close();
      setState(() {});
    }
  }

  bool isAmharic = false;
  List amharicBible = [];
  void loadAmharicBible() async {
    var bookName = abbrv[currentBook];
    var bookName1 = englishToAmharicMap[bookName];

    var index = 0;
    if (currentTestament == "OT") {
      index = otBooksAM.indexOf(bookName1);
    } else {
      index = ntBooksAM.indexOf(bookName1);
    }
    var pathOfJSON =
        "assets/holybooks/AM/${currentTestament == "OT" ? otBooksAM[index] : ntBooksAM[index]}";
    String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
    final jsonResult = jsonDecode(data);
    chapterLength = jsonResult["chapters"].length;
    var result = jsonResult["chapters"][currentChapter - 1]["verses"];
    amharicBible = [];
    for (var i = 0; i < result.length; i++) {
      amharicBible.add({
        "text": result[i],
        "ID": i + 1,
      });
    }
    setState(() {});
  }

  List<SavedVerse> selectedVerse = [];
  void selectVerses(id, text) async {
    // Check if verse is selected or not
    bool isFound = false;
    for (SavedVerse eachSelectedVerse in selectedVerse) {
      if (eachSelectedVerse.verse == text) {
        isFound = true;
        break;
      }
    }
    // If a verse is already selected remove it
    if (isFound == true) {
      List<SavedVerse> newSelectedVerse = [];
      for (SavedVerse eachSelectedVerse in selectedVerse) {
        if (eachSelectedVerse.verse != text) {
          newSelectedVerse.add(eachSelectedVerse);
        }
      }
      selectedVerse.clear();
      selectedVerse = newSelectedVerse;
    } else {
      SavedVerse newSelectedVerse = SavedVerse()
        ..version = isAmharic == true ? "አማ 1954" : currentVersion
        ..testament = isAmharic == true
            ? isOT == true
                ? "ብሉይ ኪዳን"
                : "አዲስ ኪዳን"
            : currentTestament
        ..book = isAmharic == true
            ? englishToAmharicMap[abbrv[currentBook]].toString().substring(
                3, englishToAmharicMap[abbrv[currentBook]].length - 5)
            : currentBook
        ..chapter = currentChapter
        ..number = int.parse(id)
        ..verse = text;
      selectedVerse.add(newSelectedVerse);
    }
    setState(() {});
  }

  void addToBookmarks() async {
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    // await savedVersesBox.clear();
    var oldSavedVerses = await savedVersesBox.get("savedVerses");
    var saveableVerses = [];
    // Filter Out Selected Verses
    if (oldSavedVerses == null) {
      oldSavedVerses = [];
      saveableVerses = [...oldSavedVerses, ...selectedVerse];
      await savedVersesBox.put("savedVerses", saveableVerses);
    } else {
      for (SavedVerse eachSelectedVerse in selectedVerse) {
        bool isFound = false;
        for (SavedVerse eachOldSavedVerse in oldSavedVerses) {
          if (eachOldSavedVerse.verse == eachSelectedVerse.verse) {
            isFound = true;
            break;
          }
        }
        // If verse isn't saved already.. save
        if (isFound == false) {
          saveableVerses.add(eachSelectedVerse);
        }
      }
      // Save
      // oldSavedVerses = [];
      // oldSavedVerses = [...oldSavedVerses, ...saveableVerses];
      saveableVerses = [...oldSavedVerses, ...saveableVerses];
      await savedVersesBox.put("savedVerses", saveableVerses);
    }
    selectedVerse = [];
    await savedVersesBox.close();
    setState(() {});
  }

  List<TargetFocus> targets = [];
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();
  GlobalKey keyButton6 = GlobalKey();
  GlobalKey keyButton7 = GlobalKey();
  GlobalKey keyButton8 = GlobalKey();
  GlobalKey keyButton9 = GlobalKey();

  void showTutorial() async {
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    dynamic haveSeenTutorial = await savedVersesBox.get("seenTutorial");
    haveSeenTutorial = haveSeenTutorial ?? false;
    // await savedVersesBox.clear();
    await savedVersesBox.close();
    if (haveSeenTutorial == false) {
      TutorialCoachMark tutorial = TutorialCoachMark(
          targets: targets,
          colorShadow: Colors.black,
          opacityShadow: 0.9,
          alignSkip: Alignment.bottomCenter,
          textSkip: "SKIP",
          // paddingFocus: 10,
          // focusAnimationDuration: Duration(milliseconds: 500),
          // unFocusAnimationDuration: Duration(milliseconds: 500),
          // pulseAnimationDuration: Duration(milliseconds: 500),
          // pulseVariation: Tween(begin: 1.0, end: 0.99),
          // showSkipInLastTarget: true,
          // imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          onFinish: () async {
            Box savedVersesBox = await Hive.openBox("SavedVersesBox");
            await savedVersesBox.put("seenTutorial", true);
            await savedVersesBox.close();
            setContent("NASB", "OT", "GEN", 1);
          },
          onClickTargetWithTapPosition: (target, tapDetails) {},
          onClickTarget: (target) {},
          onSkip: () async {
            Box savedVersesBox = await Hive.openBox("SavedVersesBox");
            await savedVersesBox.put("seenTutorial", true);
            await savedVersesBox.close();
            setContent("NASB", "OT", "GEN", 1);
          })
        ..show(context: context);
    }

    // tutorial.skip();
    // tutorial.finish();
    // tutorial.next(); // call next target programmatically
    // tutorial.previous(); // call previous target programmatically
  }

  void createTutorial() {
    // targets.add();
    targets.add(
      targetFocusWidget(
        "keyButton1",
        keyButton,
        "Click on book title to browse through other books",
        true,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton2",
        keyButton2,
        "Click on chapter number to browse through other chapters",
        true,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton3",
        keyButton3,
        "Click on translation version to browse through other translations",
        true,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton4",
        keyButton4,
        "Click here to browse through your saved verses",
        true,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton5",
        keyButton5,
        "Click on plus sign to increase font size of the verses",
        false,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton6",
        keyButton6,
        "Click on minus sign to decrease font size of the verses",
        false,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton7",
        keyButton7,
        "Click here or swipe left on the center of the screen to goto the next chapter",
        false,
      ),
    );
    targets.add(
      targetFocusWidget(
        "keyButton8",
        keyButton8,
        "Click on verses to see different version of translations of them. Long press to select to copy or bookmark.",
        true,
        topSizedBox: 300.0,
      ),
    );
  }

  TargetFocus targetFocusWidget(identify, keyTarget, tutorialText, isUp,
      {topSizedBox = 50.0}) {
    return TargetFocus(
      identify: identify.toString(),
      keyTarget: keyTarget,
      enableOverlayTab: true,
      contents: [
        TargetContent(
          align: isUp == true ? ContentAlign.bottom : ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isUp == true
                    ? SizedBox(height: topSizedBox)
                    : const SizedBox(height: 0.0),
                Text(
                  tutorialText.toString(),
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                  ),
                ),
                isUp == true
                    ? const SizedBox(height: 0.0)
                    : const SizedBox(height: 50.0),
              ],
            );
          },
        ),
      ],
    );
  }

  void loadLastContext() async {
    Box savedVersesBox = await Hive.openBox("SavedVersesBox");
    Box savedFontSizeBox = await Hive.openBox("SavedFontSizeBox");
    if (!savedVersesBox.isOpen) {
      savedVersesBox = await Hive.openBox("SavedVersesBox");
    }
    if (savedVersesBox.isOpen) {
      dynamic lastVersion = await savedVersesBox.get("lastVersion");
      if (lastVersion == null) {
        setContent("NASB", "OT", "GEN", 1);
      } else {
        var lastTestament = await savedVersesBox.get("lastTestament");
        var lastBook = await savedVersesBox.get("lastBook");
        var lastChapter = await savedVersesBox.get("lastChapter");
        isAmharic = await savedVersesBox.get("wasAmharic");
        setContent(lastVersion, lastTestament, lastBook, lastChapter);
      }
    }
    var formerEachVerseFontSize =
        await savedFontSizeBox.get("eachVerseFontSize");

    if (formerEachVerseFontSize == null) {
      setFontSize(16.0, 10.0, 14.0, 17.0);
    } else {
      var formerEachNumberFontSize =
          await savedFontSizeBox.get("eachNumberFontSize");
      var formerEachCommentFontSize =
          await savedFontSizeBox.get("eachCommentFontSize");
      var formerEachTopicFontSize =
          await savedFontSizeBox.get("eachTopicFontSize");
      setFontSize(formerEachVerseFontSize, formerEachNumberFontSize,
          formerEachCommentFontSize, formerEachTopicFontSize);
    }
  }

  void copySelectedVerses() async {
    String copyableText = "";
    for (SavedVerse eachSelectedVerse in selectedVerse) {
      var abc =
          "\"${eachSelectedVerse.verse}\"\n — ${eachSelectedVerse.version == "አማ 1954" ? eachSelectedVerse.book : abbrv[eachSelectedVerse.book]} ${eachSelectedVerse.chapter}:${eachSelectedVerse.number} (${eachSelectedVerse.version}) \n\n";
      copyableText += abc;
    }

    await FlutterClipboard.copy(copyableText).then(
      (value) {},
    );
    selectedVerse = [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // setContent("ERV", "OT", "PSA", 119);
    loadLastContext();
    loadAmharicBible();
    createTutorial();
    Future.delayed(const Duration(seconds: 1), showTutorial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onHorizontalDragStart: (details) {
                if (details.localPosition.dx < 230.0) {
                  if (currentChapter - 1 >= 1) {
                    currentChapter -= 1;
                    setContent(
                      currentVersion,
                      currentTestament,
                      currentBook,
                      currentChapter,
                    );
                  }
                } else {
                  if (currentChapter + 1 <= chapterLength) {
                    currentChapter += 1;
                    setContent(
                      currentVersion,
                      currentTestament,
                      currentBook,
                      currentChapter,
                    );
                  }
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 20.0,
                  ),
                  content != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5.0,
                                left: 15.0,
                                right: 5.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Book and Chapter
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showBooks();
                                        },
                                        child: Text(
                                          key: keyButton,
                                          isAmharic == true
                                              ? englishToAmharicMap[
                                                      abbrv[currentBook]]
                                                  .toString()
                                                  .substring(
                                                      3,
                                                      englishToAmharicMap[abbrv[
                                                                  currentBook]]
                                                              .length -
                                                          5)
                                              : "${abbrv[currentBook]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                isAmharic == true ? 18.0 : 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showChapters();
                                        },
                                        child: Text(
                                          key: keyButton2,
                                          "  $currentChapter",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Translations and Bookmarks
                                  Row(
                                    children: [
                                      currentVersion == "ERV" &&
                                              isAmharic == false
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
                                              // color: Colors.red,
                                            ),
                                      GestureDetector(
                                        onTap: () {
                                          showVersions();
                                        },
                                        child: Container(
                                          key: keyButton3,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0,
                                            vertical: 10.0,
                                          ),
                                          child: Text(
                                            isAmharic == true
                                                ? "አማ"
                                                : currentVersion,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        key: keyButton4,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BookmarksPage(),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.bookmark_outline,
                                          color: Colors.white,
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
                                ? Column(
                                    children: [
                                      for (var eachVerse in amharicBible)
                                        eachVerse["text"] == "" ||
                                                eachVerse["text"] == "-"
                                            ? Container()
                                            : GestureDetector(
                                                onTap: () {
                                                  showDifferentVersions(
                                                    eachVerse["ID"],
                                                  );
                                                },
                                                onLongPress: () {
                                                  selectVerses(
                                                      eachVerse["ID"]
                                                          .toString(),
                                                      eachVerse["text"]);
                                                },
                                                child: EachVerse(
                                                  verseData: eachVerse,
                                                  fontSize: eachVerseFontSize,
                                                  eachNumberFontSize:
                                                      eachNumberFontSize,
                                                  selectedVerse: selectedVerse,
                                                ),
                                              ),
                                    ],
                                  )
                                : currentVersion == "ERV"
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 5.0,
                                              bottom: 10.0,
                                              left: 20.0,
                                              right: 20.0,
                                            ),
                                            child: showComments == true &&
                                                    ervTitle["title"] != null
                                                ? Text(
                                                    ervTitle["title"],
                                                    style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize:
                                                          eachTopicFontSize,
                                                    ),
                                                  )
                                                : Container(),
                                          ),
                                          // Each ERV Verse
                                          for (var eachVerse
                                              in ervTitle["text"])
                                            GestureDetector(
                                              onTap: () {
                                                showDifferentVersions(
                                                  int.parse(eachVerse["ID"]),
                                                );
                                              },
                                              onLongPress: () {
                                                selectVerses(eachVerse["ID"],
                                                    eachVerse["text"]);
                                              },
                                              child: Column(
                                                children: [
                                                  EachVerse(
                                                    verseData: eachVerse,
                                                    fontSize: eachVerseFontSize,
                                                    eachNumberFontSize:
                                                        eachNumberFontSize,
                                                    selectedVerse:
                                                        selectedVerse,
                                                  ),
                                                  eachVerse["comments"] !=
                                                              null &&
                                                          showComments == true
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            for (var eachComment
                                                                in eachVerse[
                                                                    "comments"])
                                                              GestureDetector(
                                                                onLongPress:
                                                                    () async {
                                                                  var copyableText = abbrv[
                                                                          currentBook] +
                                                                      " " +
                                                                      currentChapter
                                                                          .toString() +
                                                                      ":" +
                                                                      eachVerse[
                                                                              "ID"]
                                                                          .toString() +
                                                                      "\n\"" +
                                                                      eachVerse[
                                                                          "text"] +
                                                                      "\"\n\nCommentary:\n" +
                                                                      eachComment;
                                                                  await FlutterClipboard
                                                                          .copy(
                                                                              copyableText)
                                                                      .then(
                                                                    (value) {},
                                                                  );
                                                                  Fluttertoast
                                                                      .showToast(
                                                                    msg:
                                                                        "Comment Copied",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity:
                                                                        ToastGravity
                                                                            .TOP,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .black,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0,
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        30.0,
                                                                  ),
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    bottom:
                                                                        10.0,
                                                                  ),
                                                                  child: Text(
                                                                    eachComment,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          500]!,
                                                                      fontSize:
                                                                          eachCommentFontSize,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                          ],
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          for (var eachVerse in content)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  key: (eachVerse["ID"] ==
                                                              "4" &&
                                                          currentVersion ==
                                                              "NASB" &&
                                                          currentTestament ==
                                                              "OT" &&
                                                          currentBook == "GEN")
                                                      ? keyButton8
                                                      : GlobalKey(
                                                          debugLabel: eachVerse[
                                                              "text"]),
                                                  onTap: () {
                                                    showDifferentVersions(
                                                      int.parse(
                                                          eachVerse["ID"]),
                                                    );
                                                  },
                                                  onLongPress: () {
                                                    selectVerses(
                                                        eachVerse["ID"],
                                                        eachVerse["text"]);
                                                  },
                                                  child: eachVerse["text"]
                                                              .toString() !=
                                                          ""
                                                      ? EachVerse(
                                                          verseData: eachVerse,
                                                          fontSize:
                                                              eachVerseFontSize,
                                                          eachNumberFontSize:
                                                              eachNumberFontSize,
                                                          selectedVerse:
                                                              selectedVerse,
                                                        )
                                                      : Container(),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                            const SizedBox(height: 200.0),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              currentChapter - 1 >= 1
                  ? Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: FloatingActionButton(
                        heroTag: "backChapter",
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
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 1.0,
                      width: 30.0,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: FloatingActionButton(
                  key: keyButton6,
                  heroTag: "decreaseFont",
                  backgroundColor: Colors.grey[800],
                  mini: true,
                  onPressed: () {
                    decreaseFontSize();
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          selectedVerse.isNotEmpty == false
              ? const SizedBox(
                  height: 1.0,
                  width: 30.0,
                )
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: FloatingActionButton(
                        heroTag: "copyVerse",
                        backgroundColor: Colors.grey[800],
                        mini: true,
                        onPressed: () {
                          copySelectedVerses();
                          Fluttertoast.showToast(
                            msg: selectedVerse.length > 1
                                ? "Verses Copied"
                                : "Verse Copied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: const Icon(
                          Icons.copy_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: FloatingActionButton(
                        heroTag: "bookmarkVerse",
                        backgroundColor: Colors.grey[800],
                        mini: true,
                        onPressed: () {
                          addToBookmarks();
                          Fluttertoast.showToast(
                            msg: selectedVerse.length > 1
                                ? "Verses Added to Bookmark"
                                : "Verse Added to Bookmark",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        child: const Icon(
                          Icons.bookmark_add_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: FloatingActionButton(
                  key: keyButton5,
                  heroTag: "increaseFont",
                  backgroundColor: Colors.grey[800],
                  mini: true,
                  onPressed: () {
                    increaseFontSize();
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              currentChapter + 1 <= chapterLength
                  ? FloatingActionButton(
                      key: keyButton7,
                      heroTag: "nextChapter",
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
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                  : Container(height: 1.0)
            ],
          )
        ],
      ),
    );
  }
}
