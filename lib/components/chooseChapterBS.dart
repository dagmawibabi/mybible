// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybible/components/eachChapterButton.dart';

class ChooseChapterBS extends StatefulWidget {
  const ChooseChapterBS({
    super.key,
    required this.otORnt,
    required this.chosenBook,
    required this.chosenVersion,
    required this.setChapter,
    required this.currentChapter,
  });

  final String otORnt;
  final String chosenBook;
  final String chosenVersion;
  final Function setChapter;
  final int currentChapter;

  @override
  State<ChooseChapterBS> createState() => _ChooseChapterBSState();
}

class _ChooseChapterBSState extends State<ChooseChapterBS> {
  List chapterLength = [];
  void getChapters() async {
    // otORnt = currentTestament == otBooks ? "OT" : "NT";
    String data = await DefaultAssetBundle.of(context).loadString(
        "assets/holybooks/EN/${widget.otORnt}/${widget.chosenBook}/${widget.chosenVersion}.json");
    final jsonResult = jsonDecode(data);
    chapterLength = [];
    for (var i = 0; i < jsonResult["text"].length; i++) {
      chapterLength.add(i + 1);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListView(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height,
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
            child: chapterLength == []
                ? Container()
                : Column(
                    children: [
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Chapters",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "  |  ",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.grey[800]!,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "ምዕራፎች",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10.0),
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

                      // Chapters
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 20.0,
                        ),
                        child: GridView.count(
                          crossAxisCount: 5,
                          childAspectRatio: 1.25,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 6.0,
                          children: [
                            for (var eachChapter in chapterLength)
                              GestureDetector(
                                onTap: () {
                                  widget.setChapter(eachChapter);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: EachChapterButton(
                                  chapter: eachChapter.toString(),
                                  isSelected:
                                      widget.currentChapter == eachChapter
                                          ? true
                                          : false,
                                ),
                              ),
                            const SizedBox(height: 100.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100.0),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
