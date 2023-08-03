import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybible/components/eachVersionButton.dart';

class ChooseVersionBS extends StatefulWidget {
  const ChooseVersionBS({
    super.key,
    required this.setVersion,
  });

  final Function setVersion;

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
            child: bibleVersionsInfo == []
                ? Container()
                : Column(
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
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
