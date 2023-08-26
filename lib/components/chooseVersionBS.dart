import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybible/components/eachVersionButton.dart';

class ChooseVersionBS extends StatefulWidget {
  const ChooseVersionBS({
    super.key,
    required this.setVersion,
    required this.changeToAmharic,
  });

  final Function setVersion;
  final Function changeToAmharic;

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
        child: bibleVersionsInfo.isEmpty == true
            ? Container()
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
                          "Versions",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                              child: const EachVersionButton(
                                versionData: {
                                  "ID": "AMH",
                                  "title": "Amharic 1954",
                                },
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
                                ),
                              ),
                            SizedBox(height: 200.0)
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
