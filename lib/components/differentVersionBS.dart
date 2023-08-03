import 'dart:convert';

import 'package:flutter/material.dart';

class DifferentVersions extends StatefulWidget {
  const DifferentVersions({
    super.key,
    required this.testament,
    required this.book,
    required this.chapter,
    required this.verse,
  });

  final String testament;
  final String book;
  final int chapter;
  final int verse;

  @override
  State<DifferentVersions> createState() => _DifferentVersionsState();
}

class _DifferentVersionsState extends State<DifferentVersions> {
  List differentVersion = [];
  List versions = [
    "ERV",
    "AMP",
    "ASV",
    "CPDV",
    "ESV",
    "KJV",
    "NASB",
    "WEB",
  ];

  Future<String> getDifferentVersions(
      version, testament, book, chapter, verse) async {
    var pathOfJSON = "assets/holybooks/EN/$testament/$book/$version.json";
    String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
    final jsonResult = jsonDecode(data);
    var chosenVerse = jsonResult["text"][chapter - 1]["text"][verse];
    return chosenVerse;
  }

  void makeList(testament, book, chapter, verse) async {
    for (var eachVersion in versions) {
      var chosenVerse = await getDifferentVersions(
        eachVersion,
        widget.testament,
        widget.book,
        widget.chapter,
        widget.verse,
      );
      differentVersion.add(chosenVerse);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeList(
      widget.testament,
      widget.book,
      widget.chapter,
      widget.verse,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 10.0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey[900]!,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: differentVersion == []
                ? Container()
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          "Different Versions",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (var eachVersion in differentVersion)
                        GestureDetector(
                          onTap: () {
                            // widget.setVersion(eachVersion["ID"]);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Text(eachVersion),
                          // child: EachVersionButton(
                          //   versionData: eachVersion,
                          // ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
