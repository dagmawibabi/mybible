// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

class DifferentVersions extends StatefulWidget {
  const DifferentVersions({
    super.key,
    required this.testament,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.abbrv,
    required this.englishToAmharicMap,
  });

  final String testament;
  final String book;
  final int chapter;
  final int verse;
  final Map abbrv;
  final Map englishToAmharicMap;

  @override
  State<DifferentVersions> createState() => _DifferentVersionsState();
}

class _DifferentVersionsState extends State<DifferentVersions> {
  List differentVersion = [];
  List versions = [
    "AMH",
    "NASB",
    "KJV",
    "ERV",
    "AMP",
    "ASV",
    "CPDV",
    "ESV",
    "WEB",
  ];

  void makeList() async {
    for (var eachVersion in versions) {
      var pathOfJSON = "";
      if (eachVersion == "AMH") {
        var chosenBookAM =
            widget.englishToAmharicMap[widget.abbrv[widget.book]];
        pathOfJSON = "assets/holybooks/AM/$chosenBookAM";
      } else {
        pathOfJSON =
            "assets/holybooks/EN/${widget.testament}/${widget.book}/$eachVersion.json";
      }

      String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
      final jsonResult = jsonDecode(data);

      var chosenVerse = {};
      if (eachVersion == "AMH") {
        var content = jsonResult["chapters"][widget.chapter - 1]["verses"];
        var amharicBible = [];
        for (var i = 0; i < content.length; i++) {
          amharicBible.add({
            "text": content[i],
            "ID": i + 1,
          });
        }
        chosenVerse = amharicBible[widget.verse - 1];
      } else {
        chosenVerse =
            jsonResult["text"][widget.chapter - 1]["text"][widget.verse - 1];
      }

      chosenVerse["version"] = eachVersion;
      differentVersion.add(chosenVerse);
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeList();
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
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 19, 19),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: differentVersion.isEmpty == true
            ? Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 280.0,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "${widget.abbrv[widget.book]} | ",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${widget.englishToAmharicMap[widget.abbrv[widget.book]].toString().substring(3, widget.englishToAmharicMap[widget.abbrv[widget.book]].length - 5)}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "${widget.chapter.toString()}:${widget.verse.toString()}",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 200.0),
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              )
            : ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.abbrv[widget.book].toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${widget.englishToAmharicMap[widget.abbrv[widget.book]].toString().substring(3, widget.englishToAmharicMap[widget.abbrv[widget.book]].length - 5)}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Chapter ${widget.chapter.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Text(
                                  "ምዕራፍ ${widget.chapter.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Verse ${widget.verse.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Text(
                                  "ቁጥር ${widget.verse.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            // Text(
                            //   "${widget.chapter.toString()}:${widget.verse.toString()}",
                            //   style: TextStyle(
                            //     fontSize: 20.0,
                            //     color: Colors.white,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      for (var eachVersion in differentVersion)
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: eachVersion["text"] == ""
                              ? Container()
                              : Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 15.0,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    bottom: 15.0,
                                    left: 15.0,
                                    right: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900]!,
                                    border: Border.all(
                                      color: Colors.grey[800]!,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        eachVersion["version"],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[500]!,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        eachVersion["text"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      SizedBox(height: 200.0)
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
