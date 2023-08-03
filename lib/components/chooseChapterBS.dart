// ignore_for_file: prefer_const_constructors

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
  });

  final String otORnt;
  final String chosenBook;
  final String chosenVersion;
  final Function setChapter;

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
    print(chapterLength);
    for (var i = 0; i < jsonResult["text"].length; i++) {
      chapterLength.add(i + 1);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 10.0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey[900]!,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: chapterLength == []
                ? Container()
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          "Chapters",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: GridView.count(
                          crossAxisCount: 4,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          children: [
                            for (var eachChapter in chapterLength)
                              GestureDetector(
                                onTap: () {
                                  widget.setChapter(eachChapter);
                                  // chosenChapter = eachChapter - 1;
                                  // widget.setContent(chosenVersion, otORnt,
                                  //     chosenBook, chosenChapter);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: EachChapterButton(
                                  chapter: eachChapter.toString(),
                                ),

                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.blue,
                                //     borderRadius: BorderRadius.circular(10.0),
                                //   ),
                                //   child: Center(
                                //     child: Text(
                                //       eachChapter.toString(),
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
