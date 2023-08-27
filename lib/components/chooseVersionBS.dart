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
    // TODO: implement initState
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
                                color: Colors.grey[700]!,
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
                      Container(
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
                                versionData: {
                                  "ID": "አማ",
                                  "title": "አማርኛ 1954",
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
