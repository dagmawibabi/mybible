// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EachBookButton extends StatefulWidget {
  const EachBookButton({
    super.key,
    required this.english,
    required this.amharic,
    required this.isSelected,
  });

  final String english;
  final String amharic;
  final bool isSelected;

  @override
  State<EachBookButton> createState() => _EachBookButtonState();
}

class _EachBookButtonState extends State<EachBookButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 15.0,
      ),
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 15.0,
        right: 10.0,
      ),
      clipBehavior: Clip.hardEdge,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.english,
              style: TextStyle(
                color: widget.isSelected == true
                    ? Colors.greenAccent
                    : Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.amharic,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: widget.isSelected == true
                    ? Colors.greenAccent
                    : Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
