// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EachBookButton extends StatefulWidget {
  const EachBookButton({
    super.key,
    required this.english,
    required this.amharic,
  });

  final String english;
  final String amharic;

  @override
  State<EachBookButton> createState() => _EachBookButtonState();
}

class _EachBookButtonState extends State<EachBookButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 15.0,
      ),
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 15.0,
        right: 10.0,
      ),
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
        child: Container(
          width: 300.0,
          // height: 100.0,

          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.english,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "  |  ",
                  style: TextStyle(
                    color: Colors.grey[800]!,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  widget.amharic,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
