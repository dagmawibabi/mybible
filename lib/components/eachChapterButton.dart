// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EachChapterButton extends StatefulWidget {
  const EachChapterButton({
    super.key,
    required this.chapter,
    required this.isSelected,
  });

  final String chapter;
  final bool isSelected;

  @override
  State<EachChapterButton> createState() => _EachChapterButtonState();
}

class _EachChapterButtonState extends State<EachChapterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 5.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: Text(
            widget.chapter,
            style: TextStyle(
              color:
                  widget.isSelected == true ? Colors.greenAccent : Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
