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

  void makeList() async {
    for (var eachVersion in versions) {
      var pathOfJSON =
          "assets/holybooks/EN/${widget.testament}/${widget.book}/$eachVersion.json";
      String data = await DefaultAssetBundle.of(context).loadString(pathOfJSON);
      final jsonResult = jsonDecode(data);
      var chosenVerse =
          jsonResult["text"][widget.chapter - 1]["text"][widget.verse - 1];
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
          color: Colors.grey[900]!,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              20.0,
            ),
            topRight: Radius.circular(
              20.0,
            ),
          ),
        ),
        child: differentVersion == []
            ? Container(
                width: double.infinity,
                child: Column(
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
                    const SizedBox(height: 200.0),
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey[500]!,
                      ),
                    ),
                  ],
                ),
              )
            : ListView(
                children: [
                  Column(
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
                                    // color: Colors.white,
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
                          // child: EachVersionButton(
                          //   versionData: eachVersion,
                          // ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
