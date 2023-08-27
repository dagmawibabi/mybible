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
      // width: double.infinity,
      width: 10.0,
      height: 20.0,
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 5.0,
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      // padding: const EdgeInsets.only(
      //   top: 15.0,
      //   bottom: 15.0,
      //   left: 15.0,
      //   right: 10.0,
      // ),
      decoration: BoxDecoration(
        color: Colors.grey[900]!,
        // border: Border.all(
        //   color: Colors.grey[800]!,
        // ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1.0,
            offset: Offset(2, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
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
      ),
    );
  }
}
