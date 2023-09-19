// ignore_for_file: file_names

import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    "አማ",
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
      try {
        var pathOfJSON = "";
        if (eachVersion == "አማ") {
          var chosenBookAM =
              widget.englishToAmharicMap[widget.abbrv[widget.book]];
          pathOfJSON = "assets/holybooks/AM/$chosenBookAM";
        } else {
          pathOfJSON =
              "assets/holybooks/EN/${widget.testament}/${widget.book}/$eachVersion.json";
        }

        String data =
            await DefaultAssetBundle.of(context).loadString(pathOfJSON);
        final jsonResult = jsonDecode(data);

        var chosenVerse = {};
        if (eachVersion == "አማ") {
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
      } catch (e) {
        print(e);
      }
    }

    setState(() {});
  }

  void copyDifferentVersion() async {
    var copyableText =
        "${widget.abbrv[widget.book]} | ${widget.englishToAmharicMap[widget.abbrv[widget.book]].toString().substring(3, widget.englishToAmharicMap[widget.abbrv[widget.book]].length - 5)} ${widget.chapter}:${widget.verse}\n\n";

    for (var eachVersion in differentVersion) {
      if (eachVersion["text"].toString().isNotEmpty) {
        if (eachVersion["version"] == "አማ") {
          copyableText += "አማ 1954" + "\n\"" + eachVersion["text"] + "\"\n\n";
        } else {
          copyableText +=
              eachVersion["version"] + "\n\"" + eachVersion["text"] + "\"\n\n";
        }
      }
    }

    await FlutterClipboard.copy(copyableText).then(
      (value) {},
    );
    setState(() {});
  }

  @override
  void initState() {
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
        child: differentVersion.isEmpty == true
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Book Chapter and Verse
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160.0,
                                child: Text(
                                  widget.abbrv[widget.book].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                width: 160.0,
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.englishToAmharicMap[
                                            widget.abbrv[widget.book]]
                                        .toString()
                                        .substring(
                                            3,
                                            widget
                                                    .englishToAmharicMap[widget
                                                        .abbrv[widget.book]]
                                                    .length -
                                                5),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Chapter ${widget.chapter.toString()}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(height: 5.0),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Verse ${widget.verse.toString()}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(height: 5.0),
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
                        ],
                      ),
                    ),

                    const SizedBox(height: 200.0),
                    const Center(
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
                      // Book Chapter and Verse
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160.0,
                                  child: Text(
                                    widget.abbrv[widget.book].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Container(
                                  width: 160.0,
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.englishToAmharicMap[
                                              widget.abbrv[widget.book]]
                                          .toString()
                                          .substring(
                                              3,
                                              widget
                                                      .englishToAmharicMap[
                                                          widget.abbrv[
                                                              widget.book]]
                                                      .length -
                                                  5),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Chapter ${widget.chapter.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 5.0),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Verse ${widget.verse.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 5.0),
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
                          ],
                        ),
                      ),

                      // Divider
                      const SizedBox(height: 5.0),
                      Divider(
                        color: Colors.grey[800]!,
                        height: 10.0,
                      ),
                      const SizedBox(height: 5.0),

                      // Each Translation
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: ListView(
                          children: [
                            for (var eachVersion in differentVersion)
                              GestureDetector(
                                onTap: () async {
                                  var copyableText =
                                      "\"${eachVersion["text"]}\"\n — ${eachVersion["version"] == "አማ" ? widget.englishToAmharicMap[widget.abbrv[widget.book]].toString().substring(3, widget.englishToAmharicMap[widget.abbrv[widget.book]].length - 5) : widget.abbrv[widget.book]} ${widget.chapter}:${widget.verse} (${eachVersion["version"] == "አማ" ? "አማ 1954" : eachVersion["version"]})";
                                  await FlutterClipboard.copy(copyableText)
                                      .then(
                                    (value) {},
                                  );
                                  Fluttertoast.showToast(
                                    msg: "Version Copied",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
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
                                          top: 10.0,
                                          bottom: 15.0,
                                          left: 12.0,
                                          right: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[900]!,
                                          border: Border.all(
                                            color: Colors.grey[850]!,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1.0,
                                              offset: Offset(3, 4),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              eachVersion["version"] == "አማ"
                                                  ? "አማ 1954"
                                                  : eachVersion["version"],
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500]!,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 6.0),
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
                            const SizedBox(height: 10.0),
                            const Column(
                              children: [
                                Text(
                                  "Tap on individual translations to copy individually",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 80.0),
                            // Copy
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    copyDifferentVersion();
                                    Fluttertoast.showToast(
                                      msg: "All Versions Copied",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.copy_all,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Copy All",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 50.0)
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
