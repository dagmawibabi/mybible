// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EachBookButton extends StatefulWidget {
  const EachBookButton({
    super.key,
    required this.book,
    required this.isAmharic,
  });

  final String book;
  final bool isAmharic;

  @override
  State<EachBookButton> createState() => _EachBookButtonState();
}

class _EachBookButtonState extends State<EachBookButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      width: 200.0,
      margin: EdgeInsets.symmetric(
        vertical: widget.isAmharic == true ? 3.0 : 5.0,
        horizontal: 15.0,
      ),
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
        left: 15.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[900]!,
        // border: Border.all(
        //   color: Colors.grey[800]!,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1.0,
            offset: Offset(2, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        widget.book,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
