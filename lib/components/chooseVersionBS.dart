// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybible/components/eachVersionButton.dart';

class ChooseVersionBS extends StatefulWidget {
  const ChooseVersionBS({
    super.key,
    required this.setVersion,
    required this.changeToAmharic,
    required this.currentVersion,
    required this.isAmharic,
  });

  final Function setVersion;
  final Function changeToAmharic;
  final String currentVersion;
  final bool isAmharic;

  @override
  State<ChooseVersionBS> createState() => _ChooseVersionBSState();
}

class _ChooseVersionBSState extends State<ChooseVersionBS> {
  List bibleVersionsInfo = [];
  void getBibleVersions() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/holybooks/EN/index.json");
    final jsonResult = jsonDecode(data);
    bibleVersionsInfo = jsonResult["versions"];
    // print(bibleVersionsInfo);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBibleVersions();
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
        child: bibleVersionsInfo.isEmpty == true
            ? Container()
            : ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            SizedBox(width: 10.0),
                            const Text(
                              "Versions",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "  |  ",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[800]!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "ትርጉሞች",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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

                      // Version List
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.changeToAmharic();
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: EachVersionButton(
                                versionData: const {
                                  "ID": "አማ",
                                  "title": "አማርኛ 1954",
                                  "details":
                                      "Christianity entered Ethiopia in the 4th century, and the Bible was translated into Geez (Ethiopic) thereafter. This Bible was revised in the 14th Century. The first complete Amharic Bible was produced in 1840, and went through several revisions thereafter. The version of the Bible presented here was the fulfillment of the expressed desire of Haile Selassie, and was first published in 1962. \n\nIn 1962, a new Amharic translation from Ge'ez was printed with the patronage of the Emperor Haile Selassie. The preface by Emperor Haile Selassie I is dated '1955' (E.C.), and the 31st year of his reign (i.e. AD 1962 in the Gregorian Calendar), and states that it was translated by the Bible Committee he convened between AD 1947 and 1952, realizing that there ought to be a revision from the original Hebrew and Greek of the existing translation of the Bible \n\nIn 1992-93, with the blessing and support of the Ethiopian Bible Society and Ato Kebede Mamo, the Director, the Bible was computerized by Hiruye Stige and his wife Genet.",
                                },
                                isSelected:
                                    widget.isAmharic == true ? true : false,
                              ),
                            ),
                            for (var eachVersion in bibleVersionsInfo)
                              GestureDetector(
                                onTap: () {
                                  widget.setVersion(eachVersion["ID"]);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: EachVersionButton(
                                  versionData: eachVersion,
                                  isSelected: widget.currentVersion ==
                                              eachVersion["ID"] &&
                                          widget.isAmharic == false
                                      ? true
                                      : false,
                                ),
                              ),
                            const SizedBox(height: 200.0)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
