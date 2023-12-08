import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mybible/models/savedVerses.dart';

class EachVerse extends StatefulWidget {
  EachVerse({
    super.key,
    required this.verseData,
    required this.fontSize,
    required this.eachNumberFontSize,
    required this.selectedVerse,
    required this.isIndented,
  });

  bool isIndented = false;
  final Map verseData;
  final double fontSize;
  final double eachNumberFontSize;
  final List<SavedVerse> selectedVerse;

  @override
  State<EachVerse> createState() => _EachVerseState();
}

class _EachVerseState extends State<EachVerse> {
  bool isSelected = false;
  void checkSelection() {
    // Check if verse is selected or not
    bool isFound = false;
    for (SavedVerse eachSelectedVerse in widget.selectedVerse) {
      if (eachSelectedVerse.verse == widget.verseData["text"]) {
        isFound = true;
        break;
      }
    }
    isSelected = isFound;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkSelection();
    if (widget.isIndented) {
      return indentedEachVerse(widget, isSelected);
    } else {
      return normalEachVerse();
    }
  }

  Container indNormalEachVerse() {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.only(
        right: 10.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.verseData.containsKey("isMultiVerse") &&
                    widget.verseData["isMultiVerse"]
                ? null
                : 30.0,
            padding: const EdgeInsets.only(top: 3.5),
            child: Text(
              "${widget.verseData["ID"]}  ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.eachNumberFontSize,
                color:
                    isSelected == true ? Colors.lightGreenAccent : Colors.white,
              ),
            ),
          ),
          Flexible(
            child: Text(
              "${widget.verseData["text"]}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: widget.fontSize,
                height: 1.2,
                color:
                    isSelected == true ? Colors.lightGreenAccent : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container normalEachVerse() {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.only(
        right: 10.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.verseData.containsKey("isMultiVerse") &&
                    widget.verseData["isMultiVerse"]
                ? null
                : 30.0,
            padding: const EdgeInsets.only(top: 3.5),
            child: Text(
              "${widget.verseData["ID"]}  ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.eachNumberFontSize,
                color:
                    isSelected == true ? Colors.lightGreenAccent : Colors.white,
              ),
            ),
          ),
          Flexible(
            child: Text(
              "${widget.verseData["text"]}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: widget.fontSize,
                height: 1.2,
                color:
                    isSelected == true ? Colors.lightGreenAccent : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container indentedEachVerse(EachVerse widget, bool isSelected) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        right: 10.0,
        left: 15.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(children: [
            TextSpan(
              style: TextStyle(
                fontSize: widget.fontSize - 3,
                fontFeatures: const [FontFeature.superscripts()],
                height: 1.2,
                color: isSelected == true ? Colors.white : Colors.grey,
              ),
              text: widget.verseData["ID"].toString().trim(),
            ),
            TextSpan(
                style: TextStyle(
                  fontSize: widget.fontSize - 10,
                ),
                text: "  "),
            TextSpan(
              style: TextStyle(
                fontSize: widget.fontSize,
                height: 1.2,
                color:
                    isSelected == true ? Colors.lightGreenAccent : Colors.white,
              ),
              text: widget.verseData["text"].toString().trim(),
            ),
          ])),
    );
  }
}
