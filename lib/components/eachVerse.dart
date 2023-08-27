// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class EachVerse extends StatefulWidget {
  const EachVerse({
    super.key,
    required this.verseData,
    required this.fontSize,
    required this.eachNumberFontSize,
  });

  final Map verseData;
  final double fontSize;
  final double eachNumberFontSize;

  @override
  State<EachVerse> createState() => _EachVerseState();
}

class _EachVerseState extends State<EachVerse> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        isSelected = !isSelected;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(),
        padding: const EdgeInsets.only(
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30.0,
              padding: EdgeInsets.only(top: 3.5),
              child: Text(
                "${widget.verseData["ID"]}  ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.eachNumberFontSize,
                  color: isSelected == true
                      ? Colors.lightGreenAccent
                      : Colors.white,
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
                  color: isSelected == true
                      ? Colors.lightGreenAccent
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
