import 'package:flutter/material.dart';

class EachChapterButton extends StatefulWidget {
  const EachChapterButton({super.key, required this.chapter});

  final String chapter;

  @override
  State<EachChapterButton> createState() => _EachChapterButtonState();
}

class _EachChapterButtonState extends State<EachChapterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // width: 200.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
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
        border: Border.all(
          color: Colors.grey[800]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          widget.chapter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
